//
//  ProfileResponse.swift
//  Instagram
//
//  Created by 양유진 on 2021/10/27.
//

import Foundation

struct ProfileAccountResponse: Decodable{
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: ProfileResult?
}

struct ProfileResult: Decodable{
    var accountIdx: Int
    var profilePhotoUrl: String
    var name: String?
    var accountName: String?
    var bio: String?
}
