//
//  ContentView.swift
//  ClouText
//
//  Created by user203974 on 11/10/21.
//

import SwiftUI
import RealityKit
import CoreLocation
import MapKit
import CoreData

var bools = true

struct ContentView : View {
    
    @EnvironmentObject var model: ViewModel
    
    var body: some View {
        VStack {
            NavigationView {
                if model.signedIn {
                    SignedInHomeView()
                } else {
                    SignInView()
                }
            }
            .navigationBarTitle("Sign In")
            .navigationBarHidden(true)
        }
    }
}

struct testServerModel: View {
    @EnvironmentObject var model: ViewModel
    @EnvironmentObject var lm : Locationer
    @State var userMsg = ""
    
    var body : some View {
        VStack {
            List(model.list) {
                item in
                //TODO: swipe to delete for ios 15
                HStack {
                    Text("\(item.user) said: \(item.msg)")
                    Spacer()
                }
                
            }
            
            Divider()
            
            VStack(spacing: 5) {
                TextField("Message", text: $userMsg)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {
                    
                    //call add data
                    model.addData(msg: userMsg, lat: lm.location.latitude, lon: lm.location.longitude)
                    model.addLocations(email: model.auth.currentUser?.email ?? "", lat: lm.location.latitude, lon: lm.location.longitude)
                    //clear the text fields
                    userMsg = ""
                    bools = true
                    
                    }, label: {
                        Text("Add Message")
                    })
            }
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
