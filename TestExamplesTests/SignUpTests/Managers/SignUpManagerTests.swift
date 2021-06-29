//
//  SignUpManagerTests.swift
//  TestExamplesTests
//
//  Created by Anton Panteleimenko on 09.06.2021.
//

import XCTest
@testable import TestExamples

class SignUpManagerTests: XCTestCase {
    
    var signUpFieldModel: StubSignUpFieldModel!
    var mockSignupModelValidator: MockSignUpFieldValidatorModel!
    var fakeSignUpNetworkService: FakeSignUpNetworkService!
    var mockSignUpResultDelegate: MockSignUpResultDelegate!
    var sut: SignUpManager!
    
    override func setUpWithError() throws {
        signUpFieldModel = StubSignUpFieldModel()
        mockSignupModelValidator = MockSignUpFieldValidatorModel()
        fakeSignUpNetworkService = FakeSignUpNetworkService()
        mockSignUpResultDelegate = MockSignUpResultDelegate()
        sut = SignUpManager(modelFieldValidator: mockSignupModelValidator,
                            networkService: fakeSignUpNetworkService,
                            delegate: mockSignUpResultDelegate)
    }
    
    override func tearDownWithError() throws {
        signUpFieldModel = nil
        mockSignupModelValidator = nil
        fakeSignUpNetworkService = nil
        mockSignUpResultDelegate = nil
        sut = nil
    }
    
    func testSignupManager_WithTextFromFields_WillValidateEachValue() {
        // Arrange
        
        // Act
        sut.processUserSignup(model: signUpFieldModel)
        
        // Assert
        XCTAssertTrue(mockSignupModelValidator.isFirstNameValidated,"First name was not validated")
        XCTAssertTrue(mockSignupModelValidator.isLastNameValidated, "Last name was not validated")
        XCTAssertTrue(mockSignupModelValidator.isEmailValidated, "Email format was not validated")
        XCTAssertTrue(mockSignupModelValidator.isPasswordValidated, "Password was not validated")
    }
    
    func testSignupManager_WithTextFromFields_WillFailValidation() {
        // Arrange
        
        let model = signUpFieldModel.returnEmptyStub()
        // Act
        sut.processUserSignup(model: model)
        
        // Assert
        XCTAssertFalse(!mockSignupModelValidator.isFirstNameValidated,"First name was validated")
        XCTAssertFalse(!mockSignupModelValidator.isLastNameValidated, "Last name was validated")
        XCTAssertFalse(!mockSignupModelValidator.isEmailValidated, "Email format was validated")
        XCTAssertFalse(!mockSignupModelValidator.isPasswordValidated, "Password was validated")
    }
    
    func testSignupPresenter_WhenGivenValidFormModel_ShouldCallSignUpMethod() {
        // Arrange
        
        // Act
        sut.processUserSignup(model: signUpFieldModel)
        
        // Assert
        XCTAssertTrue(fakeSignUpNetworkService.isSignupMethodCalled, "The signup() method was called in the SignupWebService class")
    }
    
    func testSignupPresenter_WhenSignUpWorked_CallsSuccess() {
        // Arrange
        let myExpectation = expectation(description: "Expected the successfulSignup() method to be called")
        mockSignUpResultDelegate.expectation = myExpectation
        
        // Act
        sut.processUserSignup(model: signUpFieldModel)
        self.wait(for: [myExpectation], timeout: 5)
        
        // Assert
        XCTAssertEqual(mockSignUpResultDelegate.successfulSignupCounter, 1, "The successfulSignup() method was called more than one time")
    }
    
    func testSignupPresenter_WhenSignUpFailed_ShouldCallError() {
        // Arrange
        let errorHandlerExpectation = expectation(description: "Expected the errorHandler() method to be called")
        mockSignUpResultDelegate.expectation = errorHandlerExpectation
        fakeSignUpNetworkService.shouldReturnError = true
        
        // Act
        sut.processUserSignup(model: signUpFieldModel)
        self.wait(for: [errorHandlerExpectation], timeout: 5)

        // Assert
        XCTAssertEqual(mockSignUpResultDelegate.successfulSignupCounter, 0)
        XCTAssertEqual(mockSignUpResultDelegate.errorHandlerCounter, 1)
        XCTAssertNotNil(mockSignUpResultDelegate.signupError)
    }
    
}
