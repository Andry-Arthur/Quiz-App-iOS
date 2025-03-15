//
//  TriviaViewController.swift
//  Trivia
//
//  Created by Andry Arthur on 3/14/25.
//

import UIKit

class TriviaViewController: UIViewController {
    private var correctAnswers = 0
    private var userAnswers = [Int]()
    private var questions = [Question]()
    private var selectedQuestionIndex = 0
    private var correctAnswerIndex = [Int]() // Track correct answers per question

    @IBOutlet weak var questionNumber: UILabel!
    @IBOutlet weak var questionText: UILabel!
    @IBOutlet weak var ans1: UIButton!
    @IBOutlet weak var ans2: UIButton!
    @IBOutlet weak var ans3: UIButton!
    @IBOutlet weak var ans4: UIButton!

    @IBAction func didPressAns1(_ sender: Any) { checkAnswer(selectedAnswer: 1) }
    @IBAction func didPressAns2(_ sender: Any) { checkAnswer(selectedAnswer: 2) }
    @IBAction func didPressAns3(_ sender: Any) { checkAnswer(selectedAnswer: 3) }
    @IBAction func didPressAns4(_ sender: Any) { checkAnswer(selectedAnswer: 4) }

    private func checkAnswer(selectedAnswer: Int) {
        userAnswers.append(selectedAnswer)
        if selectedAnswer == correctAnswerIndex[selectedQuestionIndex] {
            correctAnswers += 1
        }
        moveToNextQuestion()
    }

    private func moveToNextQuestion() {
        if selectedQuestionIndex >= questions.count - 1 {
            showResults()
        } else {
            selectedQuestionIndex += 1
            configure(with: questions[selectedQuestionIndex])
        }
    }

    private func showResults() {
        let alertController = UIAlertController(
            title: "Quiz Complete!",
            message: "You got \(correctAnswers) out of \(questions.count) questions correct!",
            preferredStyle: .alert
        )

        alertController.addAction(UIAlertAction(
            title: "Play Again",
            style: .default,
            handler: { [weak self] _ in self?.resetQuiz() }
        ))

        alertController.addAction(UIAlertAction(
            title: "See Details",
            style: .default,
            handler: { [weak self] _ in self?.showDetailedResults() }
        ))

        present(alertController, animated: true)
    }

    private func resetQuiz() {
        selectedQuestionIndex = 0
        correctAnswers = 0
        userAnswers = []
        correctAnswerIndex = Array(repeating: 0, count: questions.count)
        configure(with: questions[selectedQuestionIndex])
    }

    private func showDetailedResults() {
        var detailedMessage = "Your score: \(correctAnswers)/\(questions.count)\n\n"
        for i in 0..<userAnswers.count {
            let question = questions[i]
            let userAnswer = userAnswers[i]
            let correctAnswer = question.correctAnswer
            let result = userAnswer == correctAnswerIndex[i] ? "✓" : "✗"
            detailedMessage += "Q\(i + 1): \(result) "

            if userAnswer != correctAnswerIndex[i] {
                detailedMessage += "(Correct: \(correctAnswer))"
            }

            detailedMessage += "\n"
        }

        let detailAlert = UIAlertController(
            title: "Detailed Results",
            message: detailedMessage,
            preferredStyle: .alert
        )

        detailAlert.addAction(UIAlertAction(
            title: "Play Again",
            style: .default,
            handler: { [weak self] _ in self?.resetQuiz() }
        ))

        present(detailAlert, animated: true)
    }

    private func configure(with question: Question) {
        questionNumber.text = "Question: \(selectedQuestionIndex + 1) / \(questions.count)"
        questionText.text = question.questionText

        // Create array of all answers
        var answers = [
            question.ans1,
            question.ans2,
            question.ans3,
            question.ans4
        ]
        
        // Keep track of the correct answer
        let correctAnswer = question.correctAnswer
        
        // Shuffle the answers
        answers.shuffle()
        
        // Set the button texts
        ans1.setTitle(answers[0], for: .normal)
        ans2.setTitle(answers[1], for: .normal)
        ans3.setTitle(answers[2], for: .normal)
        ans4.setTitle(answers[3], for: .normal)
        
        // Find which button now contains the correct answer (1-4)
        for i in 0..<4 {
            if answers[i] == correctAnswer {
                // Store the button number (1-4) that has the correct answer
                correctAnswerIndex[selectedQuestionIndex] = i + 1
                break
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        questionText.numberOfLines = 0
        questionText.lineBreakMode = .byWordWrapping

        questions = createMockData()
        correctAnswerIndex = Array(repeating: 0, count: questions.count)
        configure(with: questions[selectedQuestionIndex])
    }

    private func createMockData() -> [Question] {
        return [
            Question(questionNumber: "1", questionText: "Which element has the chemical symbol 'Au'?",
                     ans1: "Gold", ans2: "Silver", ans3: "Aluminum", ans4: "Copper",
                     correctAnswer: "Gold"),
            
            Question(questionNumber: "2", questionText: "In which year did the Titanic sink?",
                     ans1: "1912", ans2: "1905", ans3: "1920", ans4: "1931",
                     correctAnswer: "1912"),
            
            Question(questionNumber: "3", questionText: "Which country is home to the Great Barrier Reef?",
                     ans1: "Australia", ans2: "Brazil", ans3: "Thailand", ans4: "Mexico",
                     correctAnswer: "Australia"),
            
            Question(questionNumber: "4", questionText: "What programming paradigm does Swift primarily support?",
                     ans1: "Object-Oriented", ans2: "Procedural Only", ans3: "Assembly-based",
                     ans4: "Object-Oriented & Functional",
                     correctAnswer: "Object-Oriented & Functional"),
            
            Question(questionNumber: "5", questionText: "Who painted 'Starry Night'?",
                     ans1: "Claude Monet", ans2: "Pablo Picasso", ans3: "Leonardo da Vinci",
                     ans4: "Vincent van Gogh",
                     correctAnswer: "Vincent van Gogh"),
            
            Question(questionNumber: "6", questionText: "What is the tallest mountain in the world?",
                     ans1: "Mount Everest", ans2: "K2", ans3: "Kilimanjaro", ans4: "Denali",
                     correctAnswer: "Mount Everest"),
            
            Question(questionNumber: "7", questionText: "What does the acronym 'HTTP' stand for?",
                     ans1: "High Tech Transfer Process",
                     ans2: "Hypertext Transfer Protocol",
                     ans3: "Hybrid Text Transmission Portal",
                     ans4: "Host Transfer Token Protocol",
                     correctAnswer: "Hypertext Transfer Protocol"),
            
            Question(questionNumber: "8", questionText: "Which framework in iOS is used for creating user interfaces?",
                     ans1: "CoreData", ans2: "CoreAnimation", ans3: "SpriteKit",
                     ans4: "UIKit & SwiftUI",
                     correctAnswer: "UIKit & SwiftUI"),
            
            Question(questionNumber: "9", questionText: "What is the smallest planet in our solar system?",
                     ans1: "Mars", ans2: "Mercury", ans3: "Pluto", ans4: "Venus",
                     correctAnswer: "Mercury"),
            
            Question(questionNumber: "10", questionText: "Who is considered the founder of Apple Inc.?",
                     ans1: "Bill Gates", ans2: "Mark Zuckerberg",
                     ans3: "Steve Jobs & Steve Wozniak", ans4: "Jeff Bezos",
                     correctAnswer: "Steve Jobs & Steve Wozniak")
        ]
    }
}
