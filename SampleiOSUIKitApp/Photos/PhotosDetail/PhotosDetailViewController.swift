//
//  PhotosDetailViewController.swift
//  SampleiOSUIKitApp
//
//  Created by Arshad Khan on 8/7/24.
//

import UIKit

class PhotosDetailViewController: UIViewController {
    let photo: PhotoModel
    let photoDetailsView = PhotosDetailView()
    init(photo: PhotoModel) {
        self.photo = photo
        super.init(nibName: nil, bundle: nil)
        view = photoDetailsView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
