//
//  SignUpFieldValidatorModelTests.swift
//  TestExamplesTests
//
//  Created by Anton Panteleimenko on 10.06.2021.
//

import XCTest
@testable import TestExamples

class SignUpFieldValidatorModelTests: XCTestCase {
    
    var sut: SignUpFieldValidatorModel!
    
    override func setUpWithError() throws {
        sut = SignUpFieldValidatorModel()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    // MARK: First Name Validation Unit Tests
    func testSignFieldValidator_WhenValidFirstNameProvided_ShouldReturnTrue() {
        
        // Arrange
        // Act
        let isFirstNameValid = sut.isFirstNameValid(firstName: "Anton")
        
        // Assert
        XCTAssertTrue(isFirstNameValid, "The isFirstNameValid() should have returned TRUE for a valid first name but returned FALSE")
    }
    
    func testSignFieldValidator_WhenTooShortFirstNameProvided_ShouldReturnFalse() {
        
        // Arrange
        // Act
        let isFirstNameValid = sut.isFirstNameValid(firstName: "A")
        
        // Assert
        XCTAssertFalse(isFirstNameValid, "The isFirstNameValid() should have returned FALSE for a first name that is shorter than \(ValidationConstants.firstNameFieldCharacterLength.min) characters but it has returned TRUE")
        
    }
    
    func testSignFieldValidator_WhenTooLongFirstNameProvided_ShouldReturnFalse() {
        
        let isFirstNameValid = sut.isFirstNameValid(firstName: "AntonAntonAnton")
        
        XCTAssertFalse(isFirstNameValid, "The isFirstNameValid() should have returned FALSE for a first name that is longer than \(ValidationConstants.firstNameFieldCharacterLength.max) characters but it has returned TRUE")
    }
    
    // MARK: Last Name Validation Unit Tests
    func testSignFieldValidator_WhenValidLastNameProvided_ShouldReturnTrue() {
        
        // Arrange
        // Act
        let isLastNameValid = sut.isLastNameValid(lastName: "Panteleimenko")
        
        // Assert
        XCTAssertTrue(isLastNameValid, "The isLastNameValid() should have returned TRUE for a valid last name but returned FALSE")
    }
    
    func testSignFieldValidator_WhenTooShortLastNameProvided_ShouldReturnFalse() {
        
        // Arrange
        // Act
        let isLastNameValid = sut.isLastNameValid(lastName: "P")
        
        // Assert
        XCTAssertFalse(isLastNameValid, "The isLastNameValid() should have returned FALSE for a last name that is shorter than \(ValidationConstants.lastNameFieldCharacterLength.min) characters but it has returned TRUE")
        
    }
    
    func testSignFieldValidator_WhenTooLongLastNameProvided_ShouldReturnFalse() {
        
        let isLastNameValid = sut.isLastNameValid(lastName: "PanteleimenkoPanteleimenko")
        
        XCTAssertFalse(isLastNameValid, "The isLastNameValid() should have returned FALSE for a last name that is longer than \(ValidationConstants.lastNameFieldCharacterLength.max) characters but it has returned TRUE")
    }
    
    // MARK: Email Address Validation
    func testSignFieldValidator_WhenValidEmailProvided_ShouldReturnTrue() {
        let isValidEmailFormat = sut.isEmailValid(email: "mail@chisw.com")
        
        XCTAssertTrue(isValidEmailFormat, "Provided valid email address format but validation did not pass")
    }
    
    func testSignFieldValidator_WhenInValidEmailProvided_ShouldReturnFalse() {
        let isValidEmailFormat = sut.isEmailValid(email: "mail@chisw")
        
        XCTAssertFalse(isValidEmailFormat, "Provided invalid email address format but validation still passed")
    }
    
    // MARK: Password Validation
    func testSignFieldValidator_WhenValidPasswordProvided_ShouldReturnTrue() {
        
        // Act
        let isPasswordValid = sut.isPasswordValid(password: "qwerty123")
        
        // Assert
        XCTAssertTrue(isPasswordValid, "The isPasswordValid() should have returned TRUE for a valid password  but it has returned FALSE")
        
    }
    
    func testSignFieldValidator_WhenTooShortPasswordProvided_ShouldReturnFalse() {
        
        // Act
        let isPasswordValid = sut.isPasswordValid(password: "123")
        
        // Assert
        XCTAssertFalse(isPasswordValid, "The isPasswordValid() should have returned FALSE for a password that is shorter than \(ValidationConstants.passwordFieldCharacterLength.min) but it has returned TRUE")
        
    }
    
    func testSignFieldValidator_WhenTooLongPasswordProvided_ShouldReturnFalse() {
        
        // Act
        let isPasswordValid = sut.isPasswordValid(password: "qwerty123qwerty123qwerty123")
        
        // Assert
        XCTAssertFalse(isPasswordValid, "The isPasswordValid() should have returned FALSE for a password that is longer than \(ValidationConstants.passwordFieldCharacterLength.max) but it has returned TRUE")
        
    }
    
}
