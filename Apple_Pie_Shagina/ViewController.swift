//
//  ViewController.swift
//  Apple_Pie_Shagina
//
//  Created by Student on 20/11/2018.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // список слов для угадывания
    var listOfWords = [
        "арбуз",
        "банан",
        "вертолёт",
        "груша",
        "домишко",
        "ежевика"
    ]
    
    // максимальноеиколичество неверных попыток
    var incjrrectMovesAllowed = 7
    
    // количество выигрышей и проигрышей
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    var totalLoses = 0 {
        didSet {
            newRound()
        }
    }
    
    var currentGame: Game! //текущая игра

    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //запуск функции нового раунда игры
        newRound()
    }
    
    // определение функции запуск нового раунда игры
    func newRound() {
        if !listOfWords.isEmpty {
            let newWord = listOfWords.removeFirst()
            
            currentGame = Game(
                word: newWord,
                incorrectMovesRemaining: incjrrectMovesAllowed,
                guessedLetters: []
            )
            
            enableLetterButtons(true)
            
            //updateUI()
            
        } else {
            enableLetterButtons(false)
        }
        updateUI()
        
    }
    
    // разрешить/запретить кнопки
    func enableLetterButtons(_ enable: Bool) {
        for button in buttons {
            button.isEnabled = enable
        }
    }
    
    // обновление интерфейса
    func updateUI() {
        //обновляем картинку
        let imageName = "Tree \(currentGame.incorrectMovesRemaining)"
        let image = UIImage(named: imageName)
        treeImageView.image = image
        
        //обновляем угадываемое слово
        var letters = [String]()
        for letter in currentGame.formattedWord {
            letters.append(String(letter))
        }
        let wordWithSpaces = letters.joined(separator: " ")
        
        correctWordLabel.text = wordWithSpaces
        
        // обновляем счет
        scoreLabel.text = "Выигрыши: \(totalWins), проигрыши: \(totalLoses)"
        
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let lettreString = sender.title(for: .normal)!
        let letter = Character(lettreString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateGameState()
    }
    
    // проверяем окончание игры
    func updateGameState() {
        if currentGame.incorrectMovesRemaining < 1 {
            // проиграли раунд
            totalLoses += 1
        } else if currentGame.word == currentGame.formattedWord {
            // выиграли раунд
            totalWins += 1
        } else {
            updateUI()
        }
        
    }
}

