//
//  StoryResponse.swift
//  Instagram
//
//  Created by 양유진 on 2021/10/22.
//

import Foundation

struct StoryReponse: Decodable{
    var isSuccess: Bool
    var code: Int
    var message: String?
    var result: StoryResult
}

struct StoryResult: Decodable{
    var myStory: MyStory?
    var elseStory: [elseStory]?
}

struct MyStory: Decodable{
    var accountIdx: Int
    var accountName: String?
    var profilePhotoUrl: String?
    var storyList: [StoryList]?
}


struct elseStory: Decodable{
    var accountIdx: Int
    var accountName: String?
    var profilePhotoUrl: String?
    var storyList: [StoryList]?
}

struct StoryList: Decodable{
    var storyIdx: Int
    var isViewd: Int
}

