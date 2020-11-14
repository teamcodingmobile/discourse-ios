//
//  SearchViewController.swift
//  discourse
//
//  Created by Adrian Arcalá Ocón on 14/11/2020.
//

import UIKit

class SearchViewController: UIViewController {
    
    let viewModel: SearchViewModel
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavbar()

    }
    
    func setupNavbar() {
        let navbar = navigationController!.navigationBar
        navbar.isTranslucent = true
        navbar.backgroundColor = .white
        navbar.shadowImage = UIImage()
        navbar.setBackgroundImage(nil, for: .default)
        title = "Search"
        
        navigationItem.searchController = UISearchController(searchResultsController: nil)
        navigationItem.hidesSearchBarWhenScrolling = false
        
        navbar.prefersLargeTitles = true
        
    }


}
