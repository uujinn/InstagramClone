//
//  LoginDataManager.swift
//  Instagram
//
//  Created by 양유진 on 2021/10/19.
//

import Foundation
import Alamofire

class LoginDataManager {
    func postLogin(_ parameters: LoginRequest, delegate: LoginViewController) {
        AF.request("\(Constant.BASE_URL)/login", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: LoginRespone.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess { // let result = response.result
                        let jwtToken = response.result?.jwt
                        let accountIdx = response.result?.accountIdx
                        delegate.didSuccessSignIn(jwtToken!, accountIdx!)
                        print("성공")
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        case 2000..<3000: delegate.failedToRequest(message: response.message ?? "로그인에 실패하였습니다.")
                        case 3000..<4000: delegate.failedToRequest(message: response.message ?? "로그인에 실패하였습니다.")
                        case 4000: delegate.failedToRequest(message: response.message ?? "로그인에 실패하였습니다.")
                        default: delegate.failedToRequest(message: response.message ?? "로그인에 실패하였습니다.")
                        }
                    }
                case .failure(let error):
                    print("ERROR: \(error.localizedDescription)")
                    delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}

