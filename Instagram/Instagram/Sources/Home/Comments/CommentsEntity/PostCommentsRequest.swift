//
//  PostCommentsRequest.swift
//  Instagram
//
//  Created by 양유진 on 2021/10/27.
//

import Foundation

struct PostCommentsRequest: Encodable{
    var postIdx: Int
    var accountIdx: Int
    var content: String
}
