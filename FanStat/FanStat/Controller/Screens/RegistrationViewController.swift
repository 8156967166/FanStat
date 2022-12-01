//
//  RegistrationViewController.swift
//  FanStat
//
//  Created by Bimal@AppStation on 21/11/22.
//

import UIKit
import SJFrameSwift

class RegistrationViewController: SJViewController {
    
    //MARK: - Variables
    
    @IBOutlet weak var textFieldFirstName: UITextField!
    @IBOutlet weak var textFieldLastName: UITextField!
    @IBOutlet weak var labelGender: UILabel!
    @IBOutlet weak var labelCountry: UILabel!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textFieldConfirmPassword: UITextField!
    @IBOutlet weak var viewFirstNameError: UIView!
    @IBOutlet weak var viewLastNameError: UIView!
    @IBOutlet weak var viewEmailError: UIView!
    @IBOutlet weak var viewPasswordError: UIView!
    @IBOutlet weak var viewConfirmPasswordError: UIView!
    @IBOutlet weak var labelPasswordShowHide: UILabel!
    @IBOutlet weak var labelConfirmPasswordShowHide: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var buttonGender: UIButton!
    @IBOutlet weak var buttonCountry: UIButton!
    @IBOutlet weak var labelConfirmPassword: UILabel!
    @IBOutlet weak var labelTermsAndPrivacy: UILabel!
    @IBOutlet weak var viewRegisterButton: UIView!
    
    //MARK: - Variables
    
    var clickPasswordbutton = true
    var clickConfirmPasswordbutton = true
    var cellModelFromGender: GenderTableViewCellModel!
    var cellModelGenderPass: GenderTableViewCellModel!
    var cellModelFromCountry: CountryTableViewCellModel!
    var cellModelCountryPass: CountryTableViewCellModel!
    var validation = Validation()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notificationKeyboard()
        viewFirstNameError.isHidden = true
        viewLastNameError.isHidden = true
        viewEmailError.isHidden = true
        viewPasswordError.isHidden = true
        viewConfirmPasswordError.isHidden = true
        
        viewRegisterButton.layer.shadowColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1).cgColor
        viewRegisterButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        viewRegisterButton.layer.shadowOpacity = 1.0
        
        // Create a new Attributed String
        let attributedString = NSMutableAttributedString.init(string: "By signing in, you agree to the Terms of Service and Privacy Policy")

        // Add Underline Style Attribute.
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range:
            NSRange.init(location: 0, length: attributedString.length));
        labelTermsAndPrivacy.attributedText = attributedString
        
        // Do any additional setup after loading the view.
    }
    
    //MARK: - KeyBoardDelegates
    
    func notificationKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
           var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
           keyboardFrame = self.view.convert(keyboardFrame, from: nil)

        var contentInset:UIEdgeInsets = self.scrollView.contentInset
            contentInset.bottom = keyboardFrame.size.height + 20
            scrollView.contentInset = contentInset
    }
    
    @objc func keyboardWillHide(notifiaction: NSNotification) {
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
    
    // MARK: - Button Actions
    
    @IBAction func backArrowButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func genderButtonAction(sender: UIButton) {
        if cellModelFromGender?.isSelected == true {
            cellModelGenderPass = cellModelFromGender
            performSegue(withIdentifier: "GenderSelectionViewController", sender: nil)
            
        }
        
        else {
            performSegue(withIdentifier: "GenderSelectionViewController", sender: nil)
        }
    }
    
    @IBAction func countryButtonAction(sender: UIButton) {
        if cellModelFromCountry?.isSelected == true {
            cellModelCountryPass = cellModelFromCountry
            performSegue(withIdentifier: "CountryViewController", sender: nil)
        }
        
        else {
            performSegue(withIdentifier: "CountryViewController", sender: nil)
        }
    }
    
    @IBAction func passwordShowHideButtonAction(_ sender: Any) {
        if(clickPasswordbutton == true) {
            textFieldPassword.isSecureTextEntry = false
            labelPasswordShowHide.text = "Hide"
        } else {
           textFieldPassword.isSecureTextEntry = true
            labelPasswordShowHide.text = "Show"
        }

        clickPasswordbutton = !clickPasswordbutton
    }
    
    @IBAction func confirmPasswordShowHideButtonAction(_ sender: Any) {
        if(clickConfirmPasswordbutton == true) {
            textFieldConfirmPassword.isSecureTextEntry = false
            labelConfirmPasswordShowHide.text = "Hide"
        } else {
            textFieldConfirmPassword.isSecureTextEntry = true
            labelConfirmPasswordShowHide.text = "Show"
        }

        clickConfirmPasswordbutton = !clickConfirmPasswordbutton
    }
    
    @IBAction func RegisterButtonAction(_ sender: Any) {
//        callRegisterApi()
//        return;
        viewFirstNameError.isHidden = true
        viewLastNameError.isHidden = true
        viewEmailError.isHidden = true
        viewPasswordError.isHidden = true
        viewConfirmPasswordError.isHidden = true
        
        guard let firstName = textFieldFirstName.text, let lastName = textFieldLastName.text, let email = textFieldEmail.text, let password = textFieldPassword.text
        else {
            return
        }
        let isValidateFirstName = self.validation.validateFirstName(firstName: firstName)
        if(isValidateFirstName == false) {
           print("Invalid First Name")
            viewFirstNameError.isHidden = false
        }
        let isValidateLastName = self.validation.validateLastName(lastName: lastName)
        if(isValidateLastName == false) {
            print("Invalid Last Name")
            viewLastNameError.isHidden = false
        }
        let isValidateEmail = self.validation.validateEmailId(emailID: email)
        if isValidateEmail == false {
            print("Invalid email")
            viewEmailError.isHidden = false
        }
        let isValidatePassword = self.validation.validatePassword(password: password)
        if isValidatePassword == false {
            print("Invalid password")
            viewPasswordError.isHidden = false
        }
        if textFieldConfirmPassword.text == "" {
            viewConfirmPasswordError.isHidden = false
        }
        else {
            if textFieldConfirmPassword.text != textFieldPassword.text {
                viewConfirmPasswordError.isHidden = false
                labelConfirmPassword.text = "passwords not matching"
            }
        }
            
        if (isValidateFirstName == true && isValidateLastName == true && isValidateEmail == true && isValidatePassword == true) {
            if textFieldPassword.text == textFieldConfirmPassword.text {
                print("Password Match")
                callRegisterApi()
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "GenderSelectionViewController" {
            let genderVc = segue.destination as! GenderSelectionViewController
            genderVc.delegate = self
            genderVc.cellModelFromRegisterationToGenderVc = cellModelGenderPass
        }
        
        if segue.identifier == "CountryViewController" {
            let countryVc = segue.destination as! CountryViewController
            countryVc.delegate = self
            countryVc.cellModelFromRegisterationToCountryVc = cellModelCountryPass
        }
        
    }
}

// MARK: - TextFieldDelegates

extension RegistrationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        self.view.endEditing(true)
        return true;
    }
}

