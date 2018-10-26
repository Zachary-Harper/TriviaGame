//
//  triviaQuestions.swift
//  TriviaGame
//
//  Created by Zachary Harper on 10/19/18.
//  Copyright © 2018 Zachary Harper. All rights reserved.
//

import Foundation

class TriviaQuestion {
    //string storing the question
    var question: String
    //array storing strings of the answers
    var answers: [String]
    //int storing the index of the correct answer in the answer array
    var correctAnswerIndex: Int
    //computed property that returns the correct answer using the answer index
    var correctAnswer: String {
        return answers[correctAnswerIndex]
    }
    
    init(question : String, answers : [String], correctAnswerIndex: Int) {
        self.answers = answers
        self.correctAnswerIndex = correctAnswerIndex
        self.question = question
             }
    
}

