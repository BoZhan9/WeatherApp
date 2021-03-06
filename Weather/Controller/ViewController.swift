//
//  ViewController.swift
//  Weather
//
//  Created by Ashish Ashish on 10/28/21.
//

import UIKit
import RealmSwift
import Alamofire
import SwiftyJSON
import SwiftSpinner
import PromiseKit
import RealmSwift

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var lblLocalizedName: UILabel!
    @IBOutlet weak var lblTemperature: UILabel!
    
    @IBOutlet weak var imgWeather: UIImageView!
    @IBOutlet weak var tblView: UITableView!
    
    var arrCityInfo: [CityInfo] = [CityInfo]()
    var arrCurrentWeather : [CurrentWeather] = [CurrentWeather]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.delegate = self
        tblView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadCurrentConditions()
        

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrCurrentWeather.count // You will replace this with arrCurrentWeather.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(arrCurrentWeather[indexPath.row].cityInfoName) \(arrCurrentWeather[indexPath.row].temp) °F, \(arrCurrentWeather[indexPath.row].weatherText)"
        return cell
    }
    
    func loadCitiesFromDB() {
        do {
            arrCityInfo = [CityInfo]()
            let realm = try Realm()
            let cities = realm.objects(CityInfo.self);
            for city in cities {
                arrCityInfo.append(city)
            }
            tblView.reloadData()
        } catch {
            print ("Error in loading cities from DB")
        }
    }
    
    @IBAction func addCity(_ sender: Any) {
    }
    
    func loadCurrentConditions(){
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        // Read all the values from realm DB and fill up the arrCityInfo
        // for each city info het the city key and make a NW call to current weather condition
        // wait for all the promises to be fulfilled
        // Once all the promises are fulfilled fill the arrCurrentWeather array
        // call for reload of tableView
        
        do{
            let realm = try Realm()
            let cities = realm.objects(CityInfo.self)
            self.arrCityInfo.removeAll()
            getAllCurrentWeather(Array(cities)).done { currentWeather in
                self.arrCurrentWeather = currentWeather
                self.tblView.reloadData()
            }
            .catch { error in
               print(error)
            }
       }catch{
           print("Error in loading cities from DB")
       }
    }
  
    func getAllCurrentWeather(_ cities: [CityInfo] ) -> Promise<[CurrentWeather]> {
            
        var promises: [Promise< CurrentWeather>] = []
    
        if (cities.isEmpty) {
            return when(fulfilled: promises)
        }
        
        for i in 0 ... cities.count - 1 {
            promises.append(getCurrentWeather(cities[i].key, cities[i]))
        }
        
        return when(fulfilled: promises)
            
    }
    
    
    func getCurrentWeather(_ cityKey : String, _ cityInfo: CityInfo) -> Promise<CurrentWeather>{
        return Promise<CurrentWeather> { seal -> Void in
            let url = currentConditionURL + cityKey + "?apikey=" + apiKey
            
            AF.request(url).responseJSON { response in
                
                if response.error != nil {
                    seal.reject(response.error!)
                }
                
                let currentWeather = JSON( response.data!).arrayValue[0]

                let currWeather = CurrentWeather()

                currWeather.cityKey = cityInfo.key
                currWeather.cityInfoName = cityInfo.localizedName
                currWeather.weatherText = currentWeather["WeatherText"].stringValue
                currWeather.epochTime = currentWeather["EpochTime"].intValue
                currWeather.isDayTime = currentWeather["IsDayTime"].boolValue
                currWeather.temp = currentWeather["Temperature"]["Imperial"]["Value"].intValue
                currWeather.tempType = currentWeather["Temperature"]["Imperial"]["Unit"].stringValue
                currWeather.weatherIcon = currentWeather["WeatherIcon"].intValue
                
                //self.arrCurrentWeather.append(currWeather)
                
                
                seal.fulfill(currWeather)
                
            }
        }
        
    }
    
    func deleteCity(_ city : CityInfo) {
        do {
            let realm = try Realm()
            try realm.write ({
                    realm.delete(city)
                })
        } catch {
            print("Error in deleting city")
        }
    }
    
//    func getWeatherIcon(_ forcast: String) -> UIImage{
//        let img = UIImage(named: "01-s")!
//        let dayTime = cityInfo.isDayTime()
//        if dayTime {
//            guard let dayImage = dayIcons[forcast] else {return img}
//            return dayImage
//        }
//
//        guard let nightImage = nightIcons[forcast] else {return img}
//        return nightImage
//    }
    
}

