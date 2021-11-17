//
//  ProfileEditDataManager.swift
//  Instagram
//
//  Created by 양유진 on 2021/10/27.
//

import Foundation
import Alamofire

class ProfileEditDataManager {
    var userIdx = 15
    func postPosts(_ parameters: ProfileEditRequest, delegate: ProfileEditViewController) {
        AF.request("\(Constant.BASE_URL)/accounts/\(Constant.userIdx ?? userIdx)/profiles", method: .patch, parameters: parameters, encoder: JSONParameterEncoder(), headers: ["x-access-token": "\(Constant.accessToken ?? "jwt")"])
            .validate()
            .responseDecodable(of: ProfileEditResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess { // let result = response.result
                        delegate.didSuccessEdit()
                        print("성공")
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        case 2000..<3000: delegate.failedToRequestEdit(message: response.message)
                        case 3000..<4000: delegate.failedToRequestEdit(message: response.message)
                        case 4000: delegate.failedToRequestEdit(message: response.message)
                        default: delegate.failedToRequestEdit(message: response.message)
                        }
                    }
                case .failure(let error):
                    print("ERROR: \(error.localizedDescription)")
                    delegate.failedToRequestEdit(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}

