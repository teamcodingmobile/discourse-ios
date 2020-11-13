//
//  TopicListViewModel.swift
//  discourse
//
//  Created by Gerardo Rico Botella on 13/11/2020.
//

import Foundation
import Resolver

protocol TopicListViewCoordinator {
    func goToDetail(ofTopic topic: TopicItem)
}

protocol TopicListViewDelegate {
    func onTopicsDidLoad()
    
    func onLatestPageReached()
    
    func onGetTopicsError()
}

class TopicListViewModel {
    var coordinator: TopicListViewCoordinator?
    var delegate: TopicListViewDelegate?
    @Injected var dataClient: DataClient
    
    var page: Int = 1
    var topics: [TopicItem] = []
    
    func topicItemViewModel(atIndex index: Int) -> TopicItemViewModel? {
        guard index < topics.count else { return nil }
        
        return TopicItemViewModel(topic: topics[index])
    }
    
    func fetchTopics() {
        dataClient.getLatestTopics(atPage: page) { [weak self] (topics) in
            self?.topics.append(contentsOf: topics)
            self?.delegate?.onTopicsDidLoad()
        } onError: { [weak self] (error) in
            self?.delegate?.onGetTopicsError()
        }
    }
    
    func fetchMoreTopics() {
        page += 1
        
        fetchTopics()
    }
    
    func openDetail(ofTopic topic: TopicItem) {
        self.coordinator?.goToDetail(ofTopic: topic)
    }
}
