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
    
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavbar()
        
    }
    
    private func setupNavbar() {
        let navBar = navigationController!.navigationBar
        navBar.barTintColor = UIColor.white
        navBar.shadowImage = UIImage()
        
        let logo = UIImage(named: "discourseLogoSinFondo.png")
        let titleLogo = UIImageView(image: logo)
        
        navigationItem.titleView = titleLogo
        
    }
    
}
