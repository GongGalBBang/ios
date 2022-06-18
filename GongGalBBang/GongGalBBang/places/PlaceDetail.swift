//
//  LandmarkDetail.swift
//  Landmark
//
//  Created by 김택현 on 2022/04/07.
//

import SwiftUI
import Foundation

// 그래프 그리기
struct LineChartView: View {
    
    let date: [Datee]
    
    let screenWidth = UIScreen.main.bounds.width
    
    private var path: Path {
        
        if date.isEmpty {
            return Path()
        }
        
        var offsetX: Double = Double(screenWidth/(CGFloat(date.count) + 5))
        var path = Path()
        path.move(to: CGPoint(x: offsetX, y: date[0].member*20))
        
        for value in date {
            if(value.date != "10") {
                offsetX += Double(screenWidth/(CGFloat(date.count) + 0.5))
                path.addLine(to: CGPoint(x: offsetX, y: value.member*20))
            }
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
                ForEach(date, id: \.self) { label in
                    Text(label.date)
                       .frame(width: screenWidth/(CGFloat(date.count) + 5))
                   
                }
            }
        }
    }
}



struct PlaceDetail: View {
    @EnvironmentObject var getRoom: GetRoom
    @Environment(\.presentationMode) var presentationMode
    var room: RoomResult
    @State var star : Bool
    
    var roomIndex: Int {
        getRoom.res.firstIndex(where: {$0.className == room.className})!
    }
    
    
    var body: some View {
        let name = getRoomName(room:room)
        
        NavigationView {
            VStack{
                Divider()
                    .padding(.top, 71)
                Image(name).resizable().frame(width: 200, height: 200)
                HStack {
                    Text(name)
                        .font(.body)
                    FavoriteButton(name: .constant(name), isSet: $star)
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                
                let hour = getHour()
                let confuse = getConfuse(date: room.data, time: hour)
                               
                HStack {
                    Text("현재 \(hour)시 혼잡도: ")
                    Text(confuse).foregroundColor(getConfuseColor(confuse: confuse))
                }
                
                Divider()
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                
                Text("시간대 별 인원 추이")
                    .fontWeight(.bold)
                    .frame(alignment: .leading)
                VStack {
                    Text("그래프")
                        .font(.body)
                    LineChartView(date: room.data)
                }.frame(width: .infinity, height: 250)
                .foregroundColor(.black)
                Spacer()
            }
            .onAppear{
                star = UserDefaults.standard.bool(forKey: name)
            }
            .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
            .edgesIgnoringSafeArea(.all)
            .navigationTitle(name)
            .navigationBarTitleDisplayMode(.inline)
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
    }
}

struct LandmarkDetail_Previews: PreviewProvider {
    static var previews: some View {
        PlaceDetail(room: RoomResult(className: 101, data: [Datee(date: "10", member: 3), Datee(date: "11", member: 4), Datee(date: "12", member: 3), Datee(date: "13", member: 6), Datee(date: "14", member: 8), Datee(date: "15", member: 10)]), star: false)
    }
}
