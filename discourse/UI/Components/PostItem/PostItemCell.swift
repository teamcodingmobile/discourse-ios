//
//  PostItemCell.swift
//  discourse
//
//  Created by Adrian Arcalá Ocón on 14/11/20.
//

import UIKit

class PostItemCell: UITableViewCell {

    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var postText: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    
    var viewModel: PostItemViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            username.text = viewModel.post.username
            postText.text = viewModel.post.blurb
            posterImage.image = viewModel.userImage
            dateTimeLabel.text = Date().offset(from: viewModel.post.createdAt)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI() {
        containerView.layer.borderColor = UIColor(named: "border")!.cgColor
        containerView.layer.borderWidth = 1
        
        posterImage.layer.cornerRadius = posterImage.frame.width / 2
    }
}
