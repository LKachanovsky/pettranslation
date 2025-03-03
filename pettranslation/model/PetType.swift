//
//  Pet.swift
//  pettranslation
//
//  Created by Leo Kachanovskyi on 25.02.2025.
//

import Foundation

enum PetType {
    case dog, cat
    
    var imageName: String {
        switch self {
        case .dog:
            return "dog"
        case .cat:
            return "cat"
        }
    }
    
    var speechText: String {
        switch self {
        case .dog:
            return "What are you doind, human?"
        case .cat:
            return "I'm hungry, feed me!"
        }
    }
}
