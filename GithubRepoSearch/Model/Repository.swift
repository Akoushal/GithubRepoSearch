//
//  Repository.swift
//  GithubRepoSearch
//
//  Created by Koushal, Kumar Ajitesh | Ajitesh | TDD on 2021/07/28.
//

import Foundation

struct RepositoryData: Codable {
    let incompleteResults : Bool?
    let items : [Repository]?
    let totalCount : Int?

    enum CodingKeys: String, CodingKey {
        case incompleteResults = "incomplete_results"
        case items = "items"
        case totalCount = "total_count"
    }
        
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        incompleteResults = try values.decodeIfPresent(Bool.self, forKey: .incompleteResults)
        items = try values.decodeIfPresent([Repository].self, forKey: .items)
        totalCount = try values.decodeIfPresent(Int.self, forKey: .totalCount)
    }
}

struct Repository: Codable {
    let id : Int?
    let name : String?
    let fullName: String?
    let descriptionField : String?
    let htmlUrl : String?
    let updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case fullName = "full_name"
        case descriptionField = "description"
        case htmlUrl = "html_url"
        case updatedAt = "updated_at"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        fullName = try values.decodeIfPresent(String.self, forKey: .fullName)
        descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField)
        htmlUrl = try values.decodeIfPresent(String.self, forKey: .htmlUrl)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
    }
}
