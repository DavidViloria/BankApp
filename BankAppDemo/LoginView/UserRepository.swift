//
//  UserRepository.swift
//  BankAppDemo
//
//  Created by David Viloria Ortega on 27/04/24.
//

import Foundation
import Combine


protocol UserRepository {
    func login(request: LoginRequest) -> AnyPublisher<Bool, Error>
}

class UserRepositoryImpl: UserRepository {
    private let url = URL(string: "/citibank-api/authentication/login")!
    private let apiKey = "CITI-HM13FJ345"
    
    func login(request: LoginRequest) -> AnyPublisher<Bool, Error> {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue(apiKey, forHTTPHeaderField: "API-KEY")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = try? JSONEncoder().encode(request)
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
                guard loginResponse.code == "0" else {
                    throw URLError(.userAuthenticationRequired)
                }
                return true
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

}

