//
//  DetailViewModel.swift
//  QuickTest
//
//  Created by Tô Tử Siêu on 04/09/2021.
//

import Foundation
import RxCocoa
import RxSwift
class DetailViewModel: BaseViewModel {
    var post: BehaviorRelay<Post>
    var user: BehaviorRelay<User?>
    var comments: BehaviorRelay<[Comment]>
    
    init(post: Post) {
        self.post = BehaviorRelay<Post>(value: post)
        if let postId = post.id.value {
            comments = BehaviorRelay<[Comment]>(value: RealmManager.shared.getComment(postId: postId))
        } else {
            comments = BehaviorRelay<[Comment]>(value: [])
        }
        
        if let userId = post.userId.value {
            user = BehaviorRelay<User?>(value: RealmManager.shared.getUser(userId: userId))
        } else {
            user = BehaviorRelay<User?>(value: nil)
        }
        super.init()
    }
}
