//
//  PostItemViewModel.swift
//  discourse
//
//  Created by Adrian Arcalá Ocón on 14/11/20.
//

import UIKit
protocol PostItemViewDelegate {
    func postImageDidLoad(post: Post)
}

class PostItemViewModel{
    var delegate: PostItemViewDelegate?
    let post: Post
    var userImage: UIImage?
    
    init(post: Post) {
        
        self.post = post
        
        guard let userImageUrl = URL(string: post.getAvatarUrl(size: 42)) else { return }
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let userImageData = try? Data(contentsOf: userImageUrl) else { return }
            
            self?.userImage = UIImage(data: userImageData)
            
            DispatchQueue.main.async {
                self?.delegate?.postImageDidLoad(post: post)
            }
        }
        
    }
}
