//
//  SignInView.swift
//  ClouText
//
//  Created by Asfandyar Khan on 11/29/21.
//

import SwiftUI

struct SignInView: View {
    
    @EnvironmentObject var model: ViewModel
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        VStack {
            Image("logo")
                .resizable()
                .frame(width: 200, height: 200)
                .padding(.bottom, -30)
            
            LinearGradient(gradient: Gradient(colors: [.pink, .blue]),
                           startPoint: .leading,
                           endPoint: .trailing)
                .mask(
                    Text("ClouText")
                        .font(.largeTitle)
                        .bold()
                )
                .frame(width: 300, height: 60)
            
            TextField("Email Address", text: $email)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .padding()
                .background(Color(.secondarySystemBackground))
            
            SecureField("Password", text: $password)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .padding()
                .background(Color(.secondarySystemBackground))
            
            Button(action: {
                guard !email.isEmpty, !password.isEmpty else {
                    return
                }
                model.signIn(email: email, password: password)
                
            }, label: {
                Text("Sign in")
                    .font(.title)
                    .padding()
                    .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(35)
                    .foregroundColor(.white)
                    .frame(width: 250, height: 50)
            })
                .padding()
            NavigationLink("Create Account", destination: SignUpView())
                .padding()
            .navigationBarTitle("Back")
            .navigationBarHidden(true)
        }
        .onAppear(perform: model.signOut)
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
