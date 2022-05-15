//
//  DetailsPresenterProtocol.swift
//  PhotoApp
//
//  Created by Yahia El-Dow on 15/05/2022.
//

import Foundation

protocol DetailsPresenterProtocol: NSObject {
    func reloadData()
}

protocol DetailsViewProtocol: NSObject {
    func viewDidLoad()
    var photoUrl: String? { get }
    var AlbumId: String? { get }
    var title: String? { get }
}
