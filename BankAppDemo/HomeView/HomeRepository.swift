//
//  HomeRepository.swift
//  BankAppDemo
//
//  Created by David Viloria Ortega on 28/04/24.
//

import Foundation
import Combine


protocol BalanceRepository {
    func getBalance(for user: String, completion: @escaping (Result<AccountBalance, Error>) -> Void)
}

class BalanceRepositoryImpl: BalanceRepository {
    func getBalance(for user: String, completion: @escaping (Result<AccountBalance, Error>) -> Void) {
        guard let url = URL(string: "http://demo4617109.mockable.io/citibank-api/account/balance") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer-J12NF-cweij23r4kjlk23VDF24rojvmnrjnwi- 34rt4hbjkckm43", forHTTPHeaderField: "Authentication")
        let body = ["user": user]
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode(AccountBalance.self, from: data)
                    completion(.success(decodedResponse))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}

