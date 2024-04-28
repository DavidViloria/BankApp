//
//  ContentView.swift
//  BankAppDemo
//
//  Created by David Viloria Ortega on 27/04/24.
//

import SwiftUI
import Combine



struct LoginView: View {
    @ObservedObject var viewModel = LoginViewModel()
    @State private var isPresented = false // Controla la presentación de la pantalla de inicio
    
    var body: some View {
        VStack {
            TextField("Número telefónico", text: $viewModel.phoneNumber)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            SecureField("Contraseña", text: $viewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
            
            Button(action: {
                viewModel.login()
            }) {
                Text("Iniciar Sesión")
                    .padding()
                    .foregroundColor(.white)
                    .background(viewModel.validateInput() ? Color.blue : Color.gray) // Validación en el botón
                    .cornerRadius(8)
            }
            .padding()
            .disabled(!viewModel.validateInput()) // Validación para deshabilitar el botón
            
            Spacer()
        }
        .padding()
        .fullScreenCover(isPresented: $viewModel.isAuthenticated) {
            HomeView(isPresented: $isPresented)
        }
    }
}





struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
