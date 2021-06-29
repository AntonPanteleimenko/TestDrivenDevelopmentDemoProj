//
//  SignUpFieldModel.swift
//  TestExamples
//
//  Created by Anton Panteleimenko on 09.06.2021.
//

import Foundation

struct SignUpFieldModel: SignUpFieldModelProtocol, Encodable {
    var firstName: String
    var lastName: String
    var email: String
    var password: String
}
