//
//  UITableView+Extension.swift
//  Sample demo
//
//  Created by Srilatha Karancheti on 2022-04-10.
//

import UIKit

extension UITableView {
    func setSeparatorSpaceToZero() {
        let width: CGFloat = 15
        separatorInset = UIEdgeInsets(top: 0, left: -width, bottom: 0, right: 0)
    }
}

