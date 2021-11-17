////
////  SearchAccountDataManager.swift
////  Instagram
////
////  Created by 양유진 on 2021/10/27.
////
//
//import Foundation
//
//import Alamofire
//
//class SearchAccountDataManager {
//    let userIdx = 15
//
//    func getSearchAccount(keyword: String, delegate: TableViewController) {
//        AF.request("\(Constant.BASE_URL)/searches?keyword=\(keyword)", method: .get, parameters: nil, encoding: URLEncoding.queryString, headers: ["x-access-token": "\(Constant.accessToken ?? "jwt")"])
//            .validate()
//            .responseDecodable(of: SearchAccountResponse.self) { response in
//                switch response.result {
//                case .success(let response):
//                    // 성공했을 때
//                    if response.isSuccess { // let result = response.result
//                        delegate.didSuccessSearchAccount(result: response.result ?? [])
//                        print("성공")
//                    }
//                    // 실패했을 때
//                    else {
//                        switch response.code {
//                        case 2000..<3000: delegate.failedToRequestSearchAccount(message: response.message )
//                        case 3000..<4000: delegate.failedToRequestSearchAccount(message: response.message )
//                        case 4000: delegate.failedToRequestSearchAccount(message: response.message )
//                        default: delegate.failedToRequestSearchAccount(message: response.message )
//                        }
//                    }
//                case .failure(let error):
//                    print("ERROR: \(error.localizedDescription)")
//                    delegate.failedToRequestSearchAccount(message: "서버와의 연결이 원활하지 않습니다")
//                }
//            }
//    }
//}
