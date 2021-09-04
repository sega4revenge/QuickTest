//
//  PostTableCell.swift
//  QuickTest
//
//  Created by Tô Tử Siêu on 04/09/2021.
//

import UIKit

class PostTableCell: UITableViewCell {
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var postComment: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    func configPost(post: Post) {
        postTitle.text = post.title
        postComment.text = post.body
    }
    
    func configComment(comment: Comment) {
        postTitle.text = comment.email
        postComment.text = comment.body
    }
}
