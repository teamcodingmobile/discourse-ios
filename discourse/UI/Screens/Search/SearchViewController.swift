//
//  SearchViewController.swift
//  discourse
//
//  Created by Adrian Arcalá Ocón on 14/11/2020.
//

import UIKit

class SearchViewController: UIViewController {
    
    let viewModel: SearchViewModel
    
    @IBOutlet weak var segmentSelector: UISegmentedControl!
    @IBOutlet weak var searchTable: UITableView!
    
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
        let shadowImage: UIImage = .gradient(
            from: UIColor(named: "primaryGradientColor1")!,
            to: UIColor(named: "primaryGradientColor2")!,
            frame: CGRect(x: 0, y: 0, width: navbar.layer.frame.width, height: 8)
        )
        navbar.shadowImage = shadowImage
        
        navigationItem.searchController = UISearchController(searchResultsController: nil)
        navigationItem.hidesSearchBarWhenScrolling = false
        
    }
    
    func submit(term: String){
        
    }
}
