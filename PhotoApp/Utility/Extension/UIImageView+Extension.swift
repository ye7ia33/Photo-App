//
//  UIImageView+Extension.swift
//  RepoList
//
//  Created by Yahia El-Dow on 26/11/2021.
//

import UIKit

extension UIImageView {
    
    func downloadImage(from URLString: String) {
        guard let url = URL(string: URLString) else {
            self.setDefaultImage()
            return
        }
        URLSession.shared.dataTask(with: url) {
            
            [weak self] data, response, error in
            guard error == nil else {
                self?.setDefaultImage()
                return
            }
            guard let httpURLResponse = response as? HTTPURLResponse,
                  httpURLResponse.statusCode == 200,
                  let data = data else {
                      self?.setDefaultImage()
                      return
                  }
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self?.image = image
            }
            
        }.resume()
    }
    
    func setDefaultImage() {
        DispatchQueue.main.async {
            self.image = UIImage(named: "default-image")
        }
    }
    
    func enableZoom() {
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(startZooming(_:)))
        isUserInteractionEnabled = true
        addGestureRecognizer(pinchGesture)
    }
    
    @objc
    private func startZooming(_ sender: UIPinchGestureRecognizer) {
        let scaleResult = sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale)
        guard let scale = scaleResult, scale.a > 1, scale.d > 1 else { return }
        sender.view?.transform = scale
        sender.scale = 1
    }
}
