//
//  Question.swift
//  Trivia
//
//  Created by Andry on 3/12/25.
//

class Question {
    let text: String
    let options: [String]
    let correctAnswerIndex: Int
    
    init(text: String, options: [String], correctAnswerIndex: Int) {
        self.text = text
        self.options = options
        self.correctAnswerIndex = correctAnswerIndex
    }
}
