
//  ExtensionsManager.swift
//  PrjctQsl
//
//  Created by Bimal@AppStation on 06/07/22.
//

import UIKit
import SJFrameSwift

//MARK: - View Controllers
extension UIViewController {
    func removeDuplicateInstanceOfSelf() {
        //If we push save VC again, and remove the previous copy
        //Call it after push
        let sameVCPrevInstance = ((self.navigationController?.viewControllers.count ?? -1) - 1) - 1
        //Since Instance - 1 => Current Index; Index - 1 = Previous
        if (sameVCPrevInstance > 0) {
            self.navigationController?.viewControllers.remove(at: sameVCPrevInstance)
        }
    }
    
    func showAlert(title:String? = "Alert", message:String,completion:((Bool)->())? = nil) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                completion?(true)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

//MARK: - Views
extension UIView{
    func rotate() {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 50.0
//        rotation.isCumulative = false
        rotation.repeatCount = Float.greatestFiniteMagnitude
        layer.add(rotation, forKey: "rotationAnimation")
    }
    
}
extension Dictionary where Key == String {
func toJSON() -> String {
        if let theJSONData = try? JSONSerialization.data(withJSONObject: self, options: []) {
            if let theJSONText = String(data: theJSONData, encoding: .ascii) {
                return theJSONText
            }
        }
        return ConstantString.k_EMPTY
    }
}

extension Dictionary where Key == String {
    
    func getBoolFromDict(key:String)->Bool {
        if let objectValue = self[key] as? Bool  {
            return objectValue
        }else if let objectValue = self[key] as? Int  {
            return (objectValue == 1) ? true : false
        }else if let objectValue = self[key] as? String  {
            return (objectValue == "1") ? true : false
        }
        return false
    }
    
    func getIntAsStringFromDict(key:String)->String {
        if let objectValue = self[key] as? Int  {
            return "\(objectValue)"
        }else if let objectValue = self[key] as? String  {
            return objectValue
        }
        return ""
    }
    
    func getAmountAsStringFromDict(key:String)->String {
        if let objectValue = self[key] as? Int  {
            return "\(objectValue)"
        }else if let objectValue = self[key] as? Double  {
            return "\(objectValue)"
        }else if let objectValue = self[key] as? Float  {
            return "\(objectValue)"
        }else if let objectValue = self[key] as? String  {
            return objectValue
        }
        return ""
    }
    
    func getString(key:String)->String {
        return self[key] as? String ?? ""
    }
    
    func getDict(key:String)->[String:Any] {
        return self[key] as? [String:Any] ?? [:]
    }
    
    func getInt(key:String)->Int {
        if let objectValue = self[key] as? Int  {
            return objectValue
        }else if let objectValue = self[key] as? String  {
            return Int(objectValue) ?? 0
        }else if let objectValue = self[key] as? Double  {
            return Int(objectValue)
        }
        return 0
    }
    
    func getFloat(key:String) ->Float {
        if let objectValue = self[key] as? Int  {
            return Float(objectValue)
        }else if let objectValue = self[key] as? Double  {
            return Float(objectValue)
        }else if let objectValue = self[key] as? Float  {
            return objectValue
        }else if let objectValue = self[key] as? String  {
            return Float(objectValue) ?? 0
        }
        return 0
    }
}

extension UITableView {
    func reloadInMainQueue() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
}

extension String {
    func spaceRemoved() -> String {
        return self.replacingOccurrences(of: " ", with: "%20")
    }
}
