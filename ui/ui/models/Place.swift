//
//  Landmark.swift
//  Tutorial-0331
//
//  Created by 김택현 on 2022/04/03.
//

import Foundation
import SwiftUI
import CoreLocation

struct Place: Hashable, Codable {
    var id: Int
    var name: String
    var state: String
    var isFavorite: Bool
    
    private var imageName: String
    var image: Image {
        Image(imageName)
    }
}
