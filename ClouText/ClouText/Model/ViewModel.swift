//
//  ViewModel.swift
//  ClouText
//
//  Created by Jason Jiang on 11/14/21.
//

import Foundation
import Firebase
import FirebaseAuth
import CoreLocation

class ViewModel: ObservableObject {
    
    let auth = Auth.auth()
    
    @Published var list = [Message]()
    @Published var signedIn = false
    @Published var signedOut = false
    
    @Published var msgLocations : [CLLocationCoordinate2D] = []
    
    @Published var locationsArr = [LocationModel]()
    
    var isSignedin: Bool {
        return auth.currentUser != nil
    }
    
    func signOut() {
        try? auth.signOut()
        
        DispatchQueue.main.async {
            self.signedIn = false
            self.signedOut = true
        }
        
    }
    
    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) {
            [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                //success
                self?.signedIn = true
            }
        }
    }
    
    func signUp(email: String, password: String) {
        auth.createUser(withEmail: email, password: password) {
            [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                //success
                self?.signedIn = true
            }
            
        }
    }
    
    func deleteData(msgToDelete: Message) {
        //get a reference to the db
        let db = Firestore.firestore()
        
        //specify the msg to delete
        db.collection("messages").document(msgToDelete.id).delete {
            error in
            
            //check for errors
            if error == nil {
                //no errors
                
                //up the ui from the main thread
                DispatchQueue.main.async {
                    //remove the msg that was just deleted
                    self.list.removeAll() {
                        msg in
                        
                        //check for the msg to remove
                        return msg.id == msgToDelete.id
                        
                    }
                }
                
            } else {
                //handle the error
            }
        }
    }
    
    func addData(msg: String, lat: CLLocationDegrees, lon: CLLocationDegrees) {
        
        //get a reference to the database
        let db = Firestore.firestore()
        var email = ""
        
        //getting the user email
        let user = Auth.auth().currentUser
        
        if let user = user {
            //getting user email
            email = user.email ?? "default@gmail.com"
        }

        self.msgLocations.append(CLLocationCoordinate2D(latitude: Double(lat), longitude: Double(lon)))
        
        //add a documennt to a collection
        db.collection("messages").addDocument(data: ["user": email, "msg": msg, "latitude": Double(lat), "longitude": Double(lon)]) {
            error in
            
            //check for errors
            if error == nil {
                //no errors
                
                //call getData and update the ui
                self.getData()
                
            } else {
                //handle the error
            }
        }
    }
    
    func getData() {
        
        //Get a reference to the database
        let db = Firestore.firestore()

        
        //Read the documents at a specific path
        db.collection("messages").getDocuments { snapshot, error in
            
            //check for errors
            if error == nil {
                //no errors
                if let snapshot = snapshot {
                    
                    //update the list property in the main thread
                    //only need it if we need code to cause ui change
                    //need to look deeper into it
                    //without it the app will run in backgrounnd
                    
                    DispatchQueue.main.async {
                        //get all the messages
                        self.list = snapshot.documents.map {
                            m in
                            
                            //for each message inside messages
                            return Message(id: m.documentID,
                                           user: m["user"] as? String ?? "fail to format",
                                           msg: m["msg"] as? String ?? "fail to format",
                                           latitude: m["latitude"] as? Double ?? 0.0,
                                           longitude: m["longitude"] as? Double ?? 0.0)
                        }
                    }
                    
                    DispatchQueue.main.async {
                        for item in self.list {
                            self.msgLocations.append(CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longitude))
                        }
                    }
                }
            } else {
                //handle the error
            }
        }
    }
    
    func getLocations() {
        let fire = Firestore.firestore()
        fire.collection("Locations").getDocuments { snapshot, error in
            if error == nil {
                if let snapshot = snapshot {
                    DispatchQueue.main.async {
                        self.locationsArr = snapshot.documents.map { document in
                            return LocationModel(email: document["email"] as? String ?? "",
                                                 latitude: document["latitude"] as? Double ?? 0.0,
                                                 longitude: document["longitude"] as? Double ?? 0.0)
                        }
                    }
                }
            } else {
                
            }
        }
    }
    
    func addLocations(email: String, lat: CLLocationDegrees, lon: CLLocationDegrees) {
        //get a reference to the database
        let db = Firestore.firestore()
        
        //add a documennt to a collection
        db.collection("locations").document().setData(["email": email, "latitude": Double(lat), "longitude": Double(lon)]) {
            error in
            
            //check for errors
            if error == nil {
                //no errors
                //call getData and update the ui
                self.getLocations()
                
            } else {
                //handle the error
            }
        }
    }
    
}
