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
    
    private var cancellables = Set<AnyCancellable>()
    
    // Validación de entrada
    func validateInput() -> Bool {
        let phoneRegex = "\\d{10}" // Expresión regular para verificar 10 dígitos
        let passwordRegex = "^.{8,16}$" // Expresión regular para verificar 8-16 caracteres
        
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        
        return phonePredicate.evaluate(with: phoneNumber) && passwordPredicate.evaluate(with: password)
    }
    
    // Función para iniciar sesión
    func login() {
        guard validateInput() else {
            errorMessage = "Por favor, complete todos los campos correctamente."
            return
        }
        
        // Simulación de inicio de sesión exitoso
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isAuthenticated = true
        }
    }
}

