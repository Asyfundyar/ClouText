//
//  ProfileView.swift
//  ClouText
//
//  Created by user203974 on 11/29/21.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var model : ViewModel
    
    var body: some View {
        VStack {
            Image("Profile")
                .resizable()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .overlay(
                    Circle().stroke(Color.black, lineWidth: 2))
                .padding()
            
            VStack (alignment: .leading) {
                HStack(alignment: .top) {
                    Text("Email")
                        .font(.subheadline)
                        .bold()
                    Spacer()
                    Text("\(model.auth.currentUser?.email ?? "")")
                        .font(.subheadline)
                }.padding()
                HStack(alignment: .top) {
                    Text("Likes")
                        .font(.subheadline)
                        .bold()
                    Spacer()
                    Text("300")
                        .font(.subheadline)
                }.padding()
                HStack(alignment: .top) {
                    Text("Country")
                        .font(.subheadline)
                        .bold()
                    Spacer()
                    Text("United States")
                        .font(.subheadline)
                }.padding()
            }
            
            Spacer()
            
            NavigationLink {
                SignInView()
            } label: {
                Text("Sign Out")
                    .font(.title)
                    .padding()
                    .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.red]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(35)
                    .foregroundColor(.white)
                    .frame(width: 200, height: 40)
            }
            .padding(40)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
