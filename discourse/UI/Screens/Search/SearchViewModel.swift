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
    var postItemViewModels: [PostItemViewModel] = []
    var userItemViewModels: [PostItemViewModel] = []
    
    func topicItemViewModel(atIndex index: Int) -> TopicItemViewModel? {
        guard index < topicItemViewModels.count else { return nil }
        
        return topicItemViewModels[index]
    }
    
    func search(term: String){
        dataClient.getSearch(withTerm: term) { [weak self] (response) in
            
            let topicViewModels = response.topics.map() { topic in
                let topicViewModel = TopicItemViewModel(topic: topic)
                topicViewModel.delegate = self
                    
                return topicViewModel
            }
            self?.topicItemViewModels.append(contentsOf: topicViewModels)
            
            
            let postViewModels: [PostItemViewModel] = posts.map { post in
                let postViewModel = PostItemViewModel(post: post)
                postViewModel.delegate = self
                    
                return postViewModel
            }
            self?.postItemViewModels.append(contentsOf: postViewModels)
            
            
            let userViewModels: [PostItemViewModel] = users.map { user in
                let userViewModel = UserItemViewModel(user: user)
                userViewModel.delegate = self
                    
                return topicViewModel
            }
            self?.postItemViewModels.append(contentsOf: userViewModels)
            
            
        } onError: { [weak self] (e) in
            self?.delegate?.onGetSearchError()
        }
    }

    
}
