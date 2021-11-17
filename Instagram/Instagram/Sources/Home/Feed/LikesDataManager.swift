//
//  LikesDataManager.swift
//  Instagram
//
//  Created by 양유진 on 2021/10/25.
//

import Foundation
import Alamofire

class LikesDataManager {
    func postLikes(parameters: LikesRequest, delegate: HomeViewController) {
        AF.request("\(Constant.BASE_URL)/posts/likes", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: ["x-access-token": "\(Constant.accessToken ?? "jwt")"])
            .validate()
            .responseDecodable(of: LikesResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess { // let result = response.result
                        delegate.didSuccessLikes()
                        print("alert: \(response.result.alert)")
                        print("성공")
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        case 2000..<3000: delegate.failedToLikes(message: response.message)
                        case 3000..<4000: delegate.failedToLikes(message: response.message)
                        case 4000: delegate.failedToLikes(message: response.message)
                        default: delegate.failedToLikes(message: response.message)
                        }
                    }
                case .failure(let error):
                    print("ERROR: \(error.localizedDescription)")
                    delegate.failedToLikes(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}

