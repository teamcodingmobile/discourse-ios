//
//  UserTableViewCell.swift
//  discourse
//
//  Created by Adrian Arcalá Ocón on 14/11/20.
//

import UIKit

class UserItemCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    var viewModel: UserItemViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            userName.text = viewModel.user.name
            userImage.image = viewModel.userImage
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    func setupUI() {
        containerView.layer.borderColor = UIColor(named: "border")!.cgColor
        containerView.layer.borderWidth = 1
        
        userImage.layer.cornerRadius = userImage.frame.width / 2
    }
}
