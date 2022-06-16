//
//  PostAccount.swift
//  GongGalBBang
//
//  Created by 김택현 on 2022/06/15.
//

import SwiftUI

class PostAccount: ObservableObject {
//    static let shared = GetRoom()
    @Published var res = AccountResult()
    
    func postAccount(accountReq : AccountRequest) {
        
        let reqUrl = "https://zlo9zqjbhf.execute-api.ap-northeast-2.amazonaws.com/default/Find_LoginData/send"
            
        guard let url = URL(string: reqUrl) else {
            print("Invalid url string: \(reqUrl)")
            return
        }

        var urlRequest = URLRequest(url: url)
        
        var body: [String: Any]
        
        switch accountReq.function_case {
        // 아이디 찾기
        case 0:
            body = ["function_case": accountReq.function_case, "user_name":
                        accountReq.user_name, "phoneNumber": accountReq.phoneNumber!]
        // 비밀번호 변경
        case 1:
            body = ["function_case": accountReq.function_case, "phoneNumber": accountReq.phoneNumber!, "user_name":
                        accountReq.user_name, "user_id": accountReq.user_id!,
                    "change_pw": accountReq.change_pw!]
        default:
            body = [:]
        }
        
        let jsonData = try? JSONSerialization.data(withJSONObject: body)
        
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("\(String(describing: jsonData?.count))", forHTTPHeaderField: "Content-Length")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = jsonData
        
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let decodedData = try JSONDecoder().decode(AccountResponse.self, from: data)
                DispatchQueue.main.async {
                    self.res = decodedData.body
                    print(self.res)
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
    
