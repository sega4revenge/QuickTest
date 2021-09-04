//
//  DetailViewController.swift
//  QuickTest
//
//  Created by Tô Tử Siêu on 04/09/2021.
//

import UIKit

class DetailViewController: BaseViewController {
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postOverviewLabel: UILabel!
    @IBOutlet weak var postUserLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    var viewModel: DetailViewModel?
    convenience init(viewModel: DetailViewModel) {
        self.init()
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let viewModel = viewModel else { return }
        configTableView()
        viewModel.post.subscribe(
            onNext: { [unowned self] post in
                postTitleLabel.text = post.title
                postOverviewLabel.text = post.body
            }).disposed(by: dispose)
        
        viewModel.user.subscribe(
            onNext: { [unowned self] user in
                postUserLabel.text = "Posted by: \(user?.name ?? "")"
            }).disposed(by: dispose)
        
        viewModel.comments.subscribe(
            onNext: { [unowned self] user in
                tableView.reloadData()
            }).disposed(by: dispose)
        
    }
    
    deinit {
        tableView.removeObserver(self, forKeyPath: "contentSize")
    }
    
    func configTableView() {
        tableView.register(nibWithCellClass: PostTableCell.self)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0,
                                                     bottom: 0,
                                                     right: 0)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize" {
            if let newvalue = change?[.newKey], let newsize  = newvalue as? CGSize, newsize.height > 0 {
                tableViewHeight.constant = newsize.height
            }
        }
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.comments.value.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: PostTableCell.self, for: indexPath)
        guard let viewModel = viewModel else { return cell }
        let comment = viewModel.comments.value[indexPath.row]
        cell.configComment(comment: comment)
        return cell
    }
}
