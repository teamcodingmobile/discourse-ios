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
        setupTable()
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
        navigationItem.searchController?.searchBar.delegate = self
        navigationItem.hidesSearchBarWhenScrolling = false
        
    }
    func setupTable() {
        
        searchTable.dataSource = self
        searchTable.delegate = self
        
        let nib = UINib.init(nibName: "TopicItemCell", bundle: nil)
        let nib1 = UINib.init(nibName: "UserItemCell", bundle: nil)
        let nib2 = UINib.init(nibName: "PostItemCell", bundle: nil)
        
        searchTable.register(nib, forCellReuseIdentifier: "TopicItemCell")
        searchTable.register(nib1, forCellReuseIdentifier: "UserItemCell")
        searchTable.register(nib2, forCellReuseIdentifier: "PostItemCell")
        
    }
    
    func submit(term: String){
        viewModel.search(term: term)
    }
    
    func reloadTable(){
        searchTable.reloadData()
        
    }
    
    @IBAction func segmentSelectorValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            reloadTable()
        }else {reloadTable()}
    }
    
}


extension SearchViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let search = searchBar.text ?? ""
        submit(term: search)
        searchBar.resignFirstResponder()
        searchBar.endEditing(true)
    }
}
extension SearchViewController: UITableViewDelegate {
    
}

extension SearchViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if segmentSelector.selectedSegmentIndex == 0{
            return 3
        } else {return 1}
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRows: Int = 0
        
        if segmentSelector.selectedSegmentIndex == 0{
            if (section == 0){
                return self.viewModel.topicItemViewModels.count
            } else if (section == 1){
                return self.viewModel.postItemViewModels.count
            } else {
                return self.viewModel.userItemViewModels.count
            }
        }else if segmentSelector.selectedSegmentIndex == 1{
            numberOfRows = self.viewModel.topicItemViewModels.count
        }else if segmentSelector.selectedSegmentIndex == 2{
            numberOfRows = self.viewModel.postItemViewModels.count
        }else {
            numberOfRows = self.viewModel.userItemViewModels.count
        }
        return numberOfRows
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionName: String
        if segmentSelector.selectedSegmentIndex == 0{
            switch section {
                case 0:
                    sectionName = NSLocalizedString("Topics", comment: "")
                case 1:
                    sectionName = NSLocalizedString("Posts", comment: "")
                default:
                    sectionName = NSLocalizedString("Users", comment: "")
            }
            return sectionName
        }else if segmentSelector.selectedSegmentIndex == 1{
            sectionName = NSLocalizedString("Topics", comment: "")
        }else if segmentSelector.selectedSegmentIndex == 2{
            sectionName = NSLocalizedString("Posts", comment: "")
        }else {sectionName = NSLocalizedString("Users", comment: "")}
        
        return sectionName
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if segmentSelector.selectedSegmentIndex == 0{
        
            if indexPath.section == 0 {
                let cellViewModel = viewModel.topicItemViewModel(atIndex: indexPath.row)
        
                if let cell = tableView.dequeueReusableCell(withIdentifier: "TopicItemCell", for: indexPath) as? TopicItemCell {
                    cell.viewModel = cellViewModel
                    return cell
                }

            }else if indexPath.section == 1{
                let cellViewModel = viewModel.postItemViewModel(atIndex: indexPath.row)
        
                if let cell = tableView.dequeueReusableCell(withIdentifier: "PostItemCell", for: indexPath) as? PostItemCell {
                    cell.viewModel = cellViewModel
                    return cell
            
                }
            }else if indexPath.section == 2{
                let cellViewModel = viewModel.userItemViewModel(atIndex: indexPath.row)
        
                if let cell = tableView.dequeueReusableCell(withIdentifier: "UserItemCell", for: indexPath) as? UserItemCell {
                    cell.viewModel = cellViewModel
                    return cell
                }
            }
        }else if segmentSelector.selectedSegmentIndex == 1{
            let cellViewModel = viewModel.topicItemViewModel(atIndex: indexPath.row)
    
            if let cell = tableView.dequeueReusableCell(withIdentifier: "TopicItemCell", for: indexPath) as? TopicItemCell {
                cell.viewModel = cellViewModel
                return cell
            }
        }else if segmentSelector.selectedSegmentIndex == 2{
            let cellViewModel = viewModel.postItemViewModel(atIndex: indexPath.row)
    
            if let cell = tableView.dequeueReusableCell(withIdentifier: "PostItemCell", for: indexPath) as? PostItemCell {
                cell.viewModel = cellViewModel
                return cell
            }
            }else {
                let cellViewModel = viewModel.userItemViewModel(atIndex: indexPath.row)
        
                if let cell = tableView.dequeueReusableCell(withIdentifier: "UserItemCell", for: indexPath) as? UserItemCell {
                    cell.viewModel = cellViewModel
                    return cell
                }
            }
        
        fatalError("Unable to dequeue reusable cell with identifier")
    }
}

extension SearchViewController: SearchViewDelegate {
    func onSearchDidLoad() {
        searchTable.reloadData()
    }
    
    func onGetSearchError() {
        showAlert("something went wrong")
    }
}
