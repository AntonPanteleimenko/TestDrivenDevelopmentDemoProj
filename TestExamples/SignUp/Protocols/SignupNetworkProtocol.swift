//
//  SignupNetworkProtocol.swift
//  TestExamples
//
//  Created by Anton Panteleimenko on 10.06.2021.
//

protocol SignupNetworkProtocol {
        func signUp(with model: SignUpFieldModel, completionHandler: @escaping (SignUpNetworkResponseModel?, SignUpErrorHandler?) -> Void)
}
