//
//  TopicsCoordinator.swift
//  discourse
//
//  Created by Gerardo Rico Botella on 13/11/2020.
//

import UIKit

class TopicsCoordinator: Coordinator {
    let presenter: UINavigationController
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    override func start() {
        let viewModel = TopicListViewModel()
        let topicsViewController = TopicListViewController(viewModel: viewModel)
        
        viewModel.delegate = topicsViewController
        
        presenter.pushViewController(topicsViewController, animated: true)
    }
}

extension TopicsCoordinator: TopicListViewCoordinator {
    func goToDetail(ofTopic topic: TopicItem) {
        //TODO: Push topic detail
    }
}
