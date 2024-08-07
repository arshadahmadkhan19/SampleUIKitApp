//
//  PhotosViewController.swift
//  SampleiOSUIKitApp
//
//  Created by Arshad Khan on 8/6/24.
//

import Combine
import UIKit

protocol PhotosViewControllerDelegate: AnyObject {
    func photoDetails(photo: PhotoModel)
}

class PhotosViewController: UITableViewController {
    
    var photos: [PhotoModel] = []
    var viewModel: PhotosViewModelProtocol
    var cancellable = Set<AnyCancellable>()
    weak var photosViewControllerDelegate: PhotosViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: cellId)
        loadPhotos()
    }
    
    init(viewModel: PhotosViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    let cellId = "cellId"
    private func loadPhotos() {
        viewModel.getPhotos().receive(on: DispatchQueue.main).sink { completion in
            switch completion {
                case .finished:
                    print("finished")
                case .failure(let error):
                    print("error \(error)")
            }
        } receiveValue: { [weak self] photos in
            self?.photos = photos
            self?.tableView.reloadData()
        }.store(in: &cancellable)

    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? PhotosTableViewCell
        cell?.updatePhotoCell(photos[indexPath.row])
        
        return cell ?? UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.photosViewControllerDelegate?.photoDetails(photo: photos[indexPath.row])
    }
}
