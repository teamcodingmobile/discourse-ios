//
//  TopicDetailViewController.swift
//  discourse
//
//  Created by Gerardo Rico Botella on 15/11/2020.
//

import UIKit

class TopicDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var replyButton: UIButton!
    
    let viewModel: TopicDetailViewModel
    
    init(viewModel: TopicDetailViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.loadTopic()

        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.refreshTopic()
    }

    @IBAction func onReplyButtonTapped(_ sender: Any) {
        viewModel.replyTopicButtonTapped()
    }
    
    func setupUI() {
        replyButton.layer.cornerRadius = replyButton.frame.width / 2
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let nib = UINib.init(nibName: "TopicItemCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TopicItemCell")
        
        let postNib = UINib.init(nibName: "PostItemCell", bundle: nil)
        tableView.register(postNib, forCellReuseIdentifier: "PostItemCell")
        
        
        
    }
}

extension TopicDetailViewController: UITableViewDelegate {
    
}

extension TopicDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return viewModel.topicViewModel != nil ? 1 : 0
        }
        
        return viewModel.numberOfPosts()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cellViewModel = viewModel.topicViewModel
            cellViewModel?.delegate = self
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: "TopicItemCell", for: indexPath) as? TopicItemCell {
                cell.viewModel = cellViewModel
                return cell
            }
            
            fatalError("Unable to dequeue reusable cell with identifier TopicItemCell")
        }
        
        let cellViewModel = viewModel.postViewModel(atRow: indexPath.row)
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PostItemCell", for: indexPath) as? PostItemCell {
            cell.viewModel = cellViewModel
            return cell
        }
        
        fatalError("Unable to dequeue reusable cell with identifier PostItemCell")
        
    }
}

extension TopicDetailViewController: TopicDetailViewDelegate {
    func topicDidLoad() {
        tableView.reloadData()
    }
    
    func topicLoadFailed(_ error: Error?) {
        showAlert("Something went wrong")
    }
    
    func postDidChange(atIndex index: Int) {
        if tableView.numberOfSections == 2 {
            tableView.reloadRows(at: [IndexPath(row: index, section: 1)], with: .none)
        }
    }
}

extension TopicDetailViewController: TopicItemViewDelegate {
    func posterImageDidLoad(topic: TopicItem) {
        tableView.reloadSections(IndexSet(integer: 0), with: .none)
    }
}
