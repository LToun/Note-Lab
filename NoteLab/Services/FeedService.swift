//
//  FeedService.swift
//  NoteLab
//
//  Created by Antonio Lara Navarrete on 23/09/21.
//

import Foundation

struct FeedService {
    private var endpoint: RestClient<Note>

    init() {
        endpoint = RestClient<Note>(client: AmacaConfig.shared.httpClient, path: "/apunte")
    }

    func load(completion: @escaping ([Note]) -> Void) {
        endpoint.list { result in
            guard let posts = try? result.get() else { return }
            DispatchQueue.main.async { completion(posts) }
        }
    }
}
