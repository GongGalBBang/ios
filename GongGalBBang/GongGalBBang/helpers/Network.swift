//
//  Network.swift
//  GongGalBBang
//
//  Created by 김택현 on 2022/06/04.
//

import SwiftUI

class GetRoom: ObservableObject {
    @Published var rooms: [Room] = []
    @Published var roomReq: RoomRequest?
    
    func getUsers() {
        guard let url = URL(string: "https://ntz0w082r7.execute-api.ap-northeast-2.amazonaws.com/test1/send?\(roomReq)") else { fatalError("Missing URL") }

        let urlRequest = URLRequest(url: url)

        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }

            guard let response = response as? HTTPURLResponse else { return }

            if response.statusCode == 200 {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        let decodedUsers = try JSONDecoder().decode([Room].self, from: data)
                        self.rooms = decodedUsers
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }
        dataTask.resume()
    }
}
