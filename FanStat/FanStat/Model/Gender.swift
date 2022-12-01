//
//  Gender.swift
//  FanStat
//
//  Created by Bimal@AppStation on 21/11/22.
//

import Foundation
import UIKit

class Gender: NSObject {
    var id:String = ConstantString.k_EMPTY
    var gender:String = ConstantString.k_EMPTY
    
    init(_ dict:[String: Any]) {
        self.id = dict.getIntAsStringFromDict(key: "id")
        self.gender = dict.getString(key: "gender")
    }   
}
