//
//  TopicListViewController.swift
//  discourse
//
//  Created by Gerardo Rico Botella on 13/11/2020.
//

import UIKit

class TopicListViewController: UIViewController {
    
    @IBOutlet weak var topicsTable: UITableView! {
        didSet {
            topicsTable.dataSource = self
            topicsTable.delegate = self
            
            let nib = UINib.init(nibName: "TopicItemCell", bundle: nil)
            topicsTable.register(nib, forCellReuseIdentifier: "TopicItemCell")
        }
    }
    
    let viewModel: TopicListViewModel
    
    init(viewModel: TopicListViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        viewModel.fetchTopics()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavBar()
    }
    
    func setupNavBar() {
        title = NSLocalizedString("topics.list.title", comment: "")
        
        let navbar = navigationController!.navigationBar
        navbar.isTranslucent = false
        navbar.backgroundColor = .white
        navbar.shadowImage = .gradient(
            from: UIColor(named: "primaryGradientColor1")!,
            to: UIColor(named: "primaryGradientColor2")!,
            frame: CGRect(x: 0, y: 0, width: navbar.layer.frame.width, height: 8)
        )
    }

}

extension TopicListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.topics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel = viewModel.topicItemViewModel(atIndex: indexPath.row)
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TopicItemCell", for: indexPath) as? TopicItemCell {            
            cell.viewModel = cellViewModel
            return cell
        }
        
        fatalError("Unable to dequeue reusable cell with identifier TopicItemCell")
    }
    
    
}

extension TopicListViewController: UITableViewDelegate {
    
}

extension TopicListViewController: TopicListViewDelegate {
    func onTopicsDidLoad() {
        topicsTable.reloadData()
    }
    
    func onGetTopicsError() {
        showAlert("Something went wrong")
    }

    func onLatestPageReached() {
        //TODO: Stop calling fetchMore
    }
}
