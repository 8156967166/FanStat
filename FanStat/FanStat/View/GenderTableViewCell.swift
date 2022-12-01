//
//  GenderTableViewCell.swift
//  FanStat
//
//  Created by Bimal@AppStation on 21/11/22.
//

import UIKit

class GenderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelGender: UILabel!
    @IBOutlet weak var imageSelectedGender: UIImageView!
    
    var cellModel: GenderTableViewCellModel! {
        didSet {
            setGenderItems()
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
    
    func setGenderItems() {
        labelGender.text = cellModel.getGenderDetail()
        imageSelectedGender.image = cellModel.isSelected ? UIImage(named: "task") : UIImage(systemName: "profile")
    }

}
