//
//  HomeView.swift
//  BankAppDemo
//
//  Created by David Viloria Ortega on 27/04/24.
//

import SwiftUI
import Combine

struct HomeView: View {
    @Binding var isPresented: Bool
    @State var showMenu = false
    @ObservedObject var viewModel: HomeViewModel
    @ObservedObject var viewModelLogin = LoginViewModel()
    var username: String
    
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Text("Bienvenido \(username)")
                        .font(.headline)
                    Text("Tu saldo es")
                        .font(.headline)
                    Text("\(viewModel.currency) \(viewModel.balance, specifier: "%.2f")")
                        .font(.title)
                    
                    List(viewModel.movements) { movement in
                        Text(movement.description)
                    }
                    
                    Spacer()
                }
                .padding()
                .blur(radius: showMenu ? 20 : 0)
                .animation(.default)
                
                if showMenu {
                    MenuView(showMenu: $showMenu)
                }
            }
            .navigationBarItems(leading: (
                Button(action: {
                    withAnimation {
                        self.showMenu.toggle()
                    }
                }) {
                    Image(systemName: "line.horizontal.3")
                        .imageScale(.large)
                }
            ))
            .onAppear {
                viewModel.getBalance(for: viewModelLogin.phoneNumber)
            }
        }
    }
}



struct MenuView: View {
    @Binding var showMenu: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Button(action: {
                // Acción para perfil
            }) {
                Text("Perfil")
            }
            Button(action: {
                // Acción para sección de ayuda
            }) {
                Text("Sección de Ayuda")
            }
            Button(action: {
                // Acción para ver perfil
            }) {
                Text("Ver Perfil")
            }
            Button(action: {
                // Acción para pagos de servicio
            }) {
                Text("Pagos de Servicio")
            }
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .offset(x: showMenu ? 0 : -UIScreen.main.bounds.width)
        .animation(.default)
        .onTapGesture {
            withAnimation {
                self.showMenu = false
            }
        }
    }
}





