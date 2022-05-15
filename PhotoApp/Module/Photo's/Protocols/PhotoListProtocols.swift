//
//  PhotoListProtocols.swift
//  PhotoApp
//
//  Created by Yahia El-Dow on 15/05/2022.
//

import Foundation
typealias PhotoArrayList = [Photo]

/**
    use  **PhotoListPresenterProtocol**  to impleement presenter methods actions .
*/
protocol PhotoListPresenterProtocol: AnyObject {
    func reloadData()
    func didOpenDetailsScreen(repoModel: Photo)
    func didGetErrorFromServerWithErrorMsg(_ msg: String)
}

/**
    use  **PhotoListViewProtocol**  to impleement View methods actions and variable .
*/
protocol PhotoListViewProtocol: NSObject {
    func getRemoteData()
    var displayedList: PhotoArrayList? { get }
    func tableViewDidSelectItem(indexPath: IndexPath)
    func loadMore()
}
