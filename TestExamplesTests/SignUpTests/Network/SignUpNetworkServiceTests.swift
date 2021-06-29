//
//  SignUpNetworkServiceTests.swift
//  TestExamplesTests
//
//  Created by Anton Panteleimenko on 10.06.2021.
//

import XCTest
@testable import TestExamples

class SignUpNetworkServiceTests: XCTestCase {
    
    private enum Constants {
        static let urlString = "http://appsdeveloperblog.com:8080/signup-mock-service/users"
    }
    
    var sut: SignUpNetworkService!
    var signUpFieldsModel: SignUpFieldModel!
    
    override func setUpWithError() throws {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: config)
        sut = SignUpNetworkService(urlString: Constants.urlString, urlSession: urlSession)
        signUpFieldsModel = SignUpFieldModel(firstName: "Anton",
                                             lastName: "Panteleimenko",
                                             email: "mail@chisw.com",
                                             password: "qwerty123")
    }
    
    override func tearDownWithError() throws {
        sut = nil
        signUpFieldsModel = nil
        MockURLProtocol.stubResponseData = nil
        MockURLProtocol.error = nil
    }
    
    func testSignupWebService_WhenGivenSuccessfullResponse_ReturnsSuccess() {
        
        // Arrange
        let jsonString = "{\"status\":\"ok\"}"
        MockURLProtocol.stubResponseData =  jsonString.data(using: .utf8)
        
        let expectation = self.expectation(description: "Signup Web Service Response Expectation")
        
        // Act
        sut.signUp(with: signUpFieldsModel) { (signupResponseModel, error) in
            
            // Assert
            //"{\"status\":\"ok\"}"
            XCTAssertEqual(signupResponseModel?.status, "ok")
            expectation.fulfill()
            
        }
        
        self.wait(for: [expectation], timeout: 5)
        
    }
    
    func testSignupWebService_WhenReceivedDifferentJSONResponse_ErrorTookPlace() {
        // Arrange
        let jsonString = "{\"path\":\"/users\", \"error\":\"Internal Server Error\"}"
        MockURLProtocol.stubResponseData =  jsonString.data(using: .utf8)
        
        let expectation = self.expectation(description: "Signup() method expectation for a response that contains a different JSON structure")
        
        // Act
        sut.signUp(with: signUpFieldsModel) { (signupResponseModel, error) in
            
            // Assert
            XCTAssertNil(signupResponseModel, "The response model for a request containing unknown JSON response, should have been nil")
            XCTAssertEqual(error, SignUpErrorHandler.invalidResponseModel, "The signup() method did not return expected error")
            expectation.fulfill()
            
        }
        
        self.wait(for: [expectation], timeout: 5)
    }
    
    func testSignupWebservice_WhenEmptyURLStringProvided_ReturnsError() {
        // Arrange
        let expectation = self.expectation(description: "An empty request URL string expectation")
        
        sut = SignUpNetworkService(urlString: "")
        
        // Act
        sut.signUp(with: signUpFieldsModel) { (signupResponseModel, error) in
            
            // Assert
            XCTAssertEqual(error, SignUpErrorHandler.invalidRequestURLString, "The signup() method did not return an expected error for an invalidRequestURLString error")
            XCTAssertNil(signupResponseModel, "When an invalidRequestURLString takes place, the response model must be nil")
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 2)
    }
    
    func testSignupWebService_WhenURLRequestFails_ReturnsErrorMessageDescription() {
        
        // Arrange
        let expectation = self.expectation(description: "A failed Request expectation")
        let errorDescription = "A localized description of an error"
        MockURLProtocol.error = SignUpErrorHandler.failedRequest(description:errorDescription)
        
        // Act
        sut.signUp(with: signUpFieldsModel) { (signupResponseModel, error) in
            // Assert
            XCTAssertNotEqual(error, SignUpErrorHandler.failedRequest(description:errorDescription), "The signup() method did not return an expecter error for the Failed Request")
            // XCTAssertEqual(error?.localizedDescription, errorDescription)
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 2)
        
    }
}
