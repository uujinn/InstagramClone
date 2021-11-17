//
//  Constant.swift
//  Instagram
//
//  Created by 양유진 on 2021/10/18.
//

import Foundation

class Constant {
    static var accessToken: String? = UserDefaults.standard.string(forKey: "AccessToken") {
        didSet {
            // UserDefault에 저장
            guard let token = accessToken else { return }
            print("TOKEN: \(token)")
            UserDefaults.standard.setValue(token, forKey: "AccessToken")
        }
    }
    
    static var userIdx: Int? = UserDefaults.standard.integer(forKey: "userIdx") {
        didSet {
            // UserDefault에 저장
            guard let idx = userIdx else { return }
            print("idx: \(idx)")
            UserDefaults.standard.setValue(idx, forKey: "userIdx")
        }
    }
    
    static var userProfileImg: String? = UserDefaults.standard.string(forKey: "userProfileImg") {
        didSet {
            // UserDefault에 저장
            guard let img = userProfileImg else { return }
            print("TOKEN: \(img)")
            UserDefaults.standard.setValue(img, forKey: "userProfileImg")
        }
    }
    
    static let BASE_URL = "http://ssac-ivy.shop/app"
    static let KOBIS_BASE_URL = "http://www.kobis.or.kr/kobisopenapi/webservice/rest"
}
