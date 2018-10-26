//
//  AddQuestionViewController.swift
//  TriviaGame
//
//  Created by Zachary Harper on 10/19/18.
//  Copyright © 2018 Zachary Harper. All rights reserved.
//

import UIKit

class AddQuestionViewController: UIViewController {

    @IBOutlet weak var newQuestionTextField: UITextField!
    
    @IBOutlet weak var answerATextField: UITextField!
    
    @IBOutlet weak var answerBTextField: UITextField!
    
    @IBOutlet weak var answerCTextField: UITextField!
    
    @IBOutlet weak var answerDTextField: UITextField!
    
    @IBOutlet weak var correctAnswerSelector: UISegmentedControl!
    
    var newTrivia: TriviaQuestion?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: Selector("endEditing:")))
        // Do any additional setup after loading the view.
    }
    

    

    
    
    @IBAction func returnToQuizScreen(_ sender: Any) {
        performSegue(withIdentifier: "unwindSegueToQuizScreen", sender: self)
    }
    
    
    @IBAction func addTapped(_ sender: Any) {
        guard
        let question = newQuestionTextField.text, !question.isEmpty,
        let a = answerATextField.text , !a.isEmpty,
        let b = answerBTextField.text , !b.isEmpty,
        let c = answerCTextField.text , !c.isEmpty,
        let d = answerDTextField.text , !d.isEmpty
        else {
            let errorAlert = UIAlertController(title: "Error", message: "Please fill all fields or press cancel to return to quiz.", preferredStyle: UIAlertController.Style.alert)
            let dismissAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) {UIAlertAction in }
            errorAlert.addAction(dismissAction)
            self.present(errorAlert, animated: true, completion: nil)
            return
        }
        newTrivia = TriviaQuestion(question: question, answers: [a,b,c,d], correctAnswerIndex: correctAnswerSelector.selectedSegmentIndex)
        performSegue(withIdentifier: "unwindSegueToQuizScreen", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
        let destinationVC = segue.destination as? QuizViewController ,
        let newTrivivaQuestion = newTrivia
            else{
                return
        }
        destinationVC.questions.append(newTrivivaQuestion)
        
        destinationVC.resetGame()
        
        
    }
}
