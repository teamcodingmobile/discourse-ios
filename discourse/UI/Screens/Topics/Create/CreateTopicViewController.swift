//
//  CreateTopicViewController.swift
//  discourse
//
//  Created by Gerardo Rico Botella on 15/11/2020.
//

import UIKit

class CreateTopicViewController: UIViewController {
    
    @IBOutlet weak var titleInput: TextInput!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var topbarShadowImage: UIImageView!
    
    var viewModel: CreateTopicViewModel
    
    init(viewModel: CreateTopicViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let _ = titleInput.becomeFirstResponder()
    }
    
    func setupUI() {
        createButton.layer.cornerRadius = 4
        
        topbarShadowImage.image = .gradient(from: UIColor(named: "primaryGradientColor1")!, to: UIColor(named: "primaryGradientColor2")!, frame: topbarShadowImage.layer.bounds)
    }
    
    func clearErrors() {
        titleInput.error = nil
    }
    
    func submit() {
        clearErrors()
        
        let data = CreateTopicForm(title: titleInput.value)
        
        viewModel.create(withData: data)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func onCancelButtonTapped(_ sender: Any) {
        viewModel.cancelCreate()
    }
    
    @IBAction func onCreateButtonTapped(_ sender: Any) {
        submit()
    }
}

extension CreateTopicViewController: CreateTopicViewDelegate {
    func onInvalidCreateTopicData(_ errors: [FormError]) {
        errors.forEach { (error) in
            switch (error.field) {
            case "title":
                titleInput.error = error.message
            default:
                fatalError()
            }
        }
    }
    
    func onCreateTopicError(_ error: Error?) {
        showAlert("Something went wrong")
    }
}
