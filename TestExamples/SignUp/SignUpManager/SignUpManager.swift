//
//  SignUpManager.swift
//  TestExamples
//
//  Created by Anton Panteleimenko on 09.06.2021.
//

class SignUpManager: SignUpManagerProtocol {
    
    // MARK: - Properties
    
    private var modelFieldValidator: SignUpValidatorProtocol
    private var networkService: SignupNetworkProtocol
    private weak var delegate: SignUpResultDelegateProtocol?
    
    // MARK: - Init
    
    required init(modelFieldValidator: SignUpValidatorProtocol,
                  networkService: SignupNetworkProtocol,
                  delegate: SignUpResultDelegateProtocol) {
        self.modelFieldValidator = modelFieldValidator
        self.networkService = networkService
        self.delegate = delegate
    }
    
    // MARK: - Funcs
    
    func processUserSignup(model: SignUpFieldModelProtocol) {
        
        guard modelFieldValidator.isFirstNameValid(firstName: model.firstName),
              modelFieldValidator.isLastNameValid(lastName: model.lastName),
              modelFieldValidator.isEmailValid(email: model.email),
              modelFieldValidator.isPasswordValid(password: model.password) else {
            delegate?.errorHandler(error: .invalidFieldData)
            return
        }
        
        let model = SignUpFieldModel(firstName: model.firstName,
                                     lastName: model.lastName,
                                     email: model.email,
                                     password: model.password)
        
        networkService.signUp(with: model) { [weak self] response, error in
            if let error = error {
                self?.delegate?.errorHandler(error: error)
                return
            }
            
            if let _ = response {
                self?.delegate?.successfullSignup()
            }
        }
    }
}
