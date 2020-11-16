//
//  UserProfileViewController.swift
//  discourse
//
//  Created by Gerardo Rico Botella on 15/11/2020.
//

import UIKit

class UserProfileViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let viewModel: UserProfileViewModel
    
    init(viewModel: UserProfileViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchUser()
        viewModel.fetchTopics()

        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavBar()
    }
    
    func setupNavBar() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    func setupUI() {
        tableView.dataSource = self
        tableView.delegate = self
        
        let headerNib = UINib.init(nibName: "ProfileHeaderCell", bundle: nil)
        tableView.register(headerNib, forCellReuseIdentifier: "ProfileHeaderCell")
        
        let topicNib = UINib.init(nibName: "TopicItemCell", bundle: nil)
        tableView.register(topicNib, forCellReuseIdentifier: "TopicItemCell")
    }
}

extension UserProfileViewController: UITableViewDelegate {
    
}

extension UserProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return viewModel.headerViewModel != nil ? 1 : 0
        }
        
        return viewModel.topicItemViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let headerViewModel = viewModel.headerViewModel
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileHeaderCell", for: indexPath) as? ProfileHeaderCell {
                cell.viewModel = headerViewModel
                return cell
            }
            
            fatalError("Unable to dequeue reusable cell with identifier ProfileHeaderCell")
        }
        
        
        let cellViewModel = viewModel.topicItemViewModel(atIndex: indexPath.row)
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TopicItemCell", for: indexPath) as? TopicItemCell {
            cell.viewModel = cellViewModel
            return cell
        }
        
        fatalError("Unable to dequeue reusable cell with identifier TopicItemCell")
    }
}


extension UserProfileViewController: UserProfileViewDelegate {
    func userDidLoad() {
        tableView.reloadSections(IndexSet(integer: 0), with: .none)
    }
    
    func userAvatarDidLoad() {
        tableView.reloadSections(IndexSet(integer: 0), with: .none)
    }
    
    func topicsDidLoad() {
        tableView.reloadSections(IndexSet(integer: 1), with: .none)
    }
    
    func topicItemDidChange(atRow row: Int) {
        tableView.reloadRows(at: [IndexPath(row: row, section: 1)], with: .none)
    }
}
