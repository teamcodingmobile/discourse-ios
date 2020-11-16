//
//  SearchCoordinator.swift
//  discourse
//
//  Created by Adrian Arcalá Ocón on 14/11/20.
//

import UIKit

class SearchCoordinator: Coordinator {
    let presenter: UINavigationController
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    override func start() {
        let viewModel = SearchViewModel()
        let searchViewController = SearchViewController(viewModel: viewModel)
        
        viewModel.delegate = searchViewController
        viewModel.coordinator = self
        
        viewModel.postsDelegate = viewModel
        viewModel.usersDelegate = viewModel
        
        presenter.pushViewController(searchViewController, animated: true)
    }
}
