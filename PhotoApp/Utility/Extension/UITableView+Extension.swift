//
//  UITableView+Extension.swift
//  RepoList
//
//  Created by Yahia El-Dow on 26/11/2021.
//

import Foundation
import UIKit

extension UITableView {
    func registerCellType<T: UITableViewCell>(_ type: T.Type) {
         register(UINib(nibName: type.nibName, bundle: nil), forCellReuseIdentifier: type.identifier)
     }
     
     func dequeueCell<T: UITableViewCell>(indexPath: IndexPath) -> T? {
         return dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T
     }

}
