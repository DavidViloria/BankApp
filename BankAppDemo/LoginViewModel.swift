//
//  LoginViewModel.swift
//  BankAppDemo
//
//  Created by David Viloria Ortega on 27/04/24.
//


import SwiftUI
import Combine


protocol UserRepository {
    func login(phoneNumber: String, password: String) -> AnyPublisher<Bool, Never>
}

class UserRepositoryImpl: UserRepository {
    func login(phoneNumber: String, password: String) -> AnyPublisher<Bool, Never> {
        // Aquí es donde harías la llamada a la API o accederías a la base de datos
        return Future { promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                promise(.success(true))
            }
        }
        .eraseToAnyPublisher()
    }
}

class LoginViewModel: ObservableObject {
    @Published var phoneNumber: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String?
    @Published var isAuthenticated: Bool = false
    
    private var userRepository: UserRepository
    private var cancellables = Set<AnyCancellable>()
    
    init(userRepository: UserRepository = UserRepositoryImpl()) {
        self.userRepository = userRepository
    }
    
    func validateInput() -> Bool {
        let phoneRegex = "\\d{10}" // Expresión regular para verificar 10 dígitos
        let passwordRegex = "^.{8,16}$" // Expresión regular para verificar 8-16 caracteres
        
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        
        return phonePredicate.evaluate(with: phoneNumber) && passwordPredicate.evaluate(with: password)
    }
    
    // Función para iniciar sesión
    func login() -> Bool {
        if validateInput() {
            userRepository.login(phoneNumber: phoneNumber, password: password)
                .sink { isAuthenticated in
                    if isAuthenticated {
                        self.isAuthenticated = true
                    } else {
                        self.errorMessage = "Por favor, complete todos los campos correctamente."
                    }
                }
                .store(in: &cancellables)
            return true
        } else {
            return false
        }
    }
}


