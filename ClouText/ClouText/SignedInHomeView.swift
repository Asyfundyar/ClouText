//
//  SignedInHomeView.swift
//  ClouText
//
//  Created by user203974 on 11/29/21.
//

import SwiftUI
import RealityKit
import CoreLocation
import MapKit
import CoreData

extension CLLocationCoordinate2D: Equatable {}

public func ==(lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
    return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
}

extension CLLocationCoordinate2D : Identifiable {
    public var id : String {"\(latitude),\(longitude)"}
}

struct AnnotationView: View {
  
  var body: some View {
    VStack() {
      Image(systemName: "cloud.fill")
        .font(.title)
        .foregroundColor(.pink)
      
      Image(systemName: "arrowtriangle.down.fill")
        .font(.caption)
        .foregroundColor(.purple)
        .offset(x: 0, y: -5)
    }
  }
}

struct SignedInHomeView: View {
    
    @State var isPresentVC = false
    @StateObject var lm = Locationer()
    @ObservedObject var model: ViewModel = ViewModel()
    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 38.9897, longitude: -76.9378), span: MKCoordinateSpan(latitudeDelta: 0.000000001, longitudeDelta: 0.000000001))
    
    @State var userMsg = ""
    @State private var tabSelection = 1
    
    init() {
        model.getData()
        model.getLocations()
    }
    
    var body: some View {
        TabView(selection: $tabSelection) {
            Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: true, userTrackingMode: .constant(.follow), annotationItems: model.msgLocations) { coor in
                MapAnnotation(coordinate: coor) {
                    NavigationLink {
                        ARViewContainer(coor: coor, model: model)
                    }
                    label: {
                      AnnotationView()
                    }
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                }
            }
                .tabItem {
                    Image(systemName: "mappin.and.ellipse")
                    Text("Map")
                }
            GlobalChatView()
                .tabItem {
                    Image(systemName: "simcard.fill")
                    Text("Global Chat")
                }
            ProfileView()
                .onAppear{
                    model.signedIn = model.isSignedin
                }
                .tabItem{
                    Image(systemName: "person.circle")
                    Text("Profile")
                }
        }
        .environmentObject(lm)
        .environmentObject(model)
    }
}

struct SignedInHomeView_Previews: PreviewProvider {
    static var previews: some View {
        SignedInHomeView()
    }
}
