//
//  PostRequest.swift
//  Instagram
//
//  Created by 양유진 on 2021/10/24.
//

import Foundation

struct PostsRequest: Encodable {
    var accountIdx: Int
    var caption: String?
    var postTagList: [String]?
    var postPhotoList: [String]?
}
