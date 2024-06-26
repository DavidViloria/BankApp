//
//  UserRepository.swift
//  BankAppDemo
//
//  Created by David Viloria Ortega on 27/04/24.
//

import Foundation
import Combine

enum APIError: Int, Error {
    case authenticationError = 4001
    case userBlocked = 4002
}

protocol UserRepository {
    func login(request: LoginRequest) -> AnyPublisher<LoginResponse, Error>
}


class UserRepositoryImpl: UserRepository {
    private let url = URL(string: "http://demo4617109.mockable.io/citibank-api/authentication/login")!
    private let apiKey = "CITI-HM13FJ345"
    
    func login(request: LoginRequest) -> AnyPublisher<LoginResponse, Error> {
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
                    if let errorCode = Int(loginResponse.code), let error = APIError(rawValue: errorCode) {
                        throw error
                    } else {
                        throw URLError(.badServerResponse)
                    }
                }
                return loginResponse
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }


}

