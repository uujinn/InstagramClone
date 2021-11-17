//
//  PostResponse.swift
//  Instagram
//
//  Created by 양유진 on 2021/10/24.
//

import Foundation

struct PostsResponse: Decodable{
    var isSuccess: Bool
    var code: Int
    var message: String?
}

