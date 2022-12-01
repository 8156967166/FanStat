//
//  CountryTableViewCellModel.swift
//  FanStat
//
//  Created by Bimal@AppStation on 22/11/22.
//

import Foundation
import UIKit

enum CountryCelltype {
    case countryCell
}

class CountryTableViewCellModel {
    var cellType: CountryCelltype = .countryCell
    var identifier: String = "country.Cell"
    var countryDetails: Country = Country([:])
    var isSelected: Bool = false
    
    init(cellType: CountryCelltype, responseModel: Country) {
        self.cellType = cellType
        self.countryDetails = responseModel
        switch cellType {
        case .countryCell:
            identifier = "country.Cell"
        }
    }
    
    func getCountryName() -> String {
        return countryDetails.country_name
    }
    
    func getCountryFlagImage() -> String {
        return countryDetails.flag
    }
}
