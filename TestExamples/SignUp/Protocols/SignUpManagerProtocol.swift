//
//  SignUpManagerProtocol.swift
//  TestExamples
//
//  Created by Anton Panteleimenko on 09.06.2021.
//

protocol SignUpManagerProtocol: AnyObject {
    init(modelFieldValidator: SignUpValidatorProtocol,
         networkService: SignupNetworkProtocol,
         delegate: SignUpResultDelegateProtocol)
    func processUserSignup(model: SignUpFieldModelProtocol)
}
