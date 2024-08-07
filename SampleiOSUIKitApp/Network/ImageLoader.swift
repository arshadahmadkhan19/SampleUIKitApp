//
//  ImageLoader.swift
//  SampleiOSUIKitApp
//
//  Created by Arshad Khan on 8/7/24.
//

import UIKit

protocol ImageLoaderProtocol {
    func getImage(from urlString: String, completion: @escaping(UIImage) -> ())
}

class ImageLoader: ImageLoaderProtocol {
    let imageCache = NSCache<NSString, UIImage>()
    func getImage(from urlString: String, completion: @escaping(UIImage) -> ()) {
        guard let url = URL(string: urlString) else { return completion(UIImage()) }
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            completion(imageFromCache)
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                return
            }
            let imageToCache = UIImage(data: data!)
            if let image = imageToCache {
                self.imageCache.setObject(image, forKey: urlString as NSString)
                completion(image)
            }
        }.resume()
    }
}
