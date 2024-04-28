//
//  HomeViewModel.swift
//  BankAppDemo
//
//  Created by David Viloria Ortega on 28/04/24.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var balance: Double = 0.0
    @Published var currency: String = ""
    private var repository: BalanceRepository
    private var cancellables = Set<AnyCancellable>()
    
    init(repository: BalanceRepository = BalanceRepositoryImpl()) {
        self.repository = repository
    }
    
    func getBalance(for user: String) {
        repository.getBalance(for: user) { [weak self] result in
            switch result {
            case .success(let accountBalance):
                DispatchQueue.main.async {
                    self?.balance = accountBalance.data.balance
                    self?.currency = accountBalance.data.currency
                    print("Balance: \(self?.balance ?? 0.0), Currency: \(self?.currency ?? "")") // Imprimir los datos
                }
            case .failure(let error):
                print("Error al obtener el balance: \(error)") // Imprimir el error
            }
        }
    }

}


