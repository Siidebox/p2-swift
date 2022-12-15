//
//  QuizItem.swift
//  Quiz con SwiftUI
//
//  Created by Santiago Pavón Gómez on 18/10/22.
//

import Foundation
// protocolo codable nos permite esxportar nuestros datos de swif a otro formato lo lee un objeto json y crea un objeto x( en nuestro caso Quizzitem) decodifica el json en QuizItem


//protocolo identifiable mi tipo de datos tenga un id para diferenciarlo de otro ( en react era "key")
struct QuizItem: Codable, Identifiable {
    let id: Int
    let question: String
    let answer: String
    let author: Author?
    let attachment: Attachment?
    var favourite: Bool //lo pongo como var porque let es invariable
    
    struct Author: Codable {
        let isAdmin: Bool?
        let username: String?
        let photo: Attachment?
        let accountType:Int?
        let profileId: Decimal?
        let profileName: String?
    }
    
    struct Attachment: Codable {
        let filename: String?
        let mime: String?
        let url: URL?
    }
}
