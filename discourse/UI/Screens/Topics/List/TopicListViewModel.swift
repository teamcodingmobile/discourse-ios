//
//  TopicListViewModel.swift
//  discourse
//
//  Created by Gerardo Rico Botella on 13/11/2020.
//

import Foundation
import Resolver

protocol TopicListViewCoordinator {
    func goToCreateTopic()
    
    func goToDetail(ofTopic topic: TopicItem)
}

protocol TopicListViewDelegate {
    func onTopicsDidLoad()
    
    func onLatestPageReached()
    
    func onGetTopicsError()
    
    func topicItemDidChange(atIndex index: Int)
}

class TopicListViewModel {
    var coordinator: TopicListViewCoordinator?
    var delegate: TopicListViewDelegate?
    @Injected var dataClient: DataClient
    
    var page: Int = 0
    var topicItemViewModels: [TopicItemViewModel] = []
    
    func topicItemViewModel(atIndex index: Int) -> TopicItemViewModel? {
        guard index < topicItemViewModels.count else { return nil }
        
        return topicItemViewModels[index]
    }
    
    func fetchTopics() {
        dataClient.getLatestTopics(atPage: page) { [weak self] (topics) in
            let viewModels: [TopicItemViewModel] = topics.map { topic in
                let viewModel = TopicItemViewModel(topic: topic)
                viewModel.delegate = self
                
                return viewModel
            }
                
            self?.topicItemViewModels.append(contentsOf: viewModels)
            self?.delegate?.onTopicsDidLoad()
        } onError: { [weak self] (error) in
            self?.delegate?.onGetTopicsError()
        }
    }
    
    func fetchMoreTopics() {
        page += 1
        
        fetchTopics()
    }
    
    func refreshTopics() {
        page = 0
        topicItemViewModels = []
        
        fetchTopics()
    }
    
    func selectTopicItem(atIndex index: Int) {
        guard index < topicItemViewModels.count else { return }
        
        self.coordinator?.goToDetail(ofTopic: topicItemViewModels[index].topic)
    }
    
    func addTopicButtonTapped() {
        self.coordinator?.goToCreateTopic()
    }
}

extension TopicListViewModel: TopicItemViewDelegate {
    func posterImageDidLoad(topic: TopicItem) {
        let index = topicItemViewModels.firstIndex { (viewModel) -> Bool in
            return viewModel.topic == topic
        }
        
        if let index = index {
            self.delegate?.topicItemDidChange(atIndex: index)
        }
    }
}
