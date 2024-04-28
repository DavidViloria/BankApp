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
    
    var body: some View {
        VStack {
            Text("Bienvenido Ricardo")
                .font(.headline)
            Text("Tu saldo es")
                .font(.headline)
            
            Text("$ 1,203.56")
                .font(.title)
            
            HStack {
                Button(action: {
                    // Acción para transferir
                }) {
                    Text("Transferir")
                }
                
                Spacer()
                
                Button(action: {
                    // Acción para mi cuenta
                }) {
                    Text("Mi cuenta")
                }
            }
        }
        .padding()
    }
}


