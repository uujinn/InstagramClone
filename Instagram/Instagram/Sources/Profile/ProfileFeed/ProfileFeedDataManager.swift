//
//  ProfileFeedDataManager.swift
//  Instagram
//
//  Created by 양유진 on 2021/10/25.
//

import Foundation
import Alamofire

class ProfileFeedDataManager {
    let userIdx = 15
    func getProfileFeed(userIndex: Int, delegate: ProfileFeedViewController) {
        AF.request("\(Constant.BASE_URL)/accounts/\(userIndex)/feeds/posts", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["x-access-token": "\(Constant.accessToken ?? "jwt")"])
            .validate()
            .responseDecodable(of: ProfileFeedResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess { // let result = response.result
                        delegate.didSuccessGetProfileFeed(result: response.result!)
                        print("성공")
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        case 2000..<3000: delegate.failedToRequestProfileFeed(message: response.message ?? "데이터 불러오기를 실패하였습니다.")
                        case 3000..<4000: delegate.failedToRequestProfileFeed(message: response.message ?? "데이터 불러오기를 실패하였습니다.")
                        case 4000: delegate.failedToRequestProfileFeed(message: response.message ?? "데이터 불러오기를 실패하였습니다.")
                        default: delegate.failedToRequestProfileFeed(message: response.message ?? "데이터 불러오기를 실패하였습니다.")
                        }
                    }
                case .failure(let error):
                    print("ERROR: \(error.localizedDescription)")
                    delegate.failedToRequestProfileFeed(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
