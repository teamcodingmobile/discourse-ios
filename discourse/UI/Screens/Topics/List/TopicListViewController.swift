//
//  TopicListViewController.swift
//  discourse
//
//  Created by Gerardo Rico Botella on 13/11/2020.
//

import UIKit

class TopicListViewController: UIViewController {
    
    @IBOutlet weak var addTopicButton: UIButton!
    @IBOutlet weak var topicsTable: UITableView!
    
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
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavBar()
    }
    
    func setupNavBar() {
        title = NSLocalizedString("topics.list.title", comment: "")
        
        let navbar = navigationController!.navigationBar
        navbar.prefersLargeTitles = false
        navbar.isTranslucent = false
        navbar.backgroundColor = .white
        let shadowImage: UIImage = .gradient(
            from: UIColor(named: "primaryGradientColor1")!,
            to: UIColor(named: "primaryGradientColor2")!,
            frame: CGRect(x: 0, y: 0, width: navbar.layer.frame.width, height: 8)
        )
        navbar.shadowImage = shadowImage
    }
    
    func setupUI() {
        addTopicButton.layer.cornerRadius = addTopicButton.frame.width / 2
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(onRefreshControlPulled), for: .valueChanged)
        topicsTable.refreshControl = refreshControl
        
        topicsTable.dataSource = self
        topicsTable.delegate = self
        
        let nib = UINib.init(nibName: "TopicItemCell", bundle: nil)
        topicsTable.register(nib, forCellReuseIdentifier: "TopicItemCell")
    }

    @objc func onRefreshControlPulled() {
        viewModel.refreshTopics()
    }
    
    @IBAction func onAddTopicButtonTapped(_ sender: Any) {
        viewModel.addTopicButtonTapped()
    }
}

extension TopicListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.topicItemViewModels.count
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectTopicItem(atIndex: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.topicItemViewModels.count - 1 {
            viewModel.fetchMoreTopics()
        }
    }
}

extension TopicListViewController: TopicListViewDelegate {
    func onTopicsDidLoad() {
        topicsTable.reloadData()
        topicsTable.refreshControl?.endRefreshing()
        topicsTable.setNeedsLayout()
    }
    
    func onGetTopicsError() {
        showAlert("Something went wrong")
    }

    func onLatestPageReached() {
        //TODO: Stop calling fetchMore
    }
    
    func topicItemDidChange(atIndex index: Int) {
        guard let visibleIndexPaths = topicsTable.indexPathsForVisibleRows else { return }
        
        let path = IndexPath(row: index, section: 0)
        if visibleIndexPaths.contains(path) {
            topicsTable.reloadRows(at: [path], with: .none)
        }
    }
}
