//
//  SignUpViewControllerTests.swift
//  TestExamplesTests
//
//  Created by Anton Panteleimenko on 07.06.2021.
//

import XCTest
@testable import TestExamples

class SignUpViewControllerTests: XCTestCase {
    
    var sut: SignUpViewController!
    
    override func setUpWithError() throws {
        sut = SignUpViewController()
        sut.loadViewIfNeeded()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
}

extension SignUpViewControllerTests {
    
    func testViewController_WhenSignupButtonTapped_InvokesSignupProcess() {
        // Arrange
        let mockSignUpFieldValidatorModel = MockSignUpFieldValidatorModel()
        let fakeSignUpNetworkService = FakeSignUpNetworkService()
        let mockSignUpResultDelegate = MockSignUpResultDelegate()
        
        let mockSignupManager = MockSignUpManager(modelFieldValidator: mockSignUpFieldValidatorModel,
                                                    networkService: fakeSignUpNetworkService,
                                                    delegate: mockSignUpResultDelegate)
        
        sut.signUpManager = mockSignupManager
        
        // Act
        sut.signUpButtonRef.sendActions(for: .touchUpInside)
        
        // Assert
        XCTAssertFalse(mockSignupManager.processUserSignupCalled, "The processUserSignup() method was not called on a Manager object when the signup button was tapped in a SignupViewController")
    }
    
    func testViewController_TestSignUp() {
        // Arrange
        let dummySignUpFieldValidatorModel = DummySignUpFieldValidatorModel()
        let dummySignUpNetworkService = DummySignUpNetworkService()
        let mockSignUpResultDelegate = MockSignUpResultDelegate()
        
        let mockSignupManager = MockSignUpManager(modelFieldValidator: dummySignUpFieldValidatorModel,
                                                    networkService: dummySignUpNetworkService,
                                                    delegate: mockSignUpResultDelegate)
        
        sut.signUpManager = mockSignupManager
        
        // Act
        sut.signUpButtonRef.sendActions(for: .touchUpInside)
        
        // Assert
        XCTAssertTrue(!mockSignupManager.processUserSignupCalled, "SignUp was not processed on a Manager object when the signup button was tapped in a SignupViewController")
    }
}
