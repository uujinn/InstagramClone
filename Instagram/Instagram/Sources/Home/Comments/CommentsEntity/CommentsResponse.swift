//
//  CommentsResponse.swift
//  Instagram
//
//  Created by 양유진 on 2021/10/26.
//

import Foundation

struct CommentsResponse: Decodable{
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: CommentsResult?
}

struct CommentsResult: Decodable{
    var postData: CommentsPostData?
    var tagList: [CommentsTagList]?
    var commentList: [CommentsList]?
}

struct CommentsPostData: Decodable{
    var accountIdx: Int
    var accountName: String
    var profilePhotoUrl: String
    var postIdx: Int
    var caption: String
    var agoTime: String
}

struct CommentsTagList: Decodable{
    var tagIdx: Int?
    var tagName: String?
}

struct CommentsList: Decodable{
    var commentIdx: Int?
    var postIdx: Int?
    var accountIdx: Int?
    var content: String?
    var accountName: String?
    var profilePhotoUrl: String?
    var likeCnt: Int?
    var isLiked: Int?
    var agoTime: String?
}
