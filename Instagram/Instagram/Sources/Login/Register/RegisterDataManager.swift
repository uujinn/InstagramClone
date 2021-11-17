//
//  RegisterDataManager.swift
//  Instagram
//
//  Created by 양유진 on 2021/10/18.
//

import Foundation
import Alamofire

class RegisterDataManager {
    func postRegister(_ parameters: RegisterRequest, delegate: RegisterViewController) {
        AF.request("\(Constant.BASE_URL)/users", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: RegisterResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess { // let result = response.result
                        delegate.didSuccessSignIn()
                        print("성공")
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        case 2000..<3000: delegate.failedToRequest(message: response.message ?? "회원가입에 실패하였습니다.")
                        case 3000..<4000: delegate.failedToRequest(message: response.message ?? "회원가입에 실패하였습니다.")
                        case 4000: delegate.failedToRequest(message: response.message ?? "회원가입에 실패하였습니다.")
                        default: delegate.failedToRequest(message: response.message ?? "회원가입에 실패하였습니다.")
                        }
                    }
                case .failure(let error):
                    print("ERROR: \(error.localizedDescription)")
                    delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
