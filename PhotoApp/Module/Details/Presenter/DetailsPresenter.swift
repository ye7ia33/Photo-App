//
//  DetailsPresenter.swift
//  PhotoApp
//
//  Created by Yahia El-Dow on 15/05/2022.
//

import Foundation

final class DetailsPresenter: NSObject {
    private weak var delegate: DetailsPresenterProtocol?
    private var photoModel: Photo?
    
    init(delegate: DetailsPresenterProtocol, photoModel: Photo) {
        self.delegate = delegate
        self.photoModel = photoModel
    }
    
    internal  func viewDidLoad() {
        self.delegate?.reloadData()
    }
    
}

extension DetailsPresenter: DetailsViewProtocol {
    var photoUrl: String? {
        return self.photoModel?.url
    }
    
    var AlbumId: String? {
        guard let id = self.photoModel?.albumID else { return nil}
        return "\(id)"
    }
    
    var title: String? {
        return self.photoModel?.title ?? ""
    }
}
