//
//  CommentsLikeResponse.swift
//  Instagram
//
//  Created by 양유진 on 2021/10/28.
//

import Foundation

struct CommentsLikeResponse: Decodable{
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: CommentLikeResult?
}

struct CommentLikeResult: Decodable{
    var alert: String?
    var status: Int
}
