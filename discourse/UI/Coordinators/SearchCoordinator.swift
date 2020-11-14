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
        let topicsViewController = SearchViewController(viewModel: viewModel)
        
        presenter.pushViewController(topicsViewController, animated: true)
    }
}
