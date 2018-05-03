//
//  Concentration.swift
//  Concentration
//
//  Created by Lasse Silkoset on 19.03.2018.
//  Copyright © 2018 Lasse Silkoset. All rights reserved.
//

import Foundation

//Model base.
struct Concentration
{
    private(set) var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
            
//            var foundIndex: Int?
//            for index in cards.indices {
//                if cards[index].isFaceUp {
//                if foundIndex == nil {
//                    foundIndex = index
//                } else {
//                    return nil
//                    }
//                }
//            }
//            return foundIndex
        }
        
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
   mutating func chooseCard(at index: Int) {
        //assertions used to crash the program if you make a mistake in your code, when shipping to app store, assertsions are ignored. ex of crash:
        // passed index of -1.
        assert(cards.indices.contains(index), "Concentration. chooseCard(at: \(index): chosen index not in the cards")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                
                //Check if cards match
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            
            let card = Card()
            
            
            
        //let matchingCard = Card() <- This is to create another card who is equal to the first one.
        // when you assign a struct to another variabel, it copies it. So matchingCard is a copy of Card. So we can do
            // like this:
            let matchingCard = card
            
            cards.append(card)
            cards.append(matchingCard)
            //If i want I can just remove the let matchingCard and append card twice, since it is a copy.
            // like this:
            //cards += [card, card]
            
        }
        //TODO: Shuffle the cards
    }
}


extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}











