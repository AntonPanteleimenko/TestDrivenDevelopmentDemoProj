//
//  DummySignUpFieldValidatorModel.swift
//  TestExamplesTests
//
//  Created by Anton Panteleimenko on 11.06.2021.
//

import Foundation
@testable import TestExamples

class DummySignUpFieldValidatorModel: SignUpValidatorProtocol {
    func isFirstNameValid(firstName: String) -> Bool { return true }
    func isLastNameValid(lastName: String) -> Bool { return true }
    func isEmailValid(email: String) -> Bool { return true }
    func isPasswordValid(password: String) -> Bool { return true }
}
