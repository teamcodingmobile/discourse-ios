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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavbar()
        setupInputs()
    }
    
    func setupNavbar() {
        
        let navBar = navigationController!.navigationBar

        navBar.barTintColor = .white
        navBar.shadowImage = UIImage()
        navBar.setBackgroundImage(nil, for: .default)
        
        
        let logo = UIImage(named: "discourseLogoSinFondo.png")
        let titleLogo = UIImageView(image: logo)
        
        navigationItem.titleView = titleLogo
    }
    
    func setupInputs(){
        inputUsername.textView.delegate = self
        inputPassword.textView.delegate = self
        
        inputUsername.returnKeyType = .next
        inputPassword.returnKeyType = .join
    }
    func submit(){
        user = inputUsername.value ?? ""
        
        viewModel.logIn(userInput: user)
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
            inputPassword.becomeFirstResponder()
        default:
            inputPassword.endEditing(true)
            submit()
        }
        
        return true
    }
}
extension LoginViewController: LoginViewDelegate {
    func onLoginError() {
        showAlert("User or password is invalid")
    }
}
