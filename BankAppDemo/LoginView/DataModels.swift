//
//  DataModels.swift
//  BankAppDemo
//
//  Created by David Viloria Ortega on 27/04/24.
//

import Foundation

struct LoginRequest: Codable {
    let user: String
    let password: String
}

struct LoginResponse: Codable {
    let code: String
    let title: String
    let message: String
    let data: LoginData
}

struct LoginData: Codable {
    let token: String
    let expiration_time: Int
}
