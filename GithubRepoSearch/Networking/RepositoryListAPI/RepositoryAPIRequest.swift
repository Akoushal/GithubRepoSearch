//
//  RepositoryAPIRequest.swift
//  GithubRepoSearch
//
//  Created by Koushal, Kumar Ajitesh | Ajitesh | TDD on 2021/07/28.
//

import Foundation

final class RepositoryAPIRequest {
    let session: URLSession
    let baseUrl = "https://api.github.com/search/repositories"
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func fetchRepositories(with query: String, request: RepositoryAPIRequest, completion: @escaping (Result<RepositoryData, DataResponseError>) -> Void) {
        // 1
        guard var components = URLComponents(string: baseUrl) else { return}
        components.queryItems = [URLQueryItem(name: "q", value: query)]
        guard let url = components.url else { return}
        let urlRequest = URLRequest(url: url)
        
        // 2
        session.dataTask(with: urlRequest, completionHandler: { data, response, error in
            // 3
            guard
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.hasSuccessStatusCode,
                let data = data
            else {
                completion(Result.failure(DataResponseError.network))
                return
            }
            
            // 4
            guard let decodedResponse = try? JSONDecoder().decode(RepositoryData.self, from: data) else {
                completion(Result.failure(DataResponseError.decoding))
                return
            }
            
            // 5
            completion(Result.success(decodedResponse))
        }).resume()
    }
}
