//
//  SignUpFieldValidatorModel.swift
//  TestExamples
//
//  Created by Anton Panteleimenko on 09.06.2021.
//

import Foundation

public enum ValidationConstants {
    static let firstNameFieldCharacterLength = (min: 3, max: 12)
    static let lastNameFieldCharacterLength = (min: 3, max: 15)
    static let passwordFieldCharacterLength = (min: 5, max: 15)
}

class SignUpFieldValidatorModel: SignUpValidatorProtocol {
    
    func isFirstNameValid(firstName: String) -> Bool {
        
        guard firstName.count < ValidationConstants.firstNameFieldCharacterLength.min || firstName.count > ValidationConstants.firstNameFieldCharacterLength.max else {
            return true
        }
        
        return false
    }
    
    func isLastNameValid(lastName: String) -> Bool {
        
        guard lastName.count < ValidationConstants.lastNameFieldCharacterLength.min || lastName.count > ValidationConstants.lastNameFieldCharacterLength.max else {
            return true
        }
        
        return false
    }
    
    func isEmailValid(email: String) -> Bool {
        return NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: email)
    }
    
    func isPasswordValid(password: String) -> Bool {
        
        guard password.count < ValidationConstants.passwordFieldCharacterLength.min || password.count > ValidationConstants.passwordFieldCharacterLength.max else {
            return true
        }
        
        return false
    }
}
