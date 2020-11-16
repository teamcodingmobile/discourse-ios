//
//  ProfileHeaderCell.swift
//  discourse
//
//  Created by Gerardo Rico Botella on 15/11/2020.
//

import UIKit

class ProfileHeaderCell: UITableViewCell {

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var topicsCountLabel: UILabel!
    @IBOutlet weak var postsCountLabel: UILabel!
    @IBOutlet weak var likesCountLabel: UILabel!
    @IBOutlet weak var statsContainerView: UIView!
    
    var viewModel: ProfileHeaderViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            
            avatarImage.image = viewModel.avatarImage
            nameLabel.text = viewModel.user.name
            usernameLabel.text = viewModel.user.username
            topicsCountLabel.text = String(viewModel.user.topicsCount)
            postsCountLabel.text = String(viewModel.user.postsCount)
            likesCountLabel.text = String(viewModel.user.likesCount)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    func setupUI() {
        backgroundImage.image = .gradient(
            from: UIColor(named: "secondaryGradientColor1")!,
            to: UIColor(named: "secondaryGradientColor2")!,
            frame: CGRect(x: 0, y: 0, width: contentView.frame.width, height: backgroundImage.frame.height)
        )
        avatarImage.layer.cornerRadius = avatarImage.frame.width / 2
        avatarImage.layer.borderColor = UIColor.white.cgColor
        avatarImage.layer.borderWidth = 4
        
        statsContainerView.layer.borderWidth = 1
        statsContainerView.layer.borderColor = UIColor(named: "border")!.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
