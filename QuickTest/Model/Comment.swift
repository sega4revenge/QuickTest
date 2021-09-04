//
//  Comment.swift
//  QuickTest
//
//  Created by Tô Tử Siêu on 04/09/2021.
//

import Foundation
import RealmSwift
class Comment: Object, Codable {
    dynamic var id = RealmProperty<Int?>()
    dynamic var postId = RealmProperty<Int?>()
    @objc dynamic var name: String?
    @objc dynamic var email: String?
    @objc dynamic var body: String?
   
    override static func primaryKey() -> String? {
            return "id"
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case postId
        case email
        case body
    }
}

