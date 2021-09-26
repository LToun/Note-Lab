//
//  CreateUserService.swift
//  NoteLab
//
//  Created by Antonio Lara Navarrete on 22/09/21.
//

import Foundation

struct CreateUserService {
    private var endpoint: RestClient<User>
    init() {
        endpoint = RestClient<User>(client: AmacaConfig.shared.httpClient, path: "/user")
    }

    func create(_ model: User, complete: @escaping (Result<User?, Error>) -> Void ) {
        try? endpoint.create(model: model) { result in
            DispatchQueue.main.async { complete(result) }
        }
    }
}
