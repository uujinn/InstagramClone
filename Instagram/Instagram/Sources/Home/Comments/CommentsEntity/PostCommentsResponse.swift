//
//  PostCommentsResponse.swift
//  Instagram
//
//  Created by 양유진 on 2021/10/27.
//

import Foundation

struct PostCommentsResponse: Decodable{
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: String
}
