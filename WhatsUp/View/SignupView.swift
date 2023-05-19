//
//  SignupView.swift
//  WhatsUp
//
//  Created by Sergio Herrera on 5/18/23.
//

import SwiftUI
import FirebaseAuth

struct SignupView: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var username = ""
    @State private var errorMessage = ""
    
    private var isFormValid: Bool {
        !email.isEmptyOrWhiteSpace && !password.isEmptyOrWhiteSpace && !username.isEmptyOrWhiteSpace
    }
    
    private func updateUsername(user: User) async {
        let request = user.createProfileChangeRequest()
        request.displayName = username
        try? await request.commitChanges()
    }
    
    private func signUp() async {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            await updateUsername(user: result.user)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    var body: some View {
        Form {
            TextField("Email", text: $email)
                .textInputAutocapitalization(.never)
            SecureField("Password", text: $password)
                .textInputAutocapitalization(.never)
            TextField("Username", text: $username)
                .textInputAutocapitalization(.never)
            
            HStack {
                Spacer()
                
                Button("Signup") {
                    Task {
                        await signUp()
                    }
                }.disabled(!isFormValid)
                    .buttonStyle(.borderless)
                
                Button("Login") {
                    // take user to login screen
                }.buttonStyle(.borderless)
                
                Spacer()
            }
        }
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
