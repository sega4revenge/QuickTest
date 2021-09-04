//
//  Users.swift
//  QuickTest
//
//  Created by Tô Tử Siêu on 04/09/2021.
//

import Foundation
import RealmSwift
class User: Object, Codable {
    dynamic var id = RealmProperty<Int?>()
    @objc dynamic var name: String?
    @objc dynamic var username: String?
    @objc dynamic var email: String?
    @objc dynamic var phone: String?
    @objc dynamic var website: String?
   
    override static func primaryKey() -> String? {
            return "id"
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case username
        case email
        case phone
        case website
    }
}

