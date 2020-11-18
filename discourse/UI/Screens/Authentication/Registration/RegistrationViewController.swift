//
//  RegistrationViewController.swift
//  discourse
//
//  Created by Gerardo Rico Botella on 07/11/2020.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var actionsView: UIView!
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var actionsViewConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var usernameInput: TextInput!
    @IBOutlet weak var nameInput: TextInput!
    @IBOutlet weak var emailInput: TextInput!
    @IBOutlet weak var passwordInput: TextInput!
    @IBOutlet weak var passwordConfirmationInput: TextInput!
    
    weak var activeInput: UITextField?
    
    let viewModel: RegistrationViewModel
    
    init(viewModel: RegistrationViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupKeyboardObservers()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavbar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let _ = usernameInput.becomeFirstResponder()
    }
    
    func setupNavbar() {
        let navbar = navigationController!.navigationBar
        navbar.isTranslucent = false
        navbar.backgroundColor = .white
        navbar.shadowImage = UIImage()
        navbar.setBackgroundImage(nil, for: .default)
     
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 95, height: 28))
        let titleImageView = UIImageView(image: UIImage(named: "discourseLogo"))
        titleImageView.contentMode = .scaleAspectFit
        titleImageView.frame = CGRect(x: 0, y: 0, width: titleView.frame.width, height: titleView.frame.height)
        titleView.addSubview(titleImageView)
        navigationItem.titleView = titleView
        
        usernameInput.returnKeyType = .next
        nameInput.returnKeyType = .next
        emailInput.returnKeyType = .next
        passwordInput.returnKeyType = .next
        passwordConfirmationInput.returnKeyType = .done
        
        usernameInput.textContentType = .nickname
        passwordInput.textContentType = .newPassword
        
        passwordInput.textView.isSecureTextEntry = true
        passwordConfirmationInput.textView.isSecureTextEntry = true
        
        usernameInput.keyboardType = .asciiCapable
        emailInput.keyboardType = .emailAddress
    }
    
    func setupUI() {
        titleLabel.text = NSLocalizedString("auth.registration.title", comment: "")
        
        usernameInput.textView.delegate = self
        nameInput.textView.delegate = self
        emailInput.textView.delegate = self
        passwordInput.textView.delegate = self
        passwordConfirmationInput.textView.delegate = self
        
        registerButton.layer.cornerRadius = 4
        
        actionsView.layer.borderWidth = 1
        actionsView.layer.borderColor = CGColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
    }
    
    func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func clearErrors() {
        usernameInput.error = nil
        nameInput.error = nil
        emailInput.error = nil
        passwordInput.error = nil
        passwordConfirmationInput.error = nil
    }
    
    func submit() {
        clearErrors()
        
        let data = RegisterUserForm(
            username: usernameInput.value?.trimmingCharacters(in: .whitespacesAndNewlines),
            name: nameInput.value?.trimmingCharacters(in: .whitespacesAndNewlines),
            email: emailInput.value?.trimmingCharacters(in: .whitespacesAndNewlines),
            password: passwordInput.value?.trimmingCharacters(in: .whitespacesAndNewlines),
            passwordConfirmation: passwordConfirmationInput.value?.trimmingCharacters(in: .whitespacesAndNewlines)
        )
        
        viewModel.register(data: data)
    }

    @objc func keyboardDidShow(notification: NSNotification) {
        let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        guard let keyboardHeight = keyboardSize?.height else { return }
        
        actionsViewConstraint.constant = keyboardHeight
        
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardHeight, right: 0.0)
        scrollView.contentInset = contentInsets
        
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        actionsViewConstraint.constant = 0
        
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.view.layoutIfNeeded()
        }
    }
    
    @IBAction func onRegisterButtonTapped(_ sender: Any) {
        submit()
    }
}

extension RegistrationViewController: RegistrationViewDelegate {
    func onInvalidRegistrationData(_ errors: [FormError]) {
        errors.forEach { (error) in
            switch error.field {
            case "username":
                usernameInput.error = error.message
            case "name":
                nameInput.error = error.message
            case "email":
                emailInput.error = error.message
            case "password":
                passwordInput.error = error.message
            case "passwordConfirmation":
                passwordConfirmationInput.error = error.message
            default:
                fatalError("Field \(error.field) not found")
            }
        }
    }
    
    func onRegistrationError(_ error: Error?) {
        showAlert("Something went wrong")
    }
}

extension RegistrationViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        activeInput = nil
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeInput = textField
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        case usernameInput.textView:
            let _ = nameInput.becomeFirstResponder()
        case nameInput.textView:
            let _ =  emailInput.becomeFirstResponder()
        case emailInput.textView:
            let _ = passwordInput.becomeFirstResponder()
        case passwordInput.textView:
            let _ =  passwordConfirmationInput.becomeFirstResponder()
        default:
            submit()
        }
        
        return true
    }
}
