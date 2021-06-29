//
//  StubSignUpFieldModel.swift
//  TestExamplesTests
//
//  Created by Anton Panteleimenko on 09.06.2021.
//

import Foundation
@testable import TestExamples

struct StubSignUpFieldModel: SignUpFieldModelProtocol, Encodable {
    var firstName: String = "Anton"
    var lastName: String = "Panteleimenko"
    var email: String = "mail@chisw.com"
    var password: String = "qwerty123"
    
    func returnEmptyStub() -> StubSignUpFieldModel {
        let emptyModel = StubSignUpFieldModel(firstName: "",
                                              lastName: "",
                                              email: "",
                                              password: "")
        return emptyModel
    }
}
