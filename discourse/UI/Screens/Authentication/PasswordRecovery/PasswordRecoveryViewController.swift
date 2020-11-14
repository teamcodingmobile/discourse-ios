//
//  PasswordRecoveryViewController.swift
//  discourse
//
//  Created by Gerardo Rico Botella on 13/11/2020.
//

import UIKit

class PasswordRecoveryViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var usernameInput: TextInput!
    @IBOutlet weak var actionsView: UIView!
    @IBOutlet weak var sendEmailButton: UIButton!
    @IBOutlet weak var successView: UIView!
    @IBOutlet weak var successLabel: UILabel!
    
    @IBOutlet weak var actionsViewConstraint: NSLayoutConstraint!
    
    let viewModel: PasswordRecoveryViewModel
    
    init(viewModel: PasswordRecoveryViewModel) {
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
        successView.isHidden = true
        
        setupNavbar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        usernameInput.becomeFirstResponder()
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
        
        usernameInput.returnKeyType = .done
        usernameInput.textContentType = .nickname
        usernameInput.keyboardType = .asciiCapable
    }
    
    func setupUI() {
        titleLabel.text = NSLocalizedString("auth.password_recovery.title", comment: "")
        sendEmailButton.setTitle(NSLocalizedString("auth.password_recovery.send", comment: ""), for: .normal)
        sendEmailButton.setTitle(NSLocalizedString("auth.password_recovery.sending", comment: ""), for: .disabled)
        successLabel.text = NSLocalizedString("auth.password_recovery.success", comment: "")
        sendEmailButton.setBackgroundColor(color: .lightGray, forState: .disabled)
        
        usernameInput.textView.delegate = self
        
        sendEmailButton.layer.cornerRadius = 4
        
        actionsView.layer.borderWidth = 1
        actionsView.layer.borderColor = CGColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
    }
    
    func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func clearErrors() {
        usernameInput.error = nil
    }
    
    func submit() {
        clearErrors()
        sendEmailButton.isEnabled = false
        
        let data = RecoverPasswordForm(
            username: usernameInput.value?.trimmingCharacters(in: .whitespacesAndNewlines)
        )
        
        viewModel.recover(data: data)
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
    
    @IBAction func onSendEmailButtonTapped(_ sender: Any) {
        submit()
    }
    
    @IBAction func onBackToLoginButtonTapped(_ sender: Any) {
        viewModel.goToLogin()
    }
}

extension PasswordRecoveryViewController: PasswordRecoveryViewDelegate {

    func onInvalidPasswordRecoveryData(_ errors: [FormError]) {
        sendEmailButton.isEnabled = true
        errors.forEach { (error) in
            switch error.field {
            case "username":
                usernameInput.error = error.message
            default:
                fatalError("Field \(error.field) not found")
            }
        }
    }
    
    func onPasswordRecoveryError(_ error: Error?) {
        showAlert("Something went wrong")
    }
    
    func onSuccessPasswordRecovery() {
        sendEmailButton.isEnabled = true
        successView.layer.opacity = 0
        successView.isHidden = false
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.successView.layer.opacity = 1
        }
    }
}

extension PasswordRecoveryViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        submit()
        
        return true
    }
}
