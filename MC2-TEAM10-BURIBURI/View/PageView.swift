//
//  PageView.swift
//  ParOn_Yubin
//
//  Created by Yubin on 2023/05/10.
//

import SwiftUI

struct PageView: View {
    var page: Page
    
    var body: some View {
//        VStack(spacing: 20) {
//            Image("\(page.imageUrl)")
//                .resizable()
//                .scaledToFit()
//                .padding()
//                .cornerRadius(30)
//                .background(.gray.opacity(0))
//                .padding()
//
//            Text(page.description)
//                .font(.system(size: 20))
//                .frame(maxWidth: .infinity)
//                .padding(.horizontal, 20)
            VStack {
                SummonGIF("\(page.imageUrl)")
    //                .resizable()
                    .scaledToFit()
                    .padding()
                    .cornerRadius(30)
    //                .background(.gray.opacity(0))
                    .padding()

                Text(page.description)
                    .font(Font.custom("Helvetica-Bold", size: 20))
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 20)
            }
    }
    
    struct PageView_Previews: PreviewProvider {
        static var previews: some View {
            PageView(page: Page.samplePage)
        }
    }
}
