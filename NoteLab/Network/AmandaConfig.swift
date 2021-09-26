//
//  AmandaConfig.swift
//  NoteLab
//
//  Created by Antonio Lara Navarrete on 22/09/21.
//
import Foundation

struct AmacaConfig {
    static let shared = AmacaConfig()
    var host: String {
        values["host"] as! String
    }
    var httpClient: HttpClient {
        HttpClient(session: URLSession.shared, baseUrl: host)
    }

    var apiToken: String? {
        get {
            UserDefaults.standard.string(forKey: "amaca.apitoken")
        }
    }

    func setApiToken(_ value: String) {
        UserDefaults.standard.set(value, forKey: "amaca.apitoken")
    }

    private var filepath: String {
        return Bundle.main.path(forResource: "Amaca", ofType: "plist")!
    }

    private var values: NSDictionary {
        return NSDictionary(contentsOfFile: filepath)!
    }
}
