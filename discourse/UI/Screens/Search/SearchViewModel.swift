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
    
    func resultDidChange(index: IndexPath)
    
    func onGetSearchError()
}
class SearchViewModel{
    var coordinator: SearchCoordinator?
    var delegate: SearchViewDelegate?
    
    @LazyInjected var dataClient: DataClient
    
    var postItemViewModels: [PostItemViewModel] = []
    var postsDelegate: PostItemViewDelegate?
    
    var userItemViewModels: [UserItemViewModel] = []
    var usersDelegate: UserItemViewDelegate?
    
    
    func postItemViewModel(atIndex index: Int) -> PostItemViewModel? {
        guard index < postItemViewModels.count else { return nil }
        
        return postItemViewModels[index]
    }
    func userItemViewModel(atIndex index: Int) -> UserItemViewModel? {
        guard index < userItemViewModels.count else { return nil }
        
        return userItemViewModels[index]
    }
    
    func search(term: String){
        dataClient.search(byTerm: term) { [weak self] (result)  in
            
            self?.postItemViewModels = result.posts.map { post in
                let postViewModel = PostItemViewModel(post: post)
                postViewModel.delegate = self?.postsDelegate
                    
                return postViewModel
            }
            
            self?.userItemViewModels = result.users.map { user in
                let userViewModel = UserItemViewModel(user: user)
                userViewModel.delegate = self?.usersDelegate
                    
                return userViewModel
            }
            
            self?.delegate?.onSearchDidLoad()
            
        } onError: { [weak self] (e) in
            self?.delegate?.onGetSearchError()
        }
    }

}

extension SearchViewModel: PostItemViewDelegate {
    func postImageDidLoad(post: Post) {
        let index = postItemViewModels.firstIndex { (item) -> Bool in
            return item.post == post
        }
        
        guard nil != index else { return }
        
        delegate?.resultDidChange(index: IndexPath(row: index!, section: 0))
    }
}


extension SearchViewModel: UserItemViewDelegate {
    func userImageDidLoad(user: Poster) {
        let index = userItemViewModels.firstIndex { (item) -> Bool in
            return item.user == user
        }
        
        guard nil != index else { return }
        
        delegate?.resultDidChange(index: IndexPath(row: index!, section: 1))
    }
}
