//
//  AuthenticationManager.swift
//  RealmExample
//
//  Created by Simon Berner on 21.03.22.
//

import Foundation
import RealmSwift

// @MainActor: any UI update which happen on this class, get automatically routed to the main thread
@MainActor final class AuthenticationManager: ObservableObject {

    @Published var email = ""
    @Published var password = ""
    @Published var isLoading = false
    @Published var errorMessage: String? = nil

    // computed property
    var authIsEnabled: Bool {
        email.count > 5 && password.count > 5
    }

    func anonymousLogin() {
        isLoading = true
        errorMessage = nil

        // Task: context which supports concurrency
        Task {
            do {
                let _ = try await app.login(credentials: .anonymous)
                isLoading = false
                print("anonymous login successful")
            } catch {
                isLoading = false
                errorMessage = "login failed: \(error.localizedDescription)"
            }
        }
    }

    func signup() {
        let client = app.emailPasswordAuth

        isLoading = true
        errorMessage = nil

        Task {
            do {
                try await client.registerUser(email: email, password: password)
                login()
            } catch {
                isLoading = false
                errorMessage = "signup failed: \(error.localizedDescription)"
            }
        }
    }

    func login() {
        let credentials = Credentials.emailPassword(email: email, password: password)

        isLoading = true
        errorMessage = nil

        Task {
            do {
                let user = try await app.login(credentials: credentials)
                isLoading = false
                print("\(user) logged-in successfully")
            } catch {
                isLoading = false
                errorMessage = "login failed: \(error.localizedDescription)"
            }
        }
    }

    func logout() {
        isLoading = true
        errorMessage = nil

        Task {
            do {
                try await app.currentUser?.logOut()
                isLoading = false
            } catch {
                isLoading = false
                errorMessage = "logout failed: \(error.localizedDescription)"
            }
        }
    }
}
