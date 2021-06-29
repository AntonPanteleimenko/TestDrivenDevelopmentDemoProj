//
//  SignUpErrorHandlerTests.swift
//  TestExamplesTests
//
//  Created by Anton Panteleimenko on 10.06.2021.
//

import XCTest
@testable import TestExamples

class SignUpErrorHandlerTests: XCTestCase {
    
    var sut: SignUpErrorHandler!
    
    override func setUpWithError() throws {
        sut = SignUpErrorHandler(customError: "Some error")
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testErrorHandler_WhenFailedRequestErrorCreated_ValueShouldExist() {
        
        // Arrange
        let failedRequest = SignUpErrorHandler.failedRequest(description: "Some error")
        
        // Act
        guard case failedRequest = sut else {
            // Assert
            return XCTFail("Expected to be a success but got a failure with \(failedRequest)")
        }
        
        // Assert
        XCTAssertEqual(failedRequest, sut)
        XCTAssertEqual(failedRequest.errorDescription, sut.errorDescription)
    }
    
    func testErrorHandler_WhenResponseErrorCreated_ValueShouldExist() {
        
        // Arrange
        let failedResponseModel = SignUpErrorHandler.invalidResponseModel
        sut = SignUpErrorHandler.invalidResponseModel
        
        // Act
        guard case failedResponseModel = sut else {
            // Assert
            return XCTFail("Expected to be a success but got a failure with \(failedResponseModel)")
        }
        
        // Assert
        XCTAssertEqual(failedResponseModel, sut)
        XCTAssertEqual(failedResponseModel.errorDescription, sut.errorDescription)
    }
    
    func testErrorHandler_WhenErrorCreated_ValueShouldExist() {
        
        // Arrange
        let failedRequestURLString = SignUpErrorHandler.invalidRequestURLString
        sut = SignUpErrorHandler.invalidRequestURLString
        
        // Act
        guard case failedRequestURLString = sut else {
            // Assert
            return XCTFail("Expected to be a success but got a failure with \(failedRequestURLString)")
        }
        
        // Assert
        XCTAssertEqual(failedRequestURLString, sut)
        XCTAssertEqual(failedRequestURLString.errorDescription, sut.errorDescription)
    }
}
