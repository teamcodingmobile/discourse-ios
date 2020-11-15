//
//  TopicsCoordinator.swift
//  discourse
//
//  Created by Gerardo Rico Botella on 13/11/2020.
//

import UIKit

class TopicsCoordinator: Coordinator {
    let presenter: UINavigationController
    
    var topicListViewModel: TopicListViewModel?
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    override func start() {
        topicListViewModel = TopicListViewModel()
        let topicsViewController = TopicListViewController(viewModel: topicListViewModel!)
        
        topicListViewModel?.delegate = topicsViewController
        topicListViewModel?.coordinator = self
        
        presenter.pushViewController(topicsViewController, animated: true)
    }
}

extension TopicsCoordinator: TopicListViewCoordinator {
    func goToDetail(ofTopic topic: TopicItem) {
        //TODO: Push topic detail
    }
    
    func goToCreateTopic() {
        let viewModel = CreateTopicViewModel()
        let viewController = CreateTopicViewController(viewModel: viewModel)
        
        viewModel.coordinatorDelegate = self
        viewModel.delegate = viewController
        
        presenter.present(viewController, animated: true)
    }
}

extension TopicsCoordinator: CreateTopicCoordinatorDelegate {
    func topicDidCreate() {
        topicListViewModel?.refreshTopics()
        
        presenter.dismiss(animated: true)
    }
    
    func topicCreationCanceled() {
        presenter.dismiss(animated: true)
    }
}
