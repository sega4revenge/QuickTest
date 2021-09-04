//
//  HomeViewController.swift
//  Calendar
//
//  Created by Tô Tử Siêu on 16/08/2021.
//

import UIKit

class HomeViewController: BaseViewController {

    @IBOutlet weak var tableView: SelfResizeTableView!
    var viewModel = HomeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewIsReady.accept(())
        configTableView()
        
        viewModel.errorMessage .subscribe(
            onNext: { [unowned self] error in
                showAlert(title: "Error", message: error)
            }).disposed(by: dispose)
        
    }
    
    func configTableView() {
        tableView.register(nibWithCellClass: PostTableCell.self)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0,
                                                     bottom: 0,
                                                     right: 0)
        tableView.rowHeight = UITableView.automaticDimension
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.listPost.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: PostTableCell.self, for: indexPath)
        let post = viewModel.listPost.value[indexPath.row]
        cell.configPost(post: post)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = viewModel.listPost.value[indexPath.row]
        let viewModel = DetailViewModel(post: post)
        let vc = DetailViewController(viewModel: viewModel)
        navigationController?.pushViewController(vc)
    }
}
