//
//  ViewController.swift
//  TriviaGame
//
//  Created by Zachary Harper on 10/17/18.
//  Copyright © 2018 Zachary Harper. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {

    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var answerAButton: UIButton!
    
    @IBOutlet weak var answerBButton: UIButton!
    
    @IBOutlet weak var answerCButton: UIButton!
    
    @IBOutlet weak var answerDButton: UIButton!
    
    @IBAction func resetButtonTapped(_ sender: Any) {
        resetGame()
    }
    
    var questions = [TriviaQuestion]()
    var questionsPlaceholder = [TriviaQuestion]()
    
    
    var currentIndex: Int!
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    var currentQuestion: TriviaQuestion! {
        didSet {
            if let currentQuestion = currentQuestion {
                questionLabel.text = currentQuestion.question
                answerAButton.setTitle(currentQuestion.answers[0], for: .normal)
                answerBButton.setTitle(currentQuestion.answers[1], for: .normal)
                answerCButton.setTitle(currentQuestion.answers[2], for: .normal)
                answerDButton.setTitle(currentQuestion.answers[3], for: .normal)
                setNewColors()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        populateQuestion()
        getNewQuestion()
        
        
    
    
    }
    
    func populateQuestion() {
        let question1 = TriviaQuestion(question: "Who invented the Polio Vaccine?", answers: ["Steven Hawking", "Dr. Jonas Salk", "Dr. Oz", "Opra"], correctAnswerIndex: 1)
        
        let question2 = TriviaQuestion(question: "How did Marie Curie's husband die?", answers: ["Via Radiation", "Assassinated", "Lightning Bolt to the face","Run over by a horse drawn carriage"], correctAnswerIndex: 3)
        
        let question3 = TriviaQuestion(question: "What is George Washinton Carver famous for?", answers: ["Domesticating LLama's","Swimming the atlantic", "Creating Life","Peanut Experiments"], correctAnswerIndex: 3)
        
        let question4 = TriviaQuestion(question: "Who invented the first camera?", answers: ["Joseph Nicephore Niepce","Some french guy","Nikola Tesla","God"], correctAnswerIndex: 0)
        
        questions = [question1, question2, question3, question4]
    }
    
    
    
    func getNewQuestion(){
        if questions.count > 0 {
            currentIndex = Int.random(in: 0..<questions.count)
            currentQuestion = questions[currentIndex]
        } else {
                showGameOverAlert()
        }
    }
    
    func showGameOverAlert() {
        let endAlert = UIAlertController(title: "Trivia Results", message: "You scored \(score) out of a possible \(questionsPlaceholder.count)", preferredStyle: UIAlertController.Style.alert)
        
        let resetAction =  UIAlertAction(title: "Reset", style: UIAlertAction.Style.default){
            UIAlertAction
            in
            self.resetGame()
          
        }
        endAlert.addAction(resetAction)
        self.present(endAlert, animated: true, completion: nil)
    }
    let backgroundColors = [
    UIColor(red: 69/255, green: 179/255, blue: 157/255, alpha: 1)
        ,
    UIColor(red: 247/255, green: 220/255, blue: 111/255, alpha: 1)
        ,
    UIColor(red: 41/255, green: 128/255, blue: 185/255, alpha: 1)
        ,
    UIColor(red: 118/255, green: 215/255, blue: 196/255, alpha: 1)
    
    ]
    
    func setNewColors() {
        let randomNumber = Int.random(in: 1 ... 100)
        let randomColorA = backgroundColors[randomNumber % 4]
        let randomColorB = backgroundColors[(randomNumber + 1) % 4]
        let randomColorC = backgroundColors[(randomNumber + 2) % 4]
        let randomColorD = backgroundColors[(randomNumber + 3) % 4]
        
        answerAButton.backgroundColor = randomColorA
        answerBButton.backgroundColor = randomColorB
        answerCButton.backgroundColor = randomColorC
        answerDButton.backgroundColor = randomColorD

    }
    @IBAction func unwindToQuizScreen(seque:UIStoryboardSegue){}

    
    @IBAction func answerTapped(_ sender: UIButton) {
        if currentQuestion.correctAnswerIndex == sender.tag {
            score += 1
            showCorrectAnswerAlert()
        }else {
            showIncorrectAnswerAlert()
            
        }
            }
    
    func showCorrectAnswerAlert() {
        let correctAnswer = UIAlertController(title: "Correct", message: "\(currentQuestion.correctAnswer) is the correct answer. Congrats!!!", preferredStyle: .actionSheet)
        let okayAction = UIAlertAction(title: "Thank you!", style: UIAlertAction.Style.default){
            UIAlertAction in
            self.questionsPlaceholder.append(self.questions[self.currentIndex])
            
            self.questions.remove(at: self.currentIndex)
            self.getNewQuestion()
        }
        correctAnswer.addAction(okayAction)
        self.present(correctAnswer, animated: true, completion: nil )
    }
    
    func showIncorrectAnswerAlert() {
        let incorrectAnswer = UIAlertController(title: "Incorrect", message: "\(currentQuestion.correctAnswer) is the` the correct answer. Sorry", preferredStyle: .actionSheet)
        let okayAction = UIAlertAction(title: "...SORRY", style: UIAlertAction.Style.default){
            UIAlertAction in
            self.questionsPlaceholder.append(self.questions[self.currentIndex])
            
            self.questions.remove(at: self.currentIndex)
            self.getNewQuestion()
        }
        incorrectAnswer.addAction(okayAction)
        self.present(incorrectAnswer, animated: true, completion: nil )

    }
    func resetGame() {
        score = 0
        if !questions.isEmpty {
            questionsPlaceholder.append(contentsOf: questions)
            questions.removeAll()
        }
        questions = questionsPlaceholder
        questionsPlaceholder.removeAll()
        getNewQuestion()
    }
    
    
    
    
}











