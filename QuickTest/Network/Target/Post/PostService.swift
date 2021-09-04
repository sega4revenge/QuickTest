//
//  CalendarService.swift
//  Calendar
//
//  Created by Tô Tử Siêu on 16/08/2021.
//

import Foundation
class PostService {
    func getListPost(completion: @escaping ApiCompletion<[Post]>) {
        let target = PostTarget.getListPost
        let posts = RealmManager.shared.realm.objects(Post.self)
        if Connectivity.shared.isConnectedToInternet() && posts.isEmpty {
            ApiManager.shared.request(target: target, completion: completion)
        } else {
            completion(.success(Array(posts)))
        }
    }
    
    func getListUser(completion: @escaping ApiCompletion<[User]>) {
        let target = PostTarget.getListUser
        let users = RealmManager.shared.realm.objects(User.self)
        if Connectivity.shared.isConnectedToInternet() && users.isEmpty {
            ApiManager.shared.request(target: target, completion: completion)
        } else {
            completion(.success(Array(users)))
        }
    }
    
    func getListComment(completion: @escaping ApiCompletion<[Comment]>) {
        let target = PostTarget.getListComment
        let comments = RealmManager.shared.realm.objects(Comment.self)
        if Connectivity.shared.isConnectedToInternet() && comments.isEmpty {
            ApiManager.shared.request(target: target, completion: completion)
        } else {
            completion(.success(Array(comments)))
        }
    }
}
