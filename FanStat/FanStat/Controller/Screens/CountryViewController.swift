//
//  CountryViewController.swift
//  FanStat
//
//  Created by Bimal@AppStation on 22/11/22.
//

import UIKit
import SJFrameSwift

protocol DatapassToRegistrationDelegate {
    
    func cellModel(cellModelInCountry: CountryTableViewCellModel)

}

class CountryViewController: SJViewController, UITextFieldDelegate {
    
    //MARK: - Outlet
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var txtSearchBar: UITextField!
    
    //MARK: - VAriables
    
    var delegate: DatapassToRegistrationDelegate?
    var countryDetailsResponse = [Country]()
    var countryArray = [CountryTableViewCellModel]()
    var cellModelFromRegisterationToCountryVc: CountryTableViewCellModel!
    var searchArray = [CountryTableViewCellModel]()
    
    //MARK: - LifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        callCountryAPI()
        createCellModel()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - CellModel
    
   func createCellModel() {
       countryArray = []
       for country in countryDetailsResponse {
           let countryModel = CountryTableViewCellModel(cellType: .countryCell, responseModel: country)
           countryArray.append(countryModel)
       }
       
       for country in countryArray {
           if country.countryDetails.country_name ==  cellModelFromRegisterationToCountryVc?.getCountryName(){
               country.isSelected = true
           }
       }
       
       for country in countryArray {
           searchArray.append(country)
       }
        txtSearchBar.delegate = self
       
       DispatchQueue.main.async {
           self.tableView.reloadData()
       }
    }
    
    // MARK: - TextFieldDelegates
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        
        txtSearchBar.resignFirstResponder()
        txtSearchBar.text = ""
        self.searchArray.removeAll()
        for country in countryArray {
            searchArray.append(country)
        }
        tableView.reloadData()
        return false

    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if txtSearchBar.text?.count != 0 {
            self.searchArray.removeAll()
            for country in countryArray {
                let range = country.countryDetails.country_name.lowercased().range(of: textField.text!, options: .caseInsensitive, range: nil, locale: nil)
                    if range != nil {
                        self.searchArray.append(country)
                    }
            }
        }
        tableView.reloadData()
        self.view.endEditing(true)
        return true
    }
    
    // MARK: - Button Action
    
    @IBAction func closeButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}

//MARK: - TableView

extension CountryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = searchArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellModel.identifier, for: indexPath) as!  CountryTableViewCell
        cell.cellModel = cellModel
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellModel = searchArray[indexPath.row]

        for model in searchArray {
            model.isSelected = false
        }

        cellModel.isSelected = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.dismiss(animated: true, completion: nil)
        }
       
        tableView.reloadData()
        
        delegate?.cellModel(cellModelInCountry: cellModel)
    }

}

//MARK: - CountryApiCall

extension CountryViewController {
    func callCountryAPI() {
        if AppController.shared.checkInternetAvailability() {
            let nwctrl = APINetworkController();
            let apiService = ConstantAPI.WEBSERVICE_COUNTRIES_SERVICE
            let objRequest = AppBaseRequest(apiService, ConstantAPI.k_REQUEST_TYPE_GET);
//            self.showLoader()
            nwctrl.callWebserviceRequest(objRequest) { objResponse in
                if objResponse.api_status == true {
//                    self.hideLoader()
                    if let result = objResponse.resultData as? [[String: Any]] {
                        print(result)
                        DispatchQueue.main.async {
                            for country in result {
                                self.countryDetailsResponse.append(Country(country))
                            }
                            self.createCellModel()
                        }
                    }
                }
                else {
//                    self.hideLoader()
                    if let errors = objResponse.errors as? [String:Any] {
                        print(errors)
                        if let email = errors["email"] as? [String], !email.isEmpty {
                            print(email[0])
                        }
                    }
                    else if let message = objResponse.errorMsg as? String {
                        print(message)
                        self.showAlert(message: objResponse.errorMsg)
                    }
//                    self.showAlert(message: "Error")
                }
            }
        }
        else {
            self.showAlert(message: "Network Error")
        }
    
    }
  
}
    
 
