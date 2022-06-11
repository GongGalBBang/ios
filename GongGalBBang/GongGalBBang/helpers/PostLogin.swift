//
//  Network.swift
//  GongGalBBang
//
//  Created by 김택현 on 2022/06/04.
//

import SwiftUI

class PostLogin: ObservableObject {
//    static let shared = GetRoom()
    @Published var res = LoginResult()
    
    func postUser(loginReq : LoginRequest) {
        
        let reqUrl = "https://4mer5886ri.execute-api.ap-northeast-2.amazonaws.com/default/Check_UserData/send"
            
        guard let url = URL(string: reqUrl) else {
            print("Invalid url string: \(reqUrl)")
            return
        }

        var urlRequest = URLRequest(url: url)
        
        let body: [String: Any] = ["user_id": loginReq.user_id, "user_pw":
                                    loginReq.user_pw]
        
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
                let decodedData = try JSONDecoder().decode(LoginResponse.self, from: data)
                DispatchQueue.main.async {
                    self.res = decodedData.body
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
