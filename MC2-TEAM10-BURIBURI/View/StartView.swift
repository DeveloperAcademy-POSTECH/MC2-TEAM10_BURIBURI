//
//  ContentView.swift
//  Lift-Off
//
//  Created by Jungsoo Lee on 2023/05/13.
//

import Foundation
import SwiftUI
import UIKit

struct StartView: View {
    
    @EnvironmentObject var dataModel : DataModel
    
    var body: some View {
        ZStack {
            
            
            SummonGIF("Title_01") //화면비 수정해야 함
                .offset(x: 0, y: -10)
                .edgesIgnoringSafeArea(.all)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) { //애니메이션이 있어야 할 듯..
                        UIApplication.shared.windows.first?.rootViewController = UIHostingController(rootView: OnboardingForParents().environmentObject(dataModel))
                    }
                }
            }
        }
    }
    
//    struct ParentsOnBoard: View {
//        var body: some View {
//            Text("ParentsOnBoard")
//        }
    //}
    
    struct StartView_Previews: PreviewProvider {
        static var previews: some View {
            StartView()
        }
    }


//struct ContentView: View {
//    var body: some View {
//
//        //GeometryReader { geo in // 필요한가요..?
//
//            ZStack {
//                SummonGIF("Title_01")
//                //.aspectRatio(contentMode: .fill)
//                //.frame(maxWidth:.infinity, maxHeight:.infinity)
//                    .offset(x: 0,y: -10) //써도 댐..? 대에엄....
//                    .edgesIgnoringSafeArea(.all)
//                // 화면이 절반으로 계속 잘리는 이유..
//
//                //이제 이러고 부모 온보딩 일단 넘어가야 됩니다 지금요 네?
//
//                    .onAppear { DispatchQueue.main.asyncAfter(deadline: .now() + 4)
//                        {UIApplication.shared.windows.first?.rootViewController = UIHostingController(rootView: ParentsOnBoard())}
//                    }
//            }
//            struct ParentsOnBoard: View {
//                var body: some View {
//                    Text("ParentsOnBoard")
//                }
//            }
//        struct ContentView_Previews: PreviewProvider {
//            static var previews: some View {
//                ContentView()
//            }
//        }
//    }
//}
