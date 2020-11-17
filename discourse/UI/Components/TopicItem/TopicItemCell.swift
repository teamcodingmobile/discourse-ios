//
//  TopicItemView.swift
//  discourse
//
//  Created by Gerardo Rico Botella on 13/11/2020.
//

import UIKit

class TopicItemCell: UITableViewCell {

    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var viewsCountLabel: UILabel!
    @IBOutlet weak var postsCountLabel: UILabel!
    @IBOutlet weak var replyCountLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    var viewModel: TopicItemViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            
            usernameLabel.text = viewModel.topic.author?.username ?? viewModel.topic.lastPoster?.username
            dateTimeLabel.text = Date().offset(from: viewModel.topic.lastPostedAt)
            bodyLabel.text = viewModel.topic.title
            viewsCountLabel.text = String(viewModel.topic.viewsCount ?? 0)
            postsCountLabel.text = String(viewModel.topic.postCount)
            replyCountLabel.text = String(viewModel.topic.replyCount)
            posterImageView.image = viewModel.posterImage
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    func setupUI() {
        containerView.layer.borderColor = UIColor(named: "border")!.cgColor
        containerView.layer.borderWidth = 1
        
        posterImageView.layer.cornerRadius = posterImageView.frame.width / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
