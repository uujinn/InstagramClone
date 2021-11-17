//
//  ProfileEditRequest.swift
//  Instagram
//
//  Created by 양유진 on 2021/10/27.
//

import Foundation

struct ProfileEditRequest: Encodable{
    var profilePhotoUrl: String
    var name: String
    var accountName: String
    var bio: String?
}
