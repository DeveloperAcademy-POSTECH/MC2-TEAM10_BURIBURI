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
			SummonGIF("Title_00") //화면비 수정해야 함
				.edgesIgnoringSafeArea(.all)
				.frame(height: getHeight() * 1.075)
				.onAppear {
					DispatchQueue.main.asyncAfter(deadline: .now() + 5) { //애니메이션이 있어야 할 듯..
						UIApplication.shared.windows.first?.rootViewController = UIHostingController(rootView: OnboardingForParents().environmentObject(dataModel))
					}
				}
		}
			
    }
}

    
    struct StartView_Previews: PreviewProvider {
        static var previews: some View {
            StartView()
        }
    }
