//
//  UIView+Extension.swift.swift
//  RepoList
//
//  Created by Yahia El-Dow on 26/11/2021.
//

import UIKit

extension UIView {
    func setCircle(){
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.width / 2
    }
}
