//
//  SignUpValidatorProtocol.swift
//  TestExamples
//
//  Created by Anton Panteleimenko on 09.06.2021.
//

protocol SignUpValidatorProtocol {
    
    func isFirstNameValid(firstName: String) -> Bool
    func isLastNameValid(lastName: String) -> Bool
    func isEmailValid(email: String) -> Bool
    func isPasswordValid(password: String) -> Bool
}
