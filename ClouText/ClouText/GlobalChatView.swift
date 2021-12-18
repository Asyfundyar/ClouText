//
//  GlobalChatView.swift
//  ClouText
//
//  Created by Ivana Sanchez Diaz on 11/30/21.
//

import SwiftUI

struct GlobalChatView: View {
    
    @EnvironmentObject var model: ViewModel
    @EnvironmentObject var lm : Locationer
    @State var userMsg = ""
    
    var body: some View {
        VStack {
            List (model.list) {
                item in
                Text("\(item.user) said: \(item.msg)")
            }
            
            Divider()
            
            HStack() {
                TextField("Your Message", text: $userMsg)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(-2)
                
                Button(action: {
                    //call add data
                    model.addData(msg: userMsg, lat: lm.location.latitude, lon: lm.location.longitude)
                    model.addLocations(email: model.auth.currentUser?.email ?? "", lat: lm.location.latitude, lon: lm.location.longitude)
                    //clear the text fields
                    userMsg = ""
                    bools = true
                }, label: {
                    Image(systemName: "arrow.up.circle")
                        .resizable()
                        .frame(width: 35, height: 35)
                        .padding(.leading, 2)
                })
            }
            .padding()
        }
    }
}

struct GlobalChatView_Previews: PreviewProvider {
    static var previews: some View {
        GlobalChatView()
    }
}
