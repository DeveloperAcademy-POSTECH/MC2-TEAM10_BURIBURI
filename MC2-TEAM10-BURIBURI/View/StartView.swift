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
        SummonGIF("Title_01") //화면비 수정해야 함
            .edgesIgnoringSafeArea(.all)
            .frame(height: getHeight() * 1.055)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) { //애니메이션이 있어야 할 듯..
                    UIApplication.shared.windows.first?.rootViewController = UIHostingController(rootView: OnboardingTestView().environmentObject(dataModel))
                }
            }
    }
}

    
    struct StartView_Previews: PreviewProvider {
        static var previews: some View {
            StartView()
        }
    }
