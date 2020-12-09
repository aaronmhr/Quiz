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
    @IBOutlet weak var headerLabel: UILabel!

    convenience init(summary: String) {
        self.init()
        self.summary = summary
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        headerLabel.text = summary
    }
}
