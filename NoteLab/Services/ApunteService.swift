//
//  GetApunteService.swift
//  NoteLab
//
//  Created by Antonio Lara Navarrete on 23/09/21.
//

import Foundation
import Foundation

struct CreateUserService {
    private var endpoint: RestClient<Note>
    init() {
        endpoint = RestClient<User>(client: AmacaConfig.shared.httpClient, path: "/user")
    }

    func create(_ model: User, complete: @escaping (Result<User?, Error>) -> Void ) {
        try? endpoint.create(model: model) { result in
            DispatchQueue.main.async { complete(result) }
        }
    }
}
