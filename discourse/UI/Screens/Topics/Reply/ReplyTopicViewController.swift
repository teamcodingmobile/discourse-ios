//
//  ReplyTopicViewController.swift
//  discourse
//
//  Created by Sonia Sieiro on 17/11/2020.
//

import UIKit

class ReplyTopicViewController: UIViewController {
    
    var viewModel: ReplyTopicViewModel
    var topic: TopicItem
    var image: UIImage?
    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var replyInput: TextInput!
    @IBOutlet weak var gradientImage: UIImageView!
    
    init(viewModel: ReplyTopicViewModel) {
        self.viewModel = viewModel
        self.topic = viewModel.topic
        
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
        let _ = replyInput.becomeFirstResponder()
    }
    
    
    func setupUI() {
        loadImage()
        replyButton.layer.cornerRadius = 4
        usernameLabel.text = topic.author?.username
        dateTimeLabel.text = Date().offset(from: topic.lastPostedAt)
        bodyLabel.text = topic.title
        avatarImage.layer.cornerRadius = avatarImage.frame.width / 2
        gradientImage.image = .gradient(from: UIColor(named: "primaryGradientColor1")!, to: UIColor(named: "primaryGradientColor2")!, frame: gradientImage.layer.bounds)
    }
    
    func clearErrors(){
        replyInput.error = nil
    }
    
    func submit() {
        clearErrors()
        
        let data = ReplyTopicForm(id: topic.id, title: replyInput.value)
        
        viewModel.reply(withData: data)
    }
    
    func loadImage() {
        
        guard let poster = topic.author ?? topic.lastPoster else { return }
        
        guard let posterImageUrl = URL(string: poster.getAvatarUrl(size: 42)) else {return}
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let posterImageData = try? Data(contentsOf: posterImageUrl) else { return }
            
            let image = UIImage(data: posterImageData)
            
            DispatchQueue.main.async {
                self?.avatarImage.image = image
            }
            
        
        }
    }
    
    
    @IBAction func onReplyButtonTapped(_ sender: Any) {
        submit()
    }
    @IBAction func onCancelButtonTapped(_ sender: Any) {
        viewModel.cancelReply()
        
    }
    
}

extension ReplyTopicViewController: ReplyTopicViewDelegate {
    func onInvalidReplyTopicData(_ errors: [FormError]) {
        errors.forEach { (error) in
            switch (error.field) {
            case "title":
                replyInput.error = error.message
            default:
                fatalError()
            }
        }
    }
    
    func onReplyTopicError(_ error: Error?) {
        showAlert("Something went wrong")
    }
    
}
