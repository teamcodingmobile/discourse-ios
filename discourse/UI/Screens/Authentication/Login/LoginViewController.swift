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
    @IBOutlet weak var inputUsername: UITextField!
    @IBOutlet weak var inputPassword: UITextField!
    
    var user: String
    
    @IBAction func next(_ sender: Any) {
        inputUsername.endEditing(true)
    }
    @IBAction func loginReturn(_ sender: Any) {
        if inputUsername.text != nil {
            user = inputUsername.text!
            viewModel.logIn(userInput: user)
        }
    }
    
    
    
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
        inputUsername.returnKeyType = .next
        inputPassword.returnKeyType = .join
    }

    
}

