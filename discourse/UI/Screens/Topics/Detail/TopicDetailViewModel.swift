//
//  TopicDetailViewModel.swift
//  discourse
//
//  Created by Gerardo Rico Botella on 15/11/2020.
//

import Foundation
import Resolver

protocol TopicDetailViewDelegate {
    func topicDidLoad()
    
    func topicLoadFailed(_ error: Error?)
    
    func postDidChange(atIndex index: Int)
}

class TopicDetailViewModel {
    var delegate: TopicDetailViewDelegate?
    @LazyInjected var dataClient: DataClient
    
    var topicViewModel: TopicItemViewModel?
    var postViewModels: [PostItemViewModel] = []
    
    let topicId: Int
    
    init(topicId: Int) {
        self.topicId = topicId
    }
    
    func postViewModel(atRow index: Int) -> PostItemViewModel? {
        guard index < postViewModels.count else { return nil }
        
        return postViewModels[index]
    }
    
    func loadTopic() {
        dataClient.getTopic(withId: topicId) { [weak self] (topic) in
            self?.topicViewModel = TopicItemViewModel(topic: topic)
            
            if let posts = topic.posts {
                self?.postViewModels = posts.map { (post) -> PostItemViewModel in
                    let viewModel = PostItemViewModel(post: post)
                    viewModel.delegate = self
                    
                    return viewModel
                }
            }
            
            self?.delegate?.topicDidLoad()
        } onError: { [weak self] (error) in
            self?.delegate?.topicLoadFailed(error)
        }
    }
    
    func numberOfPosts() -> Int {
        return postViewModels.count
    }
}

extension TopicDetailViewModel: PostItemViewDelegate {
    func postImageDidLoad(post: Post) {
        let index = postViewModels.firstIndex(where: { (viewModel) -> Bool in
            return viewModel.post == post
        })
        
        guard index != nil else { return }
        
        delegate?.postDidChange(atIndex: index!)
    }
}
