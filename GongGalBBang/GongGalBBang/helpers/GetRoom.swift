//
//  Network.swift
//  GongGalBBang
//
//  Created by 김택현 on 2022/06/04.
//

import SwiftUI

class GetRoom: ObservableObject {
    @Published var res : [RoomResult] = []
    
    func getRooms(roomReq : RoomRequest) {
        let reqUrl = "https://ntz0w082r7.execute-api.ap-northeast-2.amazonaws.com/test1/apiGateway/send"
        
        print(reqUrl)
        
        guard var url = URLComponents(string: reqUrl) else {
            print("Invalid url string: \(reqUrl)")
            return
         }
        
        url.queryItems = [
            URLQueryItem(name: "access_time", value: roomReq.access_time),
            URLQueryItem(name: "club_number", value: roomReq.club_number),
            URLQueryItem(name: "major_number", value: roomReq.major_number)
        ]
        
        var request = URLRequest(url: url.url!)
        
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else{
                return
            }
            do{
                let rooms = try JSONDecoder().decode(RoomResponse.self, from: data)
                DispatchQueue.main.async {
                    self.res = rooms.result
                    print(self.res)
                }
            }
            catch{
                print(error)
            }
        }
        task.resume()
    }
}
