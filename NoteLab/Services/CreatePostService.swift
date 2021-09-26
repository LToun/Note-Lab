//
//  CreatePostService.swift
//  NoteLab
//
//  Created by Antonio Lara Navarrete on 24/09/21.
//
import Foundation

struct CreatePostService {
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
