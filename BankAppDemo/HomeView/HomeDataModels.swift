//
//  HomeDataModels.swift
//  BankAppDemo
//
//  Created by David Viloria Ortega on 28/04/24.
//

import Foundation


struct AccountBalance: Codable {
    let code: String
    let title: String
    let message: String
    let data: BalanceData
}

struct BalanceData: Codable {
    let balance: Double
    let currency: String
}

struct BankMovement: Identifiable {
    let id = UUID()
    let description: String
}
