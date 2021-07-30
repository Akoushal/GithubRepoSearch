//
//  RepositoryViewModel.swift
//  GithubRepoSearch
//
//  Created by Koushal, Kumar Ajitesh | Ajitesh | TDD on 2021/07/28.
//

import Foundation

final class RepositoryViewModel {
    
    private var repositories: [Repository] = []
    private var isFetchInProgress = false

    let request = RepositoryAPIRequest()

    var totalCount: Int {
        return repositories.count
    }
    
//    func repository(at index: Int) -> Repository {
//        return repositories[index]
//    }
//
    func fetchSearchResults(query: String, completionHandler: @escaping ([Repository]?, Error?) -> Void) {
        // 1
        guard !isFetchInProgress else {
            return
        }
        
        // 2
        isFetchInProgress = true
        
        request.fetchRepositories(with: query, request: request) { result in
            switch result {
            // 3
            case .failure(let error):
                DispatchQueue.main.async {
                    self.isFetchInProgress = false
                    completionHandler(nil, error)
                }
            // 4
            case .success(let response):
                DispatchQueue.main.async {
                    // 1
                    self.isFetchInProgress = false
                    // 2
                    if let items = response.items {
                        self.repositories = items
                        completionHandler(self.repositories, nil)
                    }
                }
            }
        }
    }
}
