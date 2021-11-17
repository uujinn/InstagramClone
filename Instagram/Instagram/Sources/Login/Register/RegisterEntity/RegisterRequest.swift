//
//  RegisterRequest.swift
//  Instagram
//
//  Created by 양유진 on 2021/10/20.
//

import Foundation

struct RegisterRequest: Encodable {
    var fbAccessToken: String?
    var accountName: String?
    var password: String?
    var name: String?
}
