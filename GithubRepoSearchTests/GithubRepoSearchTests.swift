//
//  GithubRepoSearchTests.swift
//  GithubRepoSearchTests
//
//  Created by Koushal, Kumar Ajitesh | Ajitesh | TDD on 2021/07/28.
//

import XCTest
@testable import GithubRepoSearch

class GithubRepoSearchTests: XCTestCase {

    var srt: RepositoryAPIRequest?
        
    let repositoryList: [String: Any] = ["total_count":1,
                        "incomplete_results":true,
                        "items":[["id": 94404860,
                                  "name": "testString",
                                  "full_name": "as/a",
                                  "description": "A graphical text editor",
                                  "html_url": "https://github.com/as/a",
                                  "updatedAt": "2021-05-21T14:15:20Z"]]]
        
    override func setUp() {
        super.setUp()
        srt = RepositoryAPIRequest()
    }
    
    override func tearDown() {
        srt = nil
        super.tearDown()
    }
    
    /*
     // Test RepositoryList
    */
    func test_fetchRepositoryList() {
        let promise = expectation(description: "Fetch Github Repositories")
        srt?.fetchRepositories(with: "testString", request: RepositoryAPIRequest(), completion: { result in
            switch result {
            // 3
            case .failure(let error):
                XCTFail("Error: \(error)")
                return
            // 4
            case .success( _):
                promise.fulfill()
            }
        })
        wait(for: [promise], timeout: 5)
    }
    
    /*
     // Test: For serializing mocked JSON object into RepositoryData
     */
    func test_serializeRepositoryData() {
        guard let data = try? JSONSerialization.data(withJSONObject: repositoryList, options: .prettyPrinted), let repoInfo = try? JSONDecoder().decode(RepositoryData.self, from: data) else {
            XCTFail()
            return
        }
        
        XCTAssert(repoInfo.items?.count == 1)
        XCTAssert(repoInfo.totalCount == 1)
    }
}
