//
//  DataResponseError.swift
//  GithubRepoSearch
//
//  Created by Koushal, Kumar Ajitesh | Ajitesh | TDD on 2021/07/28.
//

import Foundation

enum DataResponseError: Error {
    case network
    case decoding
    
    var reason: String {
        switch self {
        case .network:
            return "An error occurred while fetching data ".localizedString
        case .decoding:
            return "An error occurred while decoding data".localizedString
        }
    }
}
