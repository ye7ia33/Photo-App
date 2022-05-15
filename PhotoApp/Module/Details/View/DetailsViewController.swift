//
//  DetailsViewController.swift
//  PhotoApp
//
//  Created by Yahia El-Dow on 15/05/2022.
//

import UIKit

final class DetailsViewController: UIViewController {
    private var viewDelegate: DetailsViewProtocol?
    @IBOutlet private weak var PhotoImageView: UIImageView! {
        didSet {
            PhotoImageView.enableZoom()
        }
    }
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var albumIdLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewDelegate?.viewDidLoad()
    }
    
    func config(delegate: DetailsViewProtocol) {
        self.viewDelegate = delegate
    }
    
    @IBAction func dismissMe(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension DetailsViewController: DetailsPresenterProtocol {
    func reloadData() {
        self.bindData()
    }
    
    func bindData() {
        if let url = self.viewDelegate?.photoUrl {
            self.PhotoImageView.downloadImage(from: url)
        }
        self.titleLabel.text = self.viewDelegate?.title
        self.albumIdLabel.text = self.viewDelegate?.AlbumId
    }
}

