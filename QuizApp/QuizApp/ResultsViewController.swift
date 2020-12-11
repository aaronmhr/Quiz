//
//  ResultsViewController.swift
//  QuizApp
//
//  Created by Aaron Huánuco on 9/12/20.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import UIKit
struct PresentableAnswer {
    let isCorrect: Bool
}

class CorrectAnswerCell: UITableViewCell {

}

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
    }
}

extension ResultsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        answers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        CorrectAnswerCell()
    }
}
