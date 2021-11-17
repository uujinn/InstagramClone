//
//  RegisterResponse.swift
//  Instagram
//
//  Created by 양유진 on 2021/10/18.
//

import Foundation

struct RegisterResponse: Decodable{
    var isSuccess: Bool
    var code: Int
    var message: String?
}
