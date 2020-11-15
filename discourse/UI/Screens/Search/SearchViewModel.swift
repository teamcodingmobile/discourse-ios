//
//  SearchViewModel.swift
//  discourse
//
//  Created by Adrian Arcalá Ocón on 14/11/2020.
//

import Foundation
import Resolver

protocol SearchViewDelegate {
    func onSearchDidLoad()
    
    func onGetSearchError()
}
class SearchViewModel{
    var coordinator: SearchCoordinator?
    var delegate: SearchViewDelegate?
    
    @LazyInjected var dataClient: DataClient
    
    var topicItemViewModels: [TopicItemViewModel] = []
    var topicsDelegate: TopicItemViewDelegate?
    
    var postItemViewModels: [PostItemViewModel] = []
    var postsDelegate: PostItemViewDelegate?
    
    var userItemViewModels: [UserItemViewModel] = []
    var usersDelegate: UserItemViewDelegate?
    
    
    func topicItemViewModel(atIndex index: Int) -> TopicItemViewModel? {
        guard index < topicItemViewModels.count else { return nil }
        
        return topicItemViewModels[index]
    }
    func postItemViewModel(atIndex index: Int) -> PostItemViewModel? {
        guard index < topicItemViewModels.count else { return nil }
        
        return postItemViewModels[index]
    }
    func userItemViewModel(atIndex index: Int) -> UserItemViewModel? {
        guard index < userItemViewModels.count else { return nil }
        
        return userItemViewModels[index]
    }
    
    
    
    func search(term: String){
        dataClient.getSearch(withTerm: term) { [weak self] (topics, posts, users)  in
            
            let topicViewModels: [TopicItemViewModel] = topics.map() { topic in
                let topicViewModel = TopicItemViewModel(topic: topic)
                    
                return topicViewModel
            }
            self?.topicItemViewModels.append(contentsOf: topicViewModels)
            
            
            let postViewModels: [PostItemViewModel] = posts.map { post in
                let postViewModel = PostItemViewModel(post: post)
                    
                return postViewModel
            }
            self?.postItemViewModels.append(contentsOf: postViewModels)

            
            let userViewModels: [UserItemViewModel] = users.map { user in
                let userViewModel = UserItemViewModel(user: user)
                    
                return userViewModel
            }
            self?.userItemViewModels.append(contentsOf: userViewModels)
            
            self?.delegate?.onSearchDidLoad()
            
        } onError: { [weak self] (e) in
            self?.delegate?.onGetSearchError()
        }
    }

    
}
