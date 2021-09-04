//
//  CalendarTarget.swift
//  Calendar
//
//  Created by Tô Tử Siêu on 16/08/2021.
//

import Foundation
import Alamofire

enum PostTarget {
    case getListPost
    case getListUser
    case getListComment
}

extension PostTarget: Target {
    var storeLocal: Bool {
        return true
    }
    
    var path: String {
        switch self {
        case .getListPost: return ApiPath.apiDomain / "posts"
        case .getListUser: return ApiPath.apiDomain / "users"
        case .getListComment: return ApiPath.apiDomain / "comments"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getListPost: return .get
        case .getListUser: return .get
        case .getListComment: return .get
        }
    }

    var params: Parameters? {
        switch self {
        case .getListPost: return nil
        case .getListUser: return nil
        case .getListComment: return nil
        }
    }

    var headers: HTTPHeaders {
        return ApiManager.shared.defaultHTTPHeaders
    }
}
