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
    @State private var isPresented = false
    @State private var showingAlert = false
    
    var body: some View {
        VStack {
            TextField("Número telefónico", text: $viewModel.phoneNumber)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .onReceive(Just(viewModel.phoneNumber)) { newValue in
                    if newValue.count > 10 {
                        viewModel.phoneNumber = String(newValue.prefix(10))
                    }
                }
            
            SecureField("Contraseña", text: $viewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .onReceive(Just(viewModel.password)) { newValue in
                    if newValue.count > 16 {
                        viewModel.password = String(newValue.prefix(16))
                    }
                }
            
            Button(action: {
                if viewModel.login() {
                } else {
                    self.showingAlert = true
                }
            }) {
                Text("Iniciar Sesión")
                    .padding()
                    .foregroundColor(.white)
                    .background(viewModel.validateInput() ? Color.blue : Color.gray)
                    .cornerRadius(8)
            }
            .padding()
            .disabled(!viewModel.validateInput())
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Error de autenticación"), message: Text("Verifica que tus credenciales sean correctas"), dismissButton: .default(Text("Aceptar")))
            }
            
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
