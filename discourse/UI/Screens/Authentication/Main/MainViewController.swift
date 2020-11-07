//
//  MinViewController.swift
//  discourse
//
//  Created by Gerardo Rico Botella on 06/11/2020.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var registerLabel: UILabel!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    let viewModel: MainViewModel
    
    var animationWordIndex = 0
    
    let animationWords = [
        NSLocalizedString("community", comment: ""),
        NSLocalizedString("team", comment: ""),
        NSLocalizedString("customers", comment: ""),
        NSLocalizedString("fans", comment: ""),
    ]
    
    let animatedText = NSLocalizedString("auth.main.register_label", comment: "")
    
    var registerLabelText: NSAttributedString {
        get {
            let word = NSAttributedString(
                string: animationWords[animationWordIndex],
                attributes: [NSAttributedString.Key.underlineStyle : NSUnderlineStyle.thick.rawValue]
            )
            
            let labelText = NSMutableAttributedString(string: animatedText)
            labelText.append(word)
            
            return labelText
        }
    }
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavbar()
        setupUI()
    }
    
    private func setupNavbar() {
        let navbar = navigationController!.navigationBar
        
        let gradient = CAGradientLayer()
        gradient.frame = navbar.frame
        gradient.colors = [UIColor(named: "secondaryGradientColor1")!.cgColor, UIColor(named: "secondaryGradientColor2")!.cgColor]
        gradient.startPoint = .zero
        gradient.endPoint = CGPoint(x: 1, y: 0)
        
        UIGraphicsBeginImageContext(gradient.frame.size)
        gradient.render(in: UIGraphicsGetCurrentContext()!)
        
        let outputImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()

        navigationController!.navigationBar.setBackgroundImage(outputImage, for: .default)
    }
    
    private func setupUI() {
        animateText()
             
        registerButton.setTitle(NSLocalizedString("auth.main.register_btn", comment: ""), for: .normal)
        registerButton.layer.cornerRadius = 4
        
        loginButton.setTitle(NSLocalizedString("auth.main.login_btn", comment: ""), for: .normal)
    }
    
    private func animateText() {
        registerLabel.attributedText = registerLabelText
        
        if (animationWordIndex == animationWords.count - 1) {
            animationWordIndex = 0
        } else {
            animationWordIndex += 1
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            self?.animateText()
        }
    }
    
    @IBAction func onRegisterButtonTapped(_ sender: Any) {
        viewModel.registerButtonTapped()
    }
    
    @IBAction func onLoginButtonTapped(_ sender: Any) {
        viewModel.loginButtonTapped()
    }
}
