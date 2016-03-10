//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var phraseLabel: UILabel!
    @IBOutlet weak var guessTextField: UITextField!
    @IBOutlet weak var guessedLabel: UILabel!
    
    var phrase: String = ""
    var partialPhrase: String = ""
    var incorrectGuessedChars = [String]()
    var correctGuessedChars = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let hangmanPhrases = HangmanPhrases()
        self.phrase = hangmanPhrases.getRandomPhrase()
        
        print(phrase)
        partialPhrase = initializePhrase(phrase)
        phraseLabel.text = partialPhrase
        guessedLabel.text = "None. Guess a letter!"
        guessTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard.
        if textField.text == "poop" { // needs checks to make sure valid letter, only one letter is entered, letter has not been guessed already
            print("POOOOOOP")
        } else {
            let c: String! = textField.text
            if guessLetter(c) {
                correctGuessedChars.append(c)
            } else {
                incorrectGuessedChars.append(c)
                var newString: String = ""
                for c in incorrectGuessedChars {
                    newString = newString + " " + c
                }
                guessedLabel.text = newString
            }
        }
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        phraseLabel.text = self.partialPhrase //change this
    }
    
    func guessLetter(c: String) -> Bool {
        var newString = ""
        for index in 0..<(phrase.characters.count) {
            let i = phrase.startIndex.advancedBy(index)
            let correctLetter = phrase[i]
            if c == String(correctLetter) {
                newString = newString + c
            } else {
                print(partialPhrase)
                newString.append(partialPhrase[i])
            }
        }
        if newString == partialPhrase {
            return false
        } else {
            self.partialPhrase = newString
            return true
        }
    }
    
    func initializePhrase(inputPhrase: String) -> String {
        var outputString: String = ""
        for c in inputPhrase.characters {
            if (c == " ") {
                outputString = outputString + " "
            } else {
                outputString = outputString + "-"
            }
        }
        return outputString
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
