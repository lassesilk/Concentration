//
//  Card.swift
//  Concentration
//
//  Created by Lasse Silkoset on 19.03.2018.
//  Copyright © 2018 Lasse Silkoset. All rights reserved.
//

import Foundation

//Hashable so it can be used as a key in the dictionary in view controller
struct Card: Hashable
{
    var hashValue: Int { return identifier }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    var isFaceUp = false
    var isMatched = false
    private var identifier: Int
    
    //variabel that is stored with the type
    private static var identifierFactory = 0
    
    //a static func is a func you can not send to a class. you send it to the type itself. It is tied to the type.
   private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
