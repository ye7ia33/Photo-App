//
//  Collection+Extension.swift
//  RepoList
//
//  Created by Yahia El-Dow on 26/11/2021.
//

import Foundation

extension Collection {
    /// Returns the element at the specified index iff it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
