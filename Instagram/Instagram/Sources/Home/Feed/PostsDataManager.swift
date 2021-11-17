//
//  PostsDataManager.swift
//  Instagram
//
//  Created by 양유진 on 2021/10/22.
//

import Foundation
import Alamofire

class PostDataManger {
    let userIdx = 15
    func getPost(page: Int, delegate: HomeViewController) {
        AF.request("\(Constant.BASE_URL)/accounts/\(Constant.userIdx ?? userIdx)/posts/\(page)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["x-access-token": "\(Constant.accessToken ?? "jwt")"])
            .validate()
            .responseDecodable(of: PostResponse.self) { response in
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
                        case 2000..<3000: delegate.failedToRequest(message: response.message ?? "데이터 불러오기를 실패하였습니다.")
                        case 3000..<4000: delegate.failedToRequest(message: response.message ?? "데이터 불러오기를 실패하였습니다.")
                        case 4000: delegate.failedToRequest(message: response.message ?? "데이터 불러오기를 실패하였습니다.")
                        default: delegate.failedToRequest(message: response.message ?? "데이터 불러오기를 실패하였습니다.")
                        }
                    }
                case .failure(let error):
                    print("ERROR: \(error.localizedDescription)")
                    delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
