//
//  MockSignUpResultDelegate.swift
//  TestExamplesTests
//
//  Created by Anton Panteleimenko on 10.06.2021.
//

import Foundation
import XCTest
@testable import TestExamples

class MockSignUpResultDelegate: SignUpResultDelegateProtocol {
    var expectation: XCTestExpectation?
    var successfulSignupCounter = 0
    var errorHandlerCounter = 0
    var signupError: SignUpErrorHandler?
    
    func successfullSignup() {
        successfulSignupCounter += 1
        expectation?.fulfill()
    }
    
    func errorHandler(error: SignUpErrorHandler) {
        signupError = error
        errorHandlerCounter += 1
        expectation?.fulfill()
    }
 
}
