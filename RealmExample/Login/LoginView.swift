//
//  LoginView.swift
//  RealmExample
//
//  Created by Simon Berner on 21.03.22.
//

import SwiftUI

struct LoginView: View {

    // Observed objects marked with the @StateObject property wrapper don’t get destroyed and re-instantiated at times their containing view struct redraws.
    // LoginView is the owner of the authManager
    @StateObject var authManager = AuthenticationManager()

    var body: some View {
        VStack {
            Text("Login").font(.title)
            TextField("email", text: $authManager.email).textFieldStyle(.roundedBorder)
            TextField("password", text: $authManager.password).textFieldStyle(.roundedBorder)

            if authManager.isLoading {
                ProgressView()
            }

            if let error = authManager.errorMessage {
                Text(error).foregroundColor(.red)
            }

            HStack {
                Button {
                    authManager.signup()
                } label: {
                    Text("sign up")
                }
                .buttonStyle(.bordered)
                .disabled(!authManager.authIsEnabled)

                Button {
                    authManager.login()
                } label: {
                    Text("log in")
                }
                .buttonStyle(.borderedProminent)
                .disabled(!authManager.authIsEnabled)
            }
            .padding()

            Button("log in anonymously") {
                authManager.anonymousLogin()
            }
            .disabled(authManager.isLoading)

        }
        .padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
