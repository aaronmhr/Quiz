//
//  ResultsViewController.swift
//  QuizApp
//
//  Created by Aaron Huánuco on 9/12/20.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    private var summary = ""
    private var answers = [PresentableAnswer]()
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    convenience init(summary: String, answers: [PresentableAnswer]) {
        self.init()
        self.summary = summary
        self.answers = answers
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        headerLabel.text = summary
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(CorrectAnswerCell.self)
        tableView.register(WrongAnswerCell.self)
    }
}

extension ResultsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        answers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let answer = answers[indexPath.row]
        guard let _ = answer.wrongAnswer else {
            return correctAnswerCell(for: answer)
        }
        return wrongAnswerCell(for: answer)
    }

    private func correctAnswerCell(for answer: PresentableAnswer) -> UITableViewCell {
        let cell = tableView.dequeue(CorrectAnswerCell.self)!
        cell.questionLabel.text = answer.question
        cell.answerLabel.text = answer.answer
        return cell
    }

    private func wrongAnswerCell(for answer: PresentableAnswer) -> UITableViewCell {
        let cell = tableView.dequeue(WrongAnswerCell.self)!
        cell.questionLabel.text = answer.question
        cell.correctAnswerLabel.text = answer.answer
        cell.wrongAnswerLabel.text = answer.wrongAnswer
        return cell
    }
}

extension ResultsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        answers[indexPath.row].wrongAnswer == nil ? 70 : 90
    }
}
