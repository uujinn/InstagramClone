//
//  LoginRequest.swift
//  Instagram
//
//  Created by 양유진 on 2021/10/18.
//

import Foundation

struct LoginRequest: Encodable {
    var accountName: String?
    var password: String?
}
