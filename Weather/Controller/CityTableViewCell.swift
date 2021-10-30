//
//  CityTableViewCell.swift
//  Weather
//
//  Created by Brian Zhang on 10/29/21.
//

import UIKit

class CityTableViewCell: UITableViewCell {

    @IBOutlet weak var lblLocalizedName: UILabel!
    @IBOutlet weak var lbllblAdministrativeID: UILabel!
    @IBOutlet weak var lblCountryLocalizedName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

