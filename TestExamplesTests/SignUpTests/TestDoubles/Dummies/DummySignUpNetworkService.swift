//
//  DummySignUpNetworkService.swift
//  TestExamplesTests
//
//  Created by Anton Panteleimenko on 11.06.2021.
//

import Foundation
@testable import TestExamples

class DummySignUpNetworkService: SignupNetworkProtocol {
    
    init() {}
    
    func signUp(with model: SignUpFieldModel,
                completionHandler: @escaping (SignUpNetworkResponseModel?, SignUpErrorHandler?) -> Void) {}
}