// MARK: - CustomTextFieldLocalDelegate

extension RegistrationViewController: CustomTextFieldLocalDelegate {
    func didClickedFieldNextButton(_ textField: CustomTextFieldLocal) {
        print("didClickedFieldNextButton...")
        if textField == textFieldFirstName {
            textFieldLastName.becomeFirstResponder()
        }
        else if textField == textFieldLastName {
            self.performSegue(withIdentifier: "GenderSelectionViewController", sender: nil)
//            textFieldEmail.becomeFirstResponder()
        }
//        else if textField == labelGender {
//            labelCountry.becomeFirstResponder()
//            self.performSegue(withIdentifier: "CountryViewController", sender: nil)
//        }
//        else if textField == labelCountry {
//            if labelCountry.text != "" {
//                textFieldEmail.becomeFirstResponder()
//            }
//        }
        else if textField == textFieldEmail {
            textFieldPassword.becomeFirstResponder()
        }
        else if textField == textFieldPassword {
            textFieldConfirmPassword.becomeFirstResponder()
        }
        else if textField == textFieldConfirmPassword {
            textFieldConfirmPassword.resignFirstResponder()
        }
        
    }
    
    func didClickedFieldDoneButton(_ textField: CustomTextFieldLocal) {
        print("didClickedFieldDoneButton...")
    }
}


extension RegistrationViewController: DatapassToRegistrationVCDelegate, DatapassToRegistrationDelegate {
    func cellModel(cellModelInCountry: CountryTableViewCellModel) {
        cellModelFromCountry = cellModelInCountry
        labelCountry.text = cellModelInCountry.countryDetails.country_name
        labelCountry.textColor = .black
        countryButtonAction(sender: buttonCountry)
    }
    
    func cellModel(cellModelInGender: GenderTableViewCellModel) {
        cellModelFromGender = cellModelInGender
        labelGender.text = cellModelInGender.genderDetails.gender
        labelGender.textColor = .black
        genderButtonAction(sender: buttonGender)
       
    }
}


// MARK: - callApi

extension RegistrationViewController {
    func callRegisterApi() {
        if AppController.shared.checkInternetAvailability() {
            let nwctrl = APINetworkController();
            let objRequest = AppBaseRequest(ConstantAPI.WEBSERVICE_USER_REGISTRATION, ConstantAPI.k_REQUEST_TYPE_POST);
            objRequest.addParam(key: "first_name", value: textFieldFirstName.text ?? "")
            objRequest.addParam(key: "last_name", value: textFieldLastName.text ?? "")
            objRequest.addParam(key: "email", value: textFieldEmail.text ?? "")
            objRequest.addParam(key: "password", value: textFieldPassword.text ?? "")
            objRequest.addParam(key: "password_confirmation", value: textFieldConfirmPassword.text ?? "")
            objRequest.addParam(key: "terms_conditions", value: "1")

            self.showLoader()
            nwctrl.callWebserviceRequest(objRequest) { objResponse in
                if objResponse.api_status == true {
                    self.hideLoader()
                    self.showAlert(message: "Success")
                    
                }
                else {
                    self.hideLoader()
                    if let errors = objResponse.errors as? [String:Any] {
                        print(errors)
                        if let email = errors["email"] as? [String], !email.isEmpty {
                            print(email[0])
                            DispatchQueue.main.async {
                                if (self.textFieldEmail.text ?? "").isEmpty {
                                    self.viewEmailError .isHidden = false
                                }
                            }
                        }
                    }
                    else if let message = objResponse.errorMsg as? String {
                        print(message)
                        self.showAlert(message: objResponse.errorMsg)
                    }
                    self.showAlert(message: "Error")
                }
            }
        }
        else {
            self.showAlert(message: "Network Error")
        }
    }
}
    
