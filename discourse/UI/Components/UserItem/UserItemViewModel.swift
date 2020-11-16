//
//  UserItemViewModel.swift
//  discourse
//
//  Created by Adrian Arcalá Ocón on 14/11/20.
//

import UIKit
protocol UserItemViewDelegate {
    func userImageDidLoad(user: Poster)
}

class UserItemViewModel{
    
    var delegate : UserItemViewDelegate?
    let user: Poster
    var userImage: UIImage?
    
    init(user: Poster) {
        
        self.user = user
        
        guard let userImageUrl = URL(string: user.getAvatarUrl(size: 42)) else { return }
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let userImageData = try? Data(contentsOf: userImageUrl) else { return }
            
            self?.userImage = UIImage(data: userImageData)
            
            DispatchQueue.main.async {
                self?.delegate?.userImageDidLoad(user: user)
            }
        }
    }
}
