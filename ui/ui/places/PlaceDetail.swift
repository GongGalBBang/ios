//
//  LandmarkDetail.swift
//  Landmark
//
//  Created by 김택현 on 2022/04/07.
//

import SwiftUI

// 그래프 그리기
struct Confuse {
    let score: Double
}

private func getHistoricalConfuse() -> [Confuse] {
    
    var confuses = [Confuse]()
    
    for i in 1...20 {
        let confuse = Confuse(score: (Double)(i))
        confuses.append(confuse)
        
    }
    
    return confuses
}

private func getLabels() -> [String] {
    return (2015...2021).map { String($0) }
}

struct LineChartView: View {
    
    let values: [Int]
    let labels: [String]
    
    let screenWidth = UIScreen.main.bounds.width
    
    private var path: Path {
        
        if values.isEmpty {
            return Path()
        }
        
        var offsetX: Int = Int(screenWidth/CGFloat(values.count))
        var path = Path()
        path.move(to: CGPoint(x: offsetX, y: values[0]))
        
        for value in values {
            offsetX += Int(screenWidth/CGFloat(values.count))
            path.addLine(to: CGPoint(x: offsetX, y: value))
        }
        return path
    }
    var body: some View {
        VStack {
            path.stroke(Color.black, lineWidth: 2.0)
               .rotationEffect(.degrees(180), anchor: .center)
               .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
               .frame(maxWidth: .infinity, maxHeight: 300)


            HStack {
                ForEach(labels, id: \.self) { label in
                   Text(label)
                       .frame(width: screenWidth/CGFloat(labels.count) - 10)
                   
                }
            }
        }
    }
}

struct PlaceDetail: View {
    @EnvironmentObject var modelData: ModelData
    @Environment(\.presentationMode) var presentationMode
    var place: Place
    
    var placeIndex: Int {
        modelData.places.firstIndex(where: {$0.id == place.id})!
    }
    
    let scores = getHistoricalConfuse().map { Int($0.score) }
        let labels = getLabels()
    
    var body: some View {
        NavigationView {
            ScrollView() {
                VStack{
                    Image("GongGalBBang").resizable().frame(width: 200, height: 200)
                    HStack {
                        Text(place.name)
                            .font(.body)
                        FavoriteButton(isSet: $modelData.places[placeIndex].isFavorite)
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                    Text("예상 혼잡도: \(place.state)")
                    Text("분석 혼잡도: \(place.state)")
                    Divider()
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                    
                    Text("시간대 별 인원 추이")
                        .fontWeight(.bold)
                        .frame(alignment: .leading)
                    VStack {
                        Text("그래프")
                            .font(.body)
                        LineChartView(values: scores, labels: labels)
                    }.frame(width: .infinity, height: 250)
                    .foregroundColor(.black)
                    Spacer()
                }
            }
            .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(place.name)
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    },label: {Image(systemName: "xmark")
                        .foregroundColor(.black)
                    })
                }
            })
        }
//        ScrollView{
//            MapView(coordinate: place.locationCoordinate)
//                .ignoresSafeArea(edges:.top)
//                .frame(height:300)
//            CircleImage(image: landmark.image)
//                .offset(y:-130)
//                .padding(.bottom, -130)
//            VStack(alignment: .leading) {
//                Text(landmark.name)
//                    .font(.title)
//                HStack{
//                    Text(landmark.park)
//                        .font(.subheadline)
//                    Spacer()
//                    Text(landmark.state)
//                        .font(.subheadline)
//                }
//                .font(.subheadline)
//                .foregroundColor(.secondary)
//                Divider()
//                Text("About \(landmark.name)")
//                    .font(.title2)
//                Text(landmark.description)
//            }
//            .padding()
//            .navigationTitle(landmark.name)
//            .navigationBarTitleDisplayMode(.inline)
//        }
    }
}

struct LandmarkDetail_Previews: PreviewProvider {
    static let modelData = ModelData()
    static var previews: some View {
        PlaceDetail(place: ModelData().places[0])
            .environmentObject(modelData)
    }
}
