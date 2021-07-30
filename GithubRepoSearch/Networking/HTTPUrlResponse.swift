//
//  HTTPUrlResponse.swift
//  GithubRepoSearch
//
//  Created by Koushal, Kumar Ajitesh | Ajitesh | TDD on 2021/07/28.
//

import Foundation

extension HTTPURLResponse {
    var hasSuccessStatusCode: Bool {
        return 200...299 ~= statusCode
    }
}
