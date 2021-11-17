//
//  SearchAccountResponse.swift
//  Instagram
//
//  Created by 양유진 on 2021/10/27.
//

import Foundation

struct SearchAccountResponse: Decodable{
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: [SearchAccountResult]?
}

struct SearchAccountResult: Decodable{
    var accountIdx: Int?
    var accountName: String?
    var name: String?
    var profilePhotoUrl: String?
}

