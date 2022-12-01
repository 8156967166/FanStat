//
//  Validation.swift
//  FanStat
//
//  Created by Bimal@AppStation on 22/11/22.
//

import Foundation
class Validation {
        public func validateFirstName(firstName: String) ->Bool {
              let nameRegex = "[A-Za-z]{2,}"
              let trimmedString = firstName.trimmingCharacters(in: .whitespaces)
              let validateName = NSPredicate(format: "SELF MATCHES %@", "^(([^ ]?)(^[a-zA-Z].*[a-zA-Z]$)([^ ]?))$", nameRegex)
              let isValidateName = validateName.evaluate(with: trimmedString)
              return isValidateName
        }
        public func validateLastName(lastName: String) ->Bool {
            let nameRegex = "[A-Za-z]{2,}"
            let trimmedString = lastName.trimmingCharacters(in: .whitespaces)
            let validateName = NSPredicate(format: "SELF MATCHES %@", "^(([^ ]?)(^[a-zA-Z].*[a-zA-Z]$)([^ ]?))$", nameRegex)
            let isValidateName = validateName.evaluate(with: trimmedString)
            return isValidateName
        }
        public func validateEmailId(emailID: String) -> Bool {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let trimmedString = emailID.trimmingCharacters(in: .whitespaces)
            let validateEmail = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            let isValidateEmail = validateEmail.evaluate(with: trimmedString)
            return isValidateEmail
        }
        public func validatePhoneNumber(phoneNumber: String) -> Bool {
           let phoneNumberRegex = "^[6-9]\\d{9}$"
           let trimmedString = phoneNumber.trimmingCharacters(in: .whitespaces)
           let validatePhone = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
           let isValidPhone = validatePhone.evaluate(with: trimmedString)
           return isValidPhone
        }
    public func validatePassword(password: String) -> Bool {
        let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{8,}$"
        let trimmedString = password.trimmingCharacters(in: .whitespaces)
        let validatePassword = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        let isValidatePassword = validatePassword.evaluate(with: trimmedString)
        return isValidatePassword
    }
    public func validateCountryCode(code: String) -> Bool {
        let countryCodeRegex = "^[1-3]\\d{3}$"
        let trimmedString = code.trimmingCharacters(in: .whitespaces)
        let validateCode = NSPredicate(format: "SELF MATCHES %@", countryCodeRegex)
        let isValidateCode = validateCode.evaluate(with: trimmedString)
        return isValidateCode
        
    }
}


