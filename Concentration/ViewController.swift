//
//  ViewController.swift
//  Concentration
//
//  Created by Lasse Silkoset on 18.03.2018.
//  Copyright © 2018 Lasse Silkoset. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    //classes get a free init as long as they`re vars are initalized.
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }

    //Computed properties. Everytime flipCount gets set, it updates the label
    private(set) var flipCount = 0 {
        didSet {
           updateFlipCountLabel()
        }
    }
    
    private func updateFlipCountLabel() {
        let attributes: [NSAttributedStringKey:Any] = [
            .strokeWidth : 5.0,
            .strokeColor : UIColor.orange
            
        ]
        let attributedString = NSAttributedString(string: "Flips: \(flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
            updateFlipCountLabel()
        }
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
           game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Chosen card was not in cardButtons")
        }
        
    }
    private func updateViewFromModel() {
        //indices is a method in array that return a countable range
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = UIColor.white
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : UIColor.orange
            }
        }
    }
    
    //private var emojiChoices = ["🦇", "😱", "🙀", "😈", "🎃", "👻", "🍭", "🍬", "🍎"]
    
    private var emojiChoices = "🦇😱🙀😈🎃👻🍭🍬🍎"
    
    private var emoji = [Card:String]()
    
    private func emoji(for card: Card) -> String {
       
        if emoji[card] == nil, emojiChoices.count > 0 {
            
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            
            //remove at: returns the value it removes, and puts it in the dictionary
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
            
        }
       return emoji[card] ?? "?"
    }
    
    
}

extension Int {
    var arc4random: Int {
        if self > 0 {
        return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
          return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}







