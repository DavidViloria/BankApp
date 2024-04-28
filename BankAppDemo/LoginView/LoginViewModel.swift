//
//  LoginViewModel.swift
//  BankAppDemo
//
//  Created by David Viloria Ortega on 27/04/24.
//


import SwiftUI
import Combine

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

    func login() {
        if validateInput() {
            let request = LoginRequest(user: phoneNumber, password: password)
            userRepository.login(request: request)
                .sink { completion in
                    switch completion {
                    case .failure(let error):
                        if (error as? URLError)?.code == .badServerResponse {
                            self.errorMessage = "Hubo un error con la API. Por favor, inténtalo de nuevo más tarde."
                        } else if (error as? URLError)?.code == .userAuthenticationRequired {
                            self.errorMessage = "Por favor, verifica que tu número de teléfono y contraseña sean correctos."
                        }
                    case .finished:
                        break
                    }
                } receiveValue: { isAuthenticated in
                    if isAuthenticated {
                        self.isAuthenticated = true
                    }
                }
                .store(in: &cancellables)
            self.isAuthenticated = true
        } else {
            errorMessage = "Por favor, completa todos los campos correctamente."
        }
    }


}






