//
//  PohtoListVC.swift
//  PhotoApp
//
//  Created by Yahia El-Dow on 15/05/2022.
//

import UIKit

class PhotoListVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private var viewDelegate: PhotoListViewProtocol?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewDelegate?.getRemoteData()
        self.setupTableView()
    }
    
    func config(delegate: PhotoListViewProtocol) {
        self.viewDelegate = delegate
    }
    
    private func setupTableView() {
        self.tableView.registerCellType(PhotoCell.self)
    }
}

extension PhotoListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewDelegate?.displayedList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.photoViewCell(indexPath: indexPath) {
            return cell
        }
        return UITableViewCell()
    }
    // MARK: init Cell
    private func photoViewCell(indexPath: IndexPath) -> PhotoCell? {
        guard let cell: PhotoCell = self.tableView.dequeueCell(indexPath: indexPath) else { return nil }
        if let model = self.viewDelegate?.displayedList?[safe: indexPath.row],
           let title = model.title,
           let imgUrl = model.thumbnailURL {
            cell.config(title: title, imgUrl: imgUrl)
        }
        return cell
    }
}

extension PhotoListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewDelegate?.tableViewDidSelectItem(indexPath: indexPath)
    }
}

extension PhotoListVC: PhotoListPresenterProtocol {
    func didGetErrorFromServerWithErrorMsg(_ msg: String) {
        self.showToast(message: msg)
    }
    
    /** *Open Screen Details Screen* */
    func didOpenDetailsScreen(photoModel: Photo) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController {
            let detailsPresenter = DetailsPresenter(delegate: vc, photoModel: photoModel)
            vc.config(delegate: detailsPresenter)
            self.present(vc, animated: true)
        }
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}

extension PhotoListVC: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        let rowNumber = viewDelegate?.displayedList?.count ?? 0
        if (rowNumber - 5) == indexPaths.last?.row ?? 0 {
            self.viewDelegate?.loadMore()
        }
    }
}

