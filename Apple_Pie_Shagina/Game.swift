//
//  Game.swift
//  Apple_Pie_Shagina
//
//  Created by Student on 27/11/2018.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

struct Game {
    var word: String   //загаданное слово
    var incorrectMovesRemaining: Int  //количество оставшихся попыток
    
    // список нажатых букв
    var guessedLetters: [Character]
    
    // отображаемое слово
    var formattedWord: String {
        var guessedWord = ""
        
        for letter in word {
            if guessedLetters.contains(letter) {
                guessedWord += "\(letter)"
            } else {
                guessedWord += "_"
            }
        }
        
        return guessedWord
        
    }
    
    
    // обработка нажатой буквы
    mutating func playerGuessed(letter: Character){
        guessedLetters.append(letter)
        
        // проверяем, содержится ли буква в слове
        if !word.contains(letter){
            incorrectMovesRemaining -= 1
        }
    }
}
