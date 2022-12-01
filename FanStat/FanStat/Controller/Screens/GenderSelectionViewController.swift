//
//  GenderSelectionViewController.swift
//  FanStat
//
//  Created by Bimal@AppStation on 21/11/22.
//

import UIKit

protocol DatapassToRegistrationVCDelegate {
    
    func cellModel(cellModelInGender: GenderTableViewCellModel)

}

class GenderSelectionViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    var delegate: DatapassToRegistrationVCDelegate?
    var genderArray: [GenderTableViewCellModel] = [GenderTableViewCellModel]()
    var cellModelFromRegisterationToGenderVc: GenderTableViewCellModel!
    
    
    // MARK: - LifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        setGenderModel()
        // Do any additional setup after loading the view.
    }
    
    func setGenderModel() {
        let male = GenderTableViewCellModel(strGender: "Male", cellType: .genderCell)
        let female = GenderTableViewCellModel(strGender: "Female", cellType: .genderCell)
        genderArray.append(male)
        genderArray.append(female)
        
        for gender in genderArray {
            if gender.genderDetails.gender ==  cellModelFromRegisterationToGenderVc?.getGenderDetail() {
                gender.isSelected = true
            }
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    // MARK: - Button Action
    
    @IBAction func closeButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - TableView

extension GenderSelectionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        genderArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = genderArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellModel.identifier, for: indexPath) as! GenderTableViewCell
        cell.cellModel = cellModel
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let cellModel = genderArray[indexPath.row]

        for model in genderArray {
            model.isSelected = false
        }

        cellModel.isSelected = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.dismiss(animated: true, completion: nil)
        }
       
        tableView.reloadData()
        
        delegate?.cellModel(cellModelInGender: cellModel)
       
    }
    
    
}
