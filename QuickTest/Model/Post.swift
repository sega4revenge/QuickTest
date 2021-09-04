//
//  Workout.swift
//  Calendar
//
//  Created by Tô Tử Siêu on 16/08/2021.
//

import Foundation
import RealmSwift
class Post: Object, Codable {
    dynamic var userId = RealmProperty<Int?>()
    dynamic var id = RealmProperty<Int?>()
    @objc dynamic var title: String?
    @objc dynamic var body: String?
   
    override static func primaryKey() -> String? {
            return "id"
    }
    
    enum CodingKeys: String, CodingKey {
        case userId
        case id
        case title
        case body
    }
}

