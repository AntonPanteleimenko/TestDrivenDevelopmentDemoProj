//
//  ViewController.swift
//  TestExamples
//
//  Created by Anton Panteleimenko on 07.06.2021.
//

import UIKit
import SnapKit

class SignUpViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        static let dodgerBlueColor = UIColor.dodgerBlue
        static let deepSkyBlueColor = UIColor.deepSkyBlue
        static let swiftLogoImage = UIImage(named: "swift")
        static let urlString = "http://appsdeveloperblog.com:8080/signup-mock-service/users"
    }
    
    private var backgroundSV: UIScrollView?
    private var contentView: UIView?
    var signUpManager: SignUpManagerProtocol?
    var signUpButtonRef: UIButton!
    
    // MARK: - Lazy Properties
    
    lazy private var signUpLabel: GradientLabel = {
        let label = GradientLabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        label.gradientColors = [Constants.dodgerBlueColor.cgColor,
                                Constants.deepSkyBlueColor.cgColor]
        label.text = "Sign Up"
        return label
    }()
    
    lazy private var firstNameTextField: YVTextField = {
        let textField = constuctTextField()
        textField.smallPlaceholderText = "Enter your first name"
        textField.placeholder = "Your first name"
        return textField
    }()
    
    lazy private var lastNameTextField: YVTextField = {
        let textField = constuctTextField()
        textField.smallPlaceholderText = "Enter your last name"
        textField.placeholder = "Your last name"
        return textField
    }()
    
    lazy private var emailTextField: YVTextField = {
        let textField = constuctTextField()
        textField.smallPlaceholderText = "Enter your email"
        textField.placeholder = "Your email"
        textField.autocapitalizationType = .none
        return textField
    }()
    
    lazy private var passwordTextField: YVTextField = {
        let textField = constuctTextField()
        textField.smallPlaceholderText = "Enter your password"
        textField.placeholder = "Your password"
        textField.isSecureTextEntry = true
        return textField
    }()
    
    lazy private var signUpButton: ActualGradientButton = {
        let button = ActualGradientButton()
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        button.addTarget(self, action: #selector(signUpButtonPressed(_ :)), for: .touchUpInside)
        return button
    }()
    
    lazy private var swiftLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.swiftLogoImage
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    // MARK: - Controller LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupKeyboardObservers()
        seupSignUpManager()
        setupViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        signUpButton.layer.cornerRadius = signUpButton.frame.size.height / 2
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        unsubscribeFromAllNotifications()
    }
}

extension SignUpViewController {
    
    // MARK: - Private funcs
    
    private func seupSignUpManager() {
        if signUpManager == nil {
            let signupModelValidator = SignUpFieldValidatorModel()
            let networkService = SignUpNetworkService(urlString: Constants.urlString)
            signUpManager = SignUpManager(modelFieldValidator: signupModelValidator, networkService: networkService, delegate: self)
        }
    }
    
    /// Setup views
    
    private func setupViews() {
        view.backgroundColor = .white
        hideKeyboardTapGestureRecognizer()
        
        createContainerView()
        
        guard let backgroundSV = backgroundSV,
              let contentView = self.contentView else { return }
        
        contentView.addSubview(signUpLabel)
        signUpLabel.snp.makeConstraints { (make) in
            make.top.equalTo(backgroundSV.snp.top).offset(100)
            make.leading.equalTo(contentView.snp.leading).offset(20)
        }
        
        contentView.addSubview(firstNameTextField)
        firstNameTextField.snp.makeConstraints { (make) in
            make.top.equalTo(signUpLabel.snp.bottom).offset(70)
            make.leading.equalTo(contentView.snp.leading).offset(30)
            make.trailing.equalTo(contentView.snp.trailing).inset(30)
            make.height.equalTo(45)
        }
        
        contentView.addSubview(lastNameTextField)
        lastNameTextField.snp.makeConstraints { (make) in
            make.top.equalTo(firstNameTextField.snp.bottom).offset(35)
            make.leading.equalTo(contentView.snp.leading).offset(30)
            make.trailing.equalTo(contentView.snp.trailing).inset(30)
            make.height.equalTo(45)
        }
        
        contentView.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { (make) in
            make.top.equalTo(lastNameTextField.snp.bottom).offset(35)
            make.leading.equalTo(contentView.snp.leading).offset(30)
            make.trailing.equalTo(contentView.snp.trailing).inset(30)
            make.height.equalTo(45)
        }
        
        contentView.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(emailTextField.snp.bottom).offset(35)
            make.leading.equalTo(contentView.snp.leading).offset(30)
            make.trailing.equalTo(contentView.snp.trailing).inset(30)
            make.height.equalTo(45)
        }
        
