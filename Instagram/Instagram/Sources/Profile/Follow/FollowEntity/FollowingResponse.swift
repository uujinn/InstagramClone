//
//  FollowingEntity.swift
//  Instagram
//
//  Created by 양유진 on 2021/10/24.
//

import Foundation

struct FollowingResponse: Decodable{
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: [FollowingResult]?
}

struct FollowingResult: Decodable{
    var accountIdx: Int
    var accountName: String
    var profilePhotoUrl: String
}
