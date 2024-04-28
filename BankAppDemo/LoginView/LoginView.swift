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
    
    @State private var homeViewModel = HomeViewModel(repository: BalanceRepositoryImpl())
    
    var body: some View {
        VStack {
            TextField("Número telefónico", text: $viewModel.phoneNumber)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            SecureField("Contraseña", text: $viewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: {
                viewModel.login()
                if viewModel.errorMessage != nil {
                    self.showingAlert = true
                }
            }) {
                Text("Iniciar Sesión")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding()
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Error de autenticación"), message: Text(viewModel.errorMessage ?? ""), dismissButton: .default(Text("Aceptar")))
            }
            
            Spacer()
        }
        .padding()
        .fullScreenCover(isPresented: $viewModel.isAuthenticated) {
            // Pasar la instancia de HomeViewModel a HomeView
            HomeView(isPresented: $isPresented, viewModel: homeViewModel)
        }
    }
}










struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
