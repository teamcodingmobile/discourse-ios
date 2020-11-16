//
//  UserProfileViewModel.swift
//  discourse
//
//  Created by Gerardo Rico Botella on 15/11/2020.
//

import Foundation
import Resolver

protocol UserProfileViewDelegate {
    func userDidLoad()
    
    func userAvatarDidLoad()
    
    func topicsDidLoad()
    
    func topicItemDidChange(atRow row: Int)
}

class UserProfileViewModel {
    var delegate: UserProfileViewDelegate?
    @LazyInjected var dataClient: DataClient
    
    var id: Int
    var username: String
    var topicsPage = 0
    var headerViewModel: ProfileHeaderViewModel?
    var topicItemViewModels: [TopicItemViewModel] = []
    
    init(userId: Int, username: String) {
        self.id = userId
        self.username = username
    }
    
    func topicItemViewModel(atIndex index: Int) -> TopicItemViewModel? {
        guard index < topicItemViewModels.count else { return nil }
        
        return topicItemViewModels[index]
    }
    
    func fetchUser() {
        dataClient.getUser(withId: id) { [weak self] (user) in
            self?.headerViewModel = ProfileHeaderViewModel(user: user)
            self?.headerViewModel?.delegate = self
            self?.delegate?.userDidLoad()
        } onError: { (error) in
            //TODO: Call error
        }

    }
    
    func fetchTopics() {
        dataClient.getUserTopics(username: username, page: topicsPage) { [weak self] (topics) in
            topics.forEach { (topic) in
                let topicViewModel = TopicItemViewModel(topic: topic)
                
                topicViewModel.delegate = self
                
                self?.topicItemViewModels.append(topicViewModel)
            }
            
            self?.delegate?.topicsDidLoad()
        } onError: { (error) in
            //TODO: Call on
        }

    }
}

extension UserProfileViewModel: TopicItemViewDelegate {
    func posterImageDidLoad(topic: TopicItem) {
        let index = topicItemViewModels.firstIndex { (topicViewModel) -> Bool in
            return topicViewModel.topic == topic
        }
        
        guard let rowIndex = index else { return }
        
        delegate?.topicItemDidChange(atRow: rowIndex)
    }
}

extension UserProfileViewModel: ProfileHeaderViewDelegate {
    func avatarImageDidLoad() {
        delegate?.userAvatarDidLoad()
    }
}
