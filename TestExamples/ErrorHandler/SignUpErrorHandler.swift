//
//  SignUpErrorHandler.swift
//  TestExamples
//
//  Created by Anton Panteleimenko on 10.06.2021.
//

import Foundation

enum SignUpErrorHandler: LocalizedError, Equatable {
    
    init(customError: String? = "") {
        self = .failedRequest(description: customError!)
    }
    
    case invalidResponseModel
    case invalidRequestURLString
    case failedRequest(description: String)
    case invalidFieldData
    
    var errorDescription: String? {
        switch self {
        case .failedRequest(let description):
            return description
        case .invalidResponseModel, .invalidRequestURLString:
            return ""
        case .invalidFieldData:
            return "Please check your input info"
        }
    }
    
}
