//
//  OnboardingForParents.swift
//  ParOn_Yubin
//
//  Created by Yubin on 2023/05/10.
//

import SwiftUI

struct OnboardingForParents: View {
    @EnvironmentObject var dataModel: DataModel
    @State private var pageIndex = 0
    private let pages: [Page] = Page.samplePages
    private let dotAppeearance = UIPageControl.appearance()
    private func goToZero() {
        pageIndex = 0
    }
    private func incrementPage() {
        pageIndex += 1
    }
    private func skipToLastPage() {
        pageIndex = pages.count - 1
    }
    
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                ZStack {
                    Image("BG_Light")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geo.size.width, height: geo.size.height)
                        .edgesIgnoringSafeArea(.all)
                    TabView(selection: $pageIndex) {
                        ForEach(pages) { page in
                            ZStack {
                                Rectangle()
                                    .foregroundColor(.white)
                                    .frame(width: 360, height: 630)
                                    .cornerRadius(15)
                                    .padding()
                                VStack {
                                    Spacer()
                                    PageView(page: page)
                                    Spacer()
                                    if page.tag == 2 {
                                        NavigationLink(destination: TutorialCameraView().environmentObject(dataModel)) {
                                            Text("아이 그림 스캔하기")
                                                .font(.title.bold())
                                                .padding()
                                                .frame(maxWidth: .infinity)
                                                .foregroundColor(.white)
                                                .background(Color.indigo)
                                                .cornerRadius(12)
                                                .padding()
                                        }
                                    }
                                }
                            }
                            .tag(page.tag)
                        }
                    }
                    .animation(.easeInOut, value: pageIndex)
                    .tabViewStyle(.page)
                    //        .indexViewStyle(.page(PageIndexViewStyle(backgroundDisplayMode: .interactive)))
                    .onAppear {
                        dotAppeearance.currentPageIndicatorTintColor
                        = .systemPink
                        dotAppeearance.pageIndicatorTintColor = .gray
                    }
                }
                
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}
    
    
    struct OnboardingForParents_Previews: PreviewProvider {
        static var previews: some View {
            OnboardingForParents()
        }
    }
    

