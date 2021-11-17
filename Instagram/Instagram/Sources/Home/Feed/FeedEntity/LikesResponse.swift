//
//  LikeResponse.swift
//  Instagram
//
//  Created by 양유진 on 2021/10/25.
//

import Foundation

struct LikesResponse: Decodable{
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: LikeResult
}

struct LikeResult: Decodable{
    var alert: String
    var isPostLiked: Int
}

