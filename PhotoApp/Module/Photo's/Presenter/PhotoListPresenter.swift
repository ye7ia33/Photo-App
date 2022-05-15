//
//  PhotoListPresenter.swift
//  PhotoApp
//
//  Created by Yahia El-Dow on 15/05/2022.
//

import UIKit

final class PhotoListPresenter: NSObject, PhotoListViewProtocol {
    private  weak var delegate: PhotoListPresenterProtocol?
    internal var displayedList: PhotoArrayList?
    private var mainList: PhotoArrayList?
    
    /** important init RepoListPresenter with PhotoListPresenterProtocol  */
    init(delegate: PhotoListPresenterProtocol) {
        self.delegate = delegate
        self.displayedList = PhotoArrayList()
    }
    
    func getRemoteData() {
        PhotoService(delegate: self).getRemoteData()
    }
    
    //MARK: call tableViewDidSelectItem method after user touch on cell to open details screen.
    internal func tableViewDidSelectItem(indexPath: IndexPath) {
        guard let repo = self.displayedList?[safe: indexPath.row] else { return }
        self.delegate?.didOpenDetailsScreen(photoModel: repo)
    }
    
    internal func loadMore() {
         self.appendData()
     }
    
    private func appendData() {
        if self.mainList?.count == 0 { return }
        let listSize = self.mainList?.count ?? 0
        for idx in 0...listSize {
            if idx >= 10 && (self.displayedList?.count ?? 0) > 10 { break }
            if let repoModel = self.mainList?[safe: idx] {
                self.displayedList?.append(repoModel)
                self.mainList?.remove(at: idx)
            } else { break }
        }
        self.delegate?.reloadData()
    }

}

extension PhotoListPresenter: NetworkDelegate {
    
    func didFeatchData(result: Any) {
        guard let photoList = result as? PhotoArrayList else { return }
        self.mainList = photoList
        self.appendData()
    }
    
    func errorResponse(withErrorMessage: String?) {
        if let msg = withErrorMessage{
            self.delegate?.didGetErrorFromServerWithErrorMsg(msg)
        }
        self.delegate?.reloadData()
    }
}
