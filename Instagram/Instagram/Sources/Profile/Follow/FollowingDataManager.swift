//
//  FollowingDataManger.swift
//  Instagram
//
//  Created by 양유진 on 2021/10/25.
//

import Foundation
import Alamofire

class FollowingDataManager {
    func getFollowingList(accountIdx: Int, delegate: FollowingViewController) {
        AF.request("\(Constant.BASE_URL)/accounts/\(accountIdx)/followings", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["x-access-token": "\(Constant.accessToken ?? "jwt")"])
            .validate()
            .responseDecodable(of: FollowingResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess { // let result = response.result

                        delegate.didSuccessSignIn(result: response.result!)
                        print("성공")
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        case 2000..<3000: delegate.failedToRequest(message: response.message)
                        case 3000..<4000: delegate.failedToRequest(message: response.message)
                        case 4000: delegate.failedToRequest(message: response.message)
                        default: delegate.failedToRequest(message: response.message)
                        }
                    }
                case .failure(let error):
                    print("ERROR: \(error.localizedDescription)")
                    delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
