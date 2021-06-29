//
//  SignUpResultDelegateProtocol.swift
//  TestExamples
//
//  Created by Anton Panteleimenko on 10.06.2021.
//

protocol SignUpResultDelegateProtocol: AnyObject {
    func successfullSignup()
    func errorHandler(error: SignUpErrorHandler)
}
