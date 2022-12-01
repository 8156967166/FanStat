//
//  GenderTableViewCellModel.swift
//  FanStat
//
//  Created by Bimal@AppStation on 21/11/22.
//

import Foundation
import UIKit

enum GenderCelltype {
    case genderCell
}

class GenderTableViewCellModel {
    var cellType: GenderCelltype = .genderCell
    var identifier: String = "gender.Cell"
    var genderDetails: Gender = Gender([:])
    var isSelected: Bool = false
    
    init(strGender: String, cellType: GenderCelltype) {
        self.cellType = cellType
        self.genderDetails.gender = strGender
        switch cellType {
        case .genderCell:
            identifier = "gender.Cell"
        }
    }
    
    func getGenderDetail() -> String {
        return genderDetails.gender
    }
}
