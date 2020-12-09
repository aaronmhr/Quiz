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
    private var answers = [String]()
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    convenience init(summary: String, answers: [String]) {
        self.init()
        self.summary = summary
//        self.answers = answers
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        headerLabel.text = summary
    }
}
