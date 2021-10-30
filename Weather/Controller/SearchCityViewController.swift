//
//  SearchCityViewController.swift
//  Weather
//
//  Created by Ashish Ashish on 10/28/21.
//

import UIKit
import SwiftyJSON
import SwiftSpinner
import Alamofire
import PromiseKit
import RealmSwift

class SearchCityViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
       
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tblView: UITableView!
    
    
    var arrCityInfo : [CityInfo] = [CityInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        // Do any additional setup after loading the view.
    }
    

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            arrCityInfo = [CityInfo]()
            tblView.reloadData()
            return
        }
        
        if searchText.count < 3 {
            return
        }
        getCitiesFromSearch(searchText)
    }
    
    func getSearchURL(_ searchText : String) -> String{
        return locationSearchURL + "apikey=" + apiKey + "&q=" + searchText
    }
    
    func getCitiesFromSearch(_ searchText : String) {
        // Network call from there
        let url = getSearchURL(searchText)
        
        // You will receive JSON array
        // Parse the JSON array
        // Add values in arrCityInfo
        // Reload table with the values
        
        AF.request(url).responseJSON { response in
            
            if response.error != nil {
                print(response.error?.localizedDescription as Any)
            }
            
            let cities: [JSON] = JSON( response.data!).arrayValue
            self.arrCityInfo = [CityInfo]()
            for city in cities {
                let cityInfo = CityInfo()
                let key = city["Key"].stringValue
                let type = city["Type"].stringValue
                let localizedName = city["LocalizedName"].stringValue
                let administrativeID = city["AdministrativeArea"]["ID"].stringValue
                let countryLocalizedName = city["Country"]["LocalizedName"].stringValue
                cityInfo.key = key
                cityInfo.type = type
                cityInfo.localizedName = localizedName
                cityInfo.administrativeID = administrativeID
                cityInfo.countryLocalizedName = countryLocalizedName
                self.arrCityInfo.append(cityInfo)
            }
            print(self.arrCityInfo)
            self.tblView.reloadData()
            
        }
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // You will change this to arrCityInfo.count
        return arrCityInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // You will change this to getr values from arrCityinfo and assign text
        cell.textLabel?.text = "\(arrCityInfo[indexPath.row].localizedName), \(arrCityInfo[indexPath.row].administrativeID), \(arrCityInfo[indexPath.row].countryLocalizedName)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // You will get the Index of the city info from here and then add it into the realm Database
        // Once the city is added in the realm DB pop the navigation view controller
        
        let city = arrCityInfo[indexPath.row]
        let alert = UIAlertController(title: "Confirm", message: "Add \(city.localizedName)", preferredStyle: .alert)
        
        let yes = UIAlertAction(title: "Yes", style: .default) { (action) in
            self.addCitytoDB(city)
            self.navigationController?.popViewController(animated: true)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            print("Cancel")
        }
        
        alert.addAction(yes)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    func doesCityExistInDB(_ symbol : String) -> Bool {
        do{
            let realm = try Realm()
            if realm.object(ofType: CityInfo.self, forPrimaryKey: symbol) != nil { return true }

        }catch{
            print("Error in writing values to DB \(error)")
        }
        return false
    }

    func addCitytoDB(_ city : CityInfo){
        do{
            let realm = try Realm()
            try realm.write {
                realm.add(city, update: .all)
            }
        }catch{
            print("Error in writing values to DB \(error)")
        }
    }
}
