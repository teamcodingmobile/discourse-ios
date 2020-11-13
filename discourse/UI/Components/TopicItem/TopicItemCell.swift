//
//  TopicItemView.swift
//  discourse
//
//  Created by Gerardo Rico Botella on 13/11/2020.
//

import UIKit

class TopicItemCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    var viewModel: TopicItemViewModel? {
        didSet {
            guard let topic = viewModel?.topic else { return }
            
            usernameLabel.text = topic.lastPoster?.username
            bodyLabel.text = topic.title
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.layer.borderColor = UIColor(named: "border")!.cgColor
        containerView.layer.borderWidth = 1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
