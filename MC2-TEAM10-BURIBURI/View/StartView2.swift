//
//  StartView2.swift
//  MC2-TEAM10-BURIBURI
//
//  Created by xnoag on 2023/05/17.
//

import Foundation
import SwiftUI
import UIKit

struct StartView2: View {
    
    @EnvironmentObject var dataModel : DataModel
    @EnvironmentObject private var arViewDrawingModel: ARViewDrawingModel
    
    var body: some View {
        SummonGIF("Title_00") //화면비 수정해야 함
            .edgesIgnoringSafeArea(.all)
            .frame(height: getHeight() * 1.075)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    
                    //애니메이션이 있어야 할 듯..
                    UIApplication.shared.windows.first?.rootViewController = UIHostingController(rootView: ARView().environmentObject(dataModel).environmentObject(arViewDrawingModel))
                }
            }
    }
}

    
    struct StartView2_Previews: PreviewProvider {
        static var previews: some View {
            StartView2()
        }
    }
