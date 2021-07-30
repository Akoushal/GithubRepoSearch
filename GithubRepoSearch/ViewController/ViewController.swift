//
//  ViewController.swift
//  GithubRepoSearch
//
//  Created by Koushal, Kumar Ajitesh | Ajitesh | TDD on 2021/07/28.
//

import UIKit
import SafariServices

class ViewController: UIViewController, AlertDisplayer {
    
    private enum CellIdentifiers {
        static let list = "RepositoryListCell"
    }
    
    private var repositoryViewModel = RepositoryViewModel()
    private var repositories: [Repository] = []
    private var isShowingSafariVC = false
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let actIndicator = UIActivityIndicatorView()
        actIndicator.translatesAutoresizingMaskIntoConstraints = false
        return actIndicator
    }()
    
    lazy var repositoriesTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .gray
        tableView.register(RepositoryTableViewCell.self, forCellReuseIdentifier: CellIdentifiers.list)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set up UI
        setUpUI()
        setupNavigationBar()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        // Deselect selected cell when view disappears
        for indexPath in repositoriesTableView.indexPathsForSelectedRows ?? [] {
            repositoriesTableView.deselectRow(at: indexPath, animated: true)
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 1
        return repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.list, for: indexPath) as? RepositoryTableViewCell else { return UITableViewCell() }
        cell.configure(with: repositories[indexPath.row])
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        isShowingSafariVC = true
        guard let htmlUrlString = repositories[indexPath.row].htmlUrl,
              let url = URL(string: htmlUrlString)
            else { return}
        let vc = SFSafariViewController(url: url)
        vc.delegate = self
        present(vc, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK:- Private Methods
private extension ViewController {
    
    func setUpUI() {
        title = Constants.Title
        view.addSubview(repositoriesTableView)
        view.addSubview(activityIndicator)
        repositoriesTableView.edgesAnchorEqualTo(destinationView: view).activate()
        activityIndicator.startAnimating()
        repositoriesTableView.isHidden = true
    }
    
    func setupNavigationBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Github Repositories"
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
    }
    
    func clearData() {
        repositories = []
        repositoriesTableView.reloadData()
    }
    
    @objc func fetchSearchResult() {
        guard let query = navigationItem.searchController?.searchBar.text, !query.isEmpty else {
            clearData()
            return
        }
        repositoryViewModel.fetchSearchResults(query: query) { [weak self] repositories, error in
            if let error = error {
                let alert = UIAlertController(title: "Error",
                                              message: error.localizedDescription,
                                              preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                alert.addAction(cancelAction)
                DispatchQueue.main.async {
                    self?.present(alert, animated: true, completion: nil)
                }
            } else if let repos = repositories {
                self?.repositories = repos
                DispatchQueue.main.async {
                    self?.repositoriesTableView.reloadData()
                }
            }
        }
    }
}

// MARK:- UISearchBarDelegate Methods
extension ViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        repositoriesTableView.isHidden = false
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if !isShowingSafariVC {
            repositoriesTableView.isHidden = true
            clearData()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(fetchSearchResult), object: nil)
        perform(#selector(fetchSearchResult), with: nil, afterDelay: 0.5)
    }
}

// MARK: SFSafariViewControllerDelegate Methods
extension ViewController: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        isShowingSafariVC = false
    }
}
