//
//  ProfileResponse.swift
//  Instagram
//
//  Created by 양유진 on 2021/10/20.
//

import Foundation

struct ProfileResponse: Decodable{
    var isSuccess: Bool
    var code:Int
    var message: String?
    var result: Result?
}

struct Result: Decodable{
    var profileData: ProfileData?
    var storyCnt: StoryCnt?
    var feedPreviewList: [FeedPreviewList]?
}

struct ProfileData: Decodable{
    var accountIdx: Int
    var accountName: String
    var name: String?
    var profilePhotoUrl: String?
    var bio: String?
    var postCnt: Int
    var FollowerCnt: Int
    var FollowingCnt: Int
    var isFollowing: Int
}

struct StoryCnt: Decodable{
    var storyCnt: Int?
}

struct FeedPreviewList: Decodable{
    var postIdx: Int
    var url: String?
    var photoCnt: Int
}
