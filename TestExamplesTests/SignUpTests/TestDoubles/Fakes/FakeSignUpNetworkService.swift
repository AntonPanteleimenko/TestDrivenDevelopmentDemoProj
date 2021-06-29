//
//  FakeSignUpNetworkService.swift
//  TestExamplesTests
//
//  Created by Anton Panteleimenko on 10.06.2021.
//

@testable import TestExamples


class FakeSignUpNetworkService: SignupNetworkProtocol {
 
    var isSignupMethodCalled: Bool = false
    var shouldReturnError: Bool = false
 
    func signUp(with model: SignUpFieldModel,
                completionHandler: @escaping (SignUpNetworkResponseModel?, SignUpErrorHandler?) -> Void) {
        
        isSignupMethodCalled = true
        
        if shouldReturnError {
            completionHandler(nil, SignUpErrorHandler.failedRequest(description: "Signup request was not successful"))
        } else {
            let responseStatus = SignUpNetworkResponseModel(status: "Ok")
            completionHandler(responseStatus, nil)
        }
 
    }

}
