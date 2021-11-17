//
//  PostResponse.swift
//  Instagram
//
//  Created by 양유진 on 2021/10/22.
//

import Foundation

struct PostResponse: Decodable{
    var isSuccess: Bool
    var code:Int
    var message: String?
    var result: [PostResult]?
}

struct PostResult: Decodable{
    var postList: PostList?
    var postPhotoUrlListObj: PostPhotoUrlListObj?
    var postTagList: PostTagList?
    var commentPreview: CommentPreview?
}

struct PostList: Decodable{
    var accountIdx: Int
    var accountName: String
    var profilePhotoUrl: String
    var postIdx: Int
    var caption: String?
    var agoTime: String?
    var isPostLiked: Int
    var postLikeTotal: Int
    var commentTotal: Int
}

struct PostPhotoUrlListObj: Decodable{
    var postIdx: Int
    var urlList: [UrlList]?
}

struct UrlList: Decodable{
    var url: String?
}

struct PostTagList: Decodable{
    var postIdx: Int?
    var tagList: [TagList]?
}

struct TagList: Decodable{
    var tagIdx: Int?
    var tagName: String?
}

struct CommentPreview: Decodable{
    var postIdx: Int?
    var commentList: [CommentList]?
}

struct CommentList: Decodable{
    var commentIdx: Int?
    var accountIdx: Int?
    var content: String?
    var accountName: String?
    var profilePhotoUrl: String?
    var isLiked: Int?
    var RN: Int?
}