        self.signUpButtonRef = signUpButton
        
        contentView.addSubview(signUpButtonRef)
        signUpButtonRef.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTextField.snp.bottom).offset(75)
            make.leading.equalTo(contentView.snp.leading).offset(50)
            make.trailing.equalTo(contentView.snp.trailing).inset(50)
            make.height.equalTo(45)
        }
        
        contentView.addSubview(swiftLogo)
        swiftLogo.snp.makeConstraints { (make) in
            make.centerY.equalTo(signUpLabel.snp.centerY)
            make.trailing.equalTo(contentView.snp.trailing).inset(50)
            make.size.equalTo(150)
        }
    }
    
    /// Create contaner view
    
    private func createContainerView() {
        let scrollView = UIScrollView()
        let contentView = UIView()
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.height.width.equalToSuperview()
        }
        backgroundSV = scrollView
        self.contentView = contentView
    }
    
    /// Constructing textFields
    
    private func constuctTextField() -> YVTextField {
        let textField = YVTextField()
        textField.isHighlightedOnEdit = true
        textField.highlightedColor = Constants.dodgerBlueColor
        textField.smallPlaceholderColor = UIColor.lightGray
        textField.smallPlaceholderFont = UIFont.systemFont(ofSize: 12)
        textField.smallPlaceholderPadding = 12
        textField.smallPlaceholderLeftOffset = 0
        textField.separatorIsHidden = false
        textField.separatorLineViewColor = textField.smallPlaceholderColor
        textField.separatorLeftPadding = -5
        textField.separatorRightPadding = -5
        textField.placeholderColor = UIColor.lightGray
        textField.textColor = UIColor.darkGray
        textField.font = UIFont(name: "HelveticaNeue-Light", size: 17)
        return textField
    }
    
    /// Add keyboard touch recognizer
    
    private func hideKeyboardTapGestureRecognizer() {
        let tap: UIGestureRecognizer = UITapGestureRecognizer(target: self.view,
                                                              action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    /// Perform sign up
    
    func signUp() {
        let signupModel = SignUpFieldModel(firstName: firstNameTextField.text ?? "",
                                           lastName: lastNameTextField.text ?? "",
                                           email: emailTextField.text ?? "",
                                           password: passwordTextField.text ?? "")
        
        signUpManager?.processUserSignup(model: signupModel)
    }
}

extension SignUpViewController {
    
    // MARK: - Handling Keyboard
    
    private func setupKeyboardObservers() {
        subscribeToNotification(UIResponder.keyboardWillShowNotification, selector: #selector(keyboardWillShowOrHide))
        subscribeToNotification(UIResponder.keyboardWillHideNotification, selector: #selector(keyboardWillShowOrHide))
    }
    
    func subscribeToNotification(_ notification: NSNotification.Name, selector: Selector) {
        NotificationCenter.default.addObserver(self, selector: selector, name: notification, object: nil)
    }
    
    func unsubscribeFromAllNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
}

extension SignUpViewController {
    
    // MARK: - Actions
    
    @objc
    private func signUpButtonPressed(_ sender: ActualGradientButton) {
        sender.showAnimation { [weak self] in
            guard let self = self else { return }
            self.signUp()
        }
    }
    
    @objc func keyboardWillShowOrHide(notification: NSNotification) {
        
        if let scrollView = backgroundSV, let userInfo = notification.userInfo, let endValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey], let durationValue = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey], let curveValue = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] {
            
            let endRect = view.convert((endValue as AnyObject).cgRectValue, from: view.window)
            let keyboardOverlap = scrollView.frame.maxY - endRect.origin.y
            
            scrollView.contentInset.bottom = keyboardOverlap
            scrollView.verticalScrollIndicatorInsets.bottom = keyboardOverlap
            scrollView.horizontalScrollIndicatorInsets.bottom = keyboardOverlap
            
            let duration = (durationValue as AnyObject).doubleValue
            let options = UIView.AnimationOptions(rawValue: UInt((curveValue as AnyObject).integerValue << 16))
            UIView.animate(withDuration: duration!, delay: 0, options: options, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
}

// MARK: - SignUpResultDelegateProtocol

extension SignUpViewController: SignUpResultDelegateProtocol {
    func successfullSignup() {
        showAlertOnMainQueue(with: "Great", message: "You are in!")
    }
    
    func errorHandler(error: SignUpErrorHandler) {
        showAlertOnMainQueue(with: "Oh", message: "\(error.localizedDescription)")
    }
}

// MARK: - Create alert

extension SignUpViewController {
    private func showAlertOnMainQueue(with title: String, message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
