//
//  CountryTableViewCell.swift
//  FanStat
//
//  Created by Bimal@AppStation on 22/11/22.
//

import UIKit

class CountryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelCountries: UILabel!
    @IBOutlet weak var imageCountryFlag: UIImageView!
    @IBOutlet weak var imageSelectCountry: UIImageView!
    
    var cellModel: CountryTableViewCellModel! {
        didSet {
            setCountryItems()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCountryItems() {
        labelCountries.text = cellModel.getCountryName()
        self.imageCountryFlag.downloadThumpImage(url: cellModel.getCountryFlagImage())
        imageSelectCountry.image = cellModel.isSelected ? UIImage(named: "task") : UIImage(systemName: "profile")
    }
}
