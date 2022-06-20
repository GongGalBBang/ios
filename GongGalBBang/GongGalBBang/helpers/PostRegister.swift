//
//  Network.swift
//  GongGalBBang
//
//  Created by 김택현 on 2022/06/04.
//

import SwiftUI

class PostRegister: ObservableObject {
//    static let shared = GetRoom()
    @Published var res = RegisterResult()
    
    func postRegister(registerReq : RegisterRequest) {
        
        let reqUrl = "https://ug3s7fe01l.execute-api.ap-northeast-2.amazonaws.com/default/send_UserData_to_RDS/save"
            
        guard let url = URL(string: reqUrl) else {
            print("Invalid url string: \(reqUrl)")
            return
        }

        var urlRequest = URLRequest(url: url)
        
        let body: [String: Any] = ["name" : registerReq.name,
                                   "user_id" : registerReq.user.user_id,
                                   "user_pw" : registerReq.user.user_pw,
                                   "department" : registerReq.department,
                                   "circle" : registerReq.circle,
                                   "phoneNumber": registerReq.phoneNumber]
        
        print(body)
        
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
                let decodedData = try JSONDecoder().decode(RegisterResponse.self, from: data)
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
