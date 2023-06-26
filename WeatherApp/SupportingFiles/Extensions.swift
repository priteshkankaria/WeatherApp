//
//  Extensions.swift
//  WeatherApp
//
//  Created by Pritesh Kankaria on 25/06/23.
//

import UIKit

extension UIImageView {
    func loadImageWith(imageUrlString: String) {
        self.image = nil
        
        //Check if image is available in Cache
        if let cachedImage = cachedImages.object(forKey: imageUrlString as NSString)  {
            self.image = cachedImage
            return
        }

        if let imageUrl = URL(string: imageUrlString) {
            URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
                if let data = data {
                    DispatchQueue.main.async {
                        if let downloadedImage = UIImage(data: data) {
                            cachedImages.setObject(downloadedImage, forKey: imageUrlString as NSString)
                            self.image = downloadedImage
                        }
                    }
                } else {
                    print("Failed to load image data: \(error?.localizedDescription ?? "")")
                }
            }.resume()
        }
    }
}

extension UIViewController {
    func showToast(message: String, duration: TimeInterval = 2.0) {
        let toastView = ToastView(message: message)
        let toastWidth: CGFloat = 150
        let toastHeight: CGFloat = 40
        let toastX = (view.frame.width - toastWidth) / 2
        let toastY = view.frame.height - toastHeight - 50
        toastView.frame = CGRect(x: toastX, y: toastY, width: toastWidth, height: toastHeight)
        
        view.addSubview(toastView)
        
        UIView.animate(withDuration: 0.3, delay: duration, options: .curveEaseOut, animations: {
            toastView.alpha = 0
        }, completion: { _ in
            toastView.removeFromSuperview()
        })
    }
    
    func setGradientBackgroundColor(backgroundColorTop: CGColor, backgroundColorBottom: CGColor) {
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = [backgroundColorTop, backgroundColorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
}

public extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
