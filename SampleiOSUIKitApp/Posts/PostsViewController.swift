//
//  PostsViewController.swift
//  SampleiOSUIKitApp
//
//  Created by Arshad Khan on 8/6/24.
//

import Combine
import UIKit

class PostsViewController: UITableViewController {
    var posts: [PostsModel] = []
    var cancellables = Set<AnyCancellable>()
    let viewModel: PostsViewModelProtocol
    init(viewModel: PostsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPosts()
    }
    
    private func loadPosts() {
        viewModel.getPosts()
            .receive(on: DispatchQueue.main).sink { completion in
                switch completion {
                    
                    case .finished:
                        print("finished")
                    case .failure(_):
                        print("error")
                }
            } receiveValue: { [weak self] posts in
                self?.posts = posts
                self?.tableView.reloadData()
            }.store(in: &cancellables)

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let title = posts[indexPath.row].title
        cell.textLabel?.text = title
        return cell
    }
}
