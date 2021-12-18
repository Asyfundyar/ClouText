//
//  MessageModel.swift
//  ClouText
//
//  Created by Jason Jiang on 11/14/21.
//

import Foundation

//represent the data model of the message
struct Message: Identifiable {
    var id: String
    var user: String
    var msg: String
    var latitude: Double
    var longitude: Double
}
