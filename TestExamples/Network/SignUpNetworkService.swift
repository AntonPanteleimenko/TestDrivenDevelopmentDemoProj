//
//  SignUpNetworkService.swift
//  TestExamples
//
//  Created by Anton Panteleimenko on 10.06.2021.
//

import Foundation

class SignUpNetworkService: SignupNetworkProtocol {
    
    private var urlSession: URLSession
    private var urlString: String
    
    init(urlString: String, urlSession: URLSession = .shared) {
        self.urlString = urlString
        self.urlSession = urlSession
    }
    
    func signUp(with model: SignUpFieldModel,
                completionHandler: @escaping (SignUpNetworkResponseModel?, SignUpErrorHandler?) -> Void) {
        guard let url = URL(string: urlString) else {
            completionHandler(nil, SignUpErrorHandler.invalidRequestURLString)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try? JSONEncoder().encode(model)
        
        let dataTask = urlSession.dataTask(with: request) { (data, response, error) in
            
            if let requestError = error {
                completionHandler(nil, SignUpErrorHandler.failedRequest(description: requestError.localizedDescription))
                return
            }
            
            if let data = data,
               let signupResponseModel = try? JSONDecoder().decode(SignUpNetworkResponseModel.self, from: data) {
                completionHandler(signupResponseModel, nil)
            } else {
                completionHandler(nil, SignUpErrorHandler.invalidResponseModel)
            }
        }
        
        dataTask.resume()
    }
}
