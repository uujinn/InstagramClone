//
//  ProfileFeedEntity.swift
//  Instagram
//
//  Created by 양유진 on 2021/10/25.
//

import Foundation

struct ProfileFeedResponse: Decodable{
    var isSuccess: Bool
    var code:Int
    var message: String?
    var result: [ProfileFeedResult]?
}

struct ProfileFeedResult: Decodable{
    var postList: ProfileFeedPostList?
    var postPhotoUrlListObj: ProfileFeedPostPhotoUrlListObj?
    var postTagList: ProfileFeedPostTagList?
    var commentPreview: ProfileFeedCommentPreview?
}

struct ProfileFeedPostList: Decodable{
    var accountIdx: Int
    var accountName: String
    var profilePhotoUrl: String
    var postIdx: Int
    var caption: String?
    var agoTime: String?
    var isPostLiked: Int?
    var postLikeTotal: Int?
    var commentTotal: Int?
}

struct ProfileFeedPostPhotoUrlListObj: Decodable{
    var postIdx: Int?
    var urlList: [ProfileFeedUrlList]?
}

struct ProfileFeedUrlList: Decodable{
    var url: String?
}

struct ProfileFeedPostTagList: Decodable{
    var postIdx: Int?
    var tagList: [ProfileFeedTagList]?
}

struct ProfileFeedTagList: Decodable{
    var tagIdx: Int?
    var tagName: String?
}

struct ProfileFeedCommentPreview: Decodable{
    var postIdx: Int?
    var commentList: [ProfileFeedCommentList]?
}

struct ProfileFeedCommentList: Decodable{
    var commentIdx: Int?
    var accountIdx: Int?
    var content: String?
    var updatedAt: String?
    var accountName: String?
    var profilePhotoUrl: String?
    var isLiked: Int?
    var RN: Int?
}

