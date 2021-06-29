//
//  MockSignUpManager.swift
//  TestExamplesTests
//
//  Created by Anton Panteleimenko on 10.06.2021.
//

import Foundation
@testable import TestExamples

class MockSignUpManager: SignUpManagerProtocol {
    
    var processUserSignupCalled: Bool = false
    
    required init(modelFieldValidator: SignUpValidatorProtocol,
         networkService: SignupNetworkProtocol,
         delegate: SignUpResultDelegateProtocol) {}
    
    func processUserSignup(model: SignUpFieldModelProtocol) {
        processUserSignupCalled = true
    }

}
