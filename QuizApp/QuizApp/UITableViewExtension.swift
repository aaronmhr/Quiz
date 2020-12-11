//
//  UITableViewExtension.swift
//  QuizApp
//
//  Created by Aaron Huánuco on 12/12/20.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import UIKit

extension UITableView {
    func register(_ type: UITableViewCell.Type) {
        let classname = String(describing: type)
        register(UINib(nibName: classname, bundle: nil), forCellReuseIdentifier: classname)
    }

    func dequeue<T>(_ type: T.Type) -> T? {
        let classname = String(describing: type)
        return dequeueReusableCell(withIdentifier: classname) as? T
    }

}
