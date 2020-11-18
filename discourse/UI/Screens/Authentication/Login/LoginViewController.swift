//
//  LoginViewController.swift
//  discourse
//
//  Created by Adrian Arcalá Ocón on 11/11/2020.
//

import UIKit

class LoginViewController: UIViewController {
    
    let viewModel: LoginViewModel
    @IBOutlet weak var loginTitle: UILabel!
    @IBOutlet weak var inputUsername: TextInput!
    @IBOutlet weak var inputPassword: TextInput!
    @IBOutlet weak var actionsView: UIView!
    @IBOutlet weak var actionsViewConstraint: NSLayoutConstraint!
    
    
    weak var activeInput: UITextField?
    var user: String
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        self.user = ""
        
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
        
        setupUI()
        setupKeyboardObservers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavbar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let _ = inputUsername.becomeFirstResponder()
    }
    
    func setupNavbar() {
        
        let navBar = navigationController!.navigationBar

        navBar.barTintColor = .white
        navBar.shadowImage = UIImage()
        navBar.setBackgroundImage(nil, for: .default)
        
        
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 95, height: 28))
        let titleImageView = UIImageView(image: UIImage(named: "discourseLogo"))
        titleImageView.contentMode = .scaleAspectFit
        titleImageView.frame = CGRect(x: 0, y: 0, width: titleView.frame.width, height: titleView.frame.height)
        titleView.addSubview(titleImageView)
        navigationItem.titleView = titleView
    }
    
    func setupUI() {
        
        inputUsername.textView.delegate = self
        inputPassword.textView.delegate = self
        
        inputPassword.textContentType = .password
        inputPassword.textView.isSecureTextEntry = true
        
        inputUsername.returnKeyType = .next
        inputPassword.returnKeyType = .join
        
        actionsView.layer.borderWidth = 1
        actionsView.layer.borderColor = CGColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
    }
    
    func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func clearErrors() {
        inputUsername.error = nil
        inputPassword.error = nil
    }
    
    func submit(){
        clearErrors()
        
        viewModel.logIn(withData: LoginForm(
            username: inputUsername.value,
            password: inputPassword.value
        ))
    }
    
    @objc func keyboardDidShow(notification: NSNotification) {
        let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        guard let keyboardHeight = keyboardSize?.height else { return }
        
        actionsViewConstraint.constant = keyboardHeight
        
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
    
    @IBAction func onLoginButtonTapped(_ sender: Any) {
        submit()
    }
    
    @IBAction func onRecoverButtonTapped(_ sender: Any) {
        viewModel.recoverPassword()
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        activeInput = nil
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeInput = textField
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        case inputUsername.textView:
            let _ = inputPassword.becomeFirstResponder()
        default:
            submit()
        }
        
        return true
    }
}
extension LoginViewController: LoginViewDelegate {
    func onLoginError() {
        showAlert("User or password is invalid")
    }
    
    func onLoginDataErrors(_ errors: [FormError]) {
        errors.forEach { (error) in
            switch (error.field) {
            case "username":
                inputUsername.error = error.message
            case "password":
                inputPassword.error = error.message
            default:
                fatalError("Unable to found field \(error.field)")
            }
        }
    }
}
