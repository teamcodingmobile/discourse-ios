//
//  ProfileHeaderViewModel.swift
//  discourse
//
//  Created by Gerardo Rico Botella on 15/11/2020.
//

import UIKit

protocol ProfileHeaderViewDelegate {
    func avatarImageDidLoad()
}

class ProfileHeaderViewModel {
    var delegate: ProfileHeaderViewDelegate?
    var user: User
    var avatarImage: UIImage?
    
    init(user: User) {
        self.user = user
        
        guard let avatarImageUrl = URL(string: user.getAvatarUrl(size: 120)) else { return }
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let avatarImageData = try? Data(contentsOf: avatarImageUrl) else { return }
            
            self?.avatarImage = UIImage(data: avatarImageData)
            
            DispatchQueue.main.async {
                self?.delegate?.avatarImageDidLoad()
            }
        }
    }
}
