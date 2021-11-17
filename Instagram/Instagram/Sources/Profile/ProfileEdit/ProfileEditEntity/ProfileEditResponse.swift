//
//  ProfileEditResponse.swift
//  Instagram
//
//  Created by 양유진 on 2021/10/27.
//

import Foundation

struct ProfileEditResponse: Decodable{
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: ProfileEditResult?
}

struct ProfileEditResult: Decodable{
    var accountIdx: Int
    var profilePhotoUrl: String
    var name: String
    var accountName: String
    var bio: String?
}
