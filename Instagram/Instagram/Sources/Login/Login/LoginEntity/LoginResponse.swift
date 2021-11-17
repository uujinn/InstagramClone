//
//  LoginResponse.swift
//  Instagram
//
//  Created by 양유진 on 2021/10/18.
//

import Foundation

struct LoginRespone: Decodable{
    var isSuccess: Bool
    var code: Int
    var message: String?
    var result: results?
}

struct results: Decodable{
    var userIdx: Int
    var accountIdx: Int
    var jwt: String?
}
