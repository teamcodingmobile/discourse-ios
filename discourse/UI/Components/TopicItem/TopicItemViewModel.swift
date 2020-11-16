//
//  TopicItemViewModel.swift
//  discourse
//
//  Created by Gerardo Rico Botella on 13/11/2020.
//

import UIKit

protocol TopicItemViewDelegate {
    func posterImageDidLoad(topic: TopicItem)

}

class TopicItemViewModel {
    var delegate: TopicItemViewDelegate?
    let topic: TopicItem
    var posterImage: UIImage?
    
    init(topic: TopicItem) {
        self.topic = topic

        guard let lastPoster = topic.lastPoster else { return }
        
        guard let posterImageUrl = URL(string: lastPoster.getAvatarUrl(size: 42)) else { return }
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let posterImageData = try? Data(contentsOf: posterImageUrl) else { return }
            
            self?.posterImage = UIImage(data: posterImageData)
            
            DispatchQueue.main.async {
                self?.delegate?.posterImageDidLoad(topic: topic)
            }
        }
    }
}
