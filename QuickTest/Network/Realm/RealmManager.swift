//
//  RealmManager.swift
//  QuickTest
//
//  Created by Tô Tử Siêu on 04/09/2021.
//

import Foundation
import RealmSwift
class RealmManager {
    static var shared = RealmManager()
    
    var realm: Realm {
        let realm = try! Realm()
        return realm
    }
    
    func write<T>(data: [T]) where T:Decodable, T: Object {
        try! realm.write {
            realm.add(data, update: .all)
        }
    }
    
    func getUser(userId: Int) -> User? {
        return realm.objects(User.self).filter({$0.id.value == userId}).first
    }
    
    func getComment(postId: Int) -> [Comment] {
        return realm.objects(Comment.self).filter({$0.postId.value == postId})
    }
}
