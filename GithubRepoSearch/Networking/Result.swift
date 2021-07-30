//
//  Result.swift
//  GithubRepoSearch
//
//  Created by Koushal, Kumar Ajitesh | Ajitesh | TDD on 2021/07/28.
//

import Foundation

enum Result<T, U: Error> {
    case success(T)
    case failure(U)
}
