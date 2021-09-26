//
//  GetApunteService.swift
//  NoteLab
//
//  Created by Antonio Lara Navarrete on 23/09/21.
//

import Foundation
import Foundation

struct ApunteService {
    private var endpoint: RestClient<Note>
    init() {
        endpoint = RestClient<Note>(client: AmacaConfig.shared.httpClient, path: "/apunte")
    }

    func create(_ model: Note, complete: @escaping (Result<Note?, Error>) -> Void ) {
        try? endpoint.create(model: model) { result in
            DispatchQueue.main.async { complete(result) }
        }
        
    }
}
