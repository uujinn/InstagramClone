//
//  PostCommentsDataManger.swift
//  Instagram
//
//  Created by 양유진 on 2021/10/27.
//

import Foundation
import Alamofire

class PostCommentsDataManager {
    func postComments(_ parameters: PostCommentsRequest, delegate: CommentsViewController) {
        AF.request("\(Constant.BASE_URL)/comments", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: ["x-access-token": "\(Constant.accessToken ?? "jwt")"])
            .validate()
            .responseDecodable(of: PostCommentsResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess { // let result = response.result
                        delegate.postsCommentsdidSuccess()
                        print("성공")
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        case 2000..<3000: delegate.postsCommentsfailedToRequest(message: response.message )
                        case 3000..<4000: delegate.postsCommentsfailedToRequest(message: response.message )
                        case 4000: delegate.postsCommentsfailedToRequest(message: response.message )
                        default: delegate.postsCommentsfailedToRequest(message: response.message )
                        }
                    }
                case .failure(let error):
                    print("ERROR: \(error.localizedDescription)")
                    delegate.postsCommentsfailedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}

