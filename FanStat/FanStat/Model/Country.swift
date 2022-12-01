//
//  Country.swift
//  FanStat
//
//  Created by Bimal@AppStation on 22/11/22.
//

import Foundation
import UIKit

class Country {
    var id: String = ConstantString.k_EMPTY
    var country_name:String = ConstantString.k_EMPTY
    var code:String = ConstantString.k_EMPTY
    var flag:String = ConstantString.k_EMPTY

    init(_ dict:[String: Any]) {
        self.id = dict.getIntAsStringFromDict(key: "id")
        self.country_name = dict.getString(key: "country_name")
        self.code = dict.getIntAsStringFromDict(key: "code")
        self.flag = dict.getString(key: "flag")
    }
}

