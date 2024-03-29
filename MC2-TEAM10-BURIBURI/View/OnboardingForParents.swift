//
//  OnboardingForParents.swift
//  ParOn_Yubin
//
//  Created by Yubin on 2023/05/10.
//

import SwiftUI

struct OnboardingForParents: View {
    
    @State private var isActive = false
    @EnvironmentObject private var arViewDrawingModel: ARViewDrawingModel
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    Rectangle()
                        .foregroundColor(.white)
                        .ignoresSafeArea(.all)
                    TabView {
                        // 첫번째 GIF
                        VStack {
                            Spacer()
                                .frame(height: geometry.size.height * 0.03)
                            Rectangle()
                                .foregroundColor(.white)
                                .frame(width: geometry.size.width * 0.95, height: geometry.size.height * 0.7)
                                .cornerRadius(20)
                                .overlay {
                                    VStack {
                                        Spacer()
                                            .frame(height: geometry.size.height * 0.05)
                                        SummonGIF("Parents_Doodle_05")
                                        Text("가급적 흰 종이에 어두운 펜을 사용해주세요.\r종이와 펜의 명도 차이가 크지 않으면 인식이\r어려울 수 있어요.")
                                            .font(.body)
                                            .fontWeight(.regular)
                                        Spacer()
                                            .frame(height: geometry.size.height * 0.05)
                                    }
                                }
                            Spacer()
                                .frame(height: geometry.size.height * 0.02)
                            NavigationLink(destination: TutorialCameraView().environmentObject(arViewDrawingModel)) {
                                Rectangle()
                                    .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.06)
                                    .cornerRadius(20)
                                    .foregroundColor(.clear)
                                    .overlay {
                                        Image("BG_Album_01")
                                            .resizable()
                                            .opacity(0.8)
                                            .cornerRadius(20)
                                    }
                                    .overlay {
                                        Text("스캔하러 가기")
                                            .font(.headline)
                                            .fontWeight(.bold)
                                            .foregroundColor(Color.black)
                                    }
                            }
                            Spacer()
                                .frame(height: geometry.size.height * 0.03)
                        }
                            .tag(0)
                        
                        // 두번째 GIF
                        VStack {
                            Spacer()
                                .frame(height: geometry.size.height * 0.03)
                            Rectangle()
                                .foregroundColor(.white)
                                .frame(width: geometry.size.width * 0.95, height: geometry.size.height * 0.7)
                                .cornerRadius(20)
                                .overlay {
                                    VStack {
                                        Spacer()
                                            .frame(height: geometry.size.height * 0.05)
                                        SummonGIF("Parents_Scanning_04_ns")
                                        Text("스캔할 때는 화면에 그림이 꽉 차게 찍어주세요.")
                                            .font(.body)
                                            .fontWeight(.regular)
                                            .multilineTextAlignment(.center)
                                        Spacer()
                                            .frame(height: geometry.size.height * 0.05)
                                    }
                                }
                            Spacer()
                                .frame(height: geometry.size.height * 0.02)
                            NavigationLink(destination: TutorialCameraView().environmentObject(arViewDrawingModel)) {
                                Rectangle()
                                    .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.06)
                                    .cornerRadius(20)
                                    .foregroundColor(.clear)
                                    .overlay {
                                        Image("BG_Album_01")
                                            .resizable()
                                            .opacity(0.8)
                                            .cornerRadius(20)
                                    }
                                    .overlay {
                                        Text("스캔하러 가기")
                                            .font(.headline)
                                            .fontWeight(.bold)
                                            .foregroundColor(Color.black)
                                    }
                            }
                            Spacer()
                                .frame(height: geometry.size.height * 0.03)
                        }
                            .tag(1)
                        
                        // 세번째 GIF
                        VStack {
                            Spacer()
                                .frame(height: geometry.size.height * 0.03)
                            Rectangle()
                                .foregroundColor(.white)
                                .frame(width: geometry.size.width * 0.95, height: geometry.size.height * 0.7)
                                .cornerRadius(20)
                                .overlay {
                                    VStack {
                                        Spacer()
                                            .frame(height: geometry.size.height * 0.05)
                                        SummonGIF("Parents_OnBoarding_03")
                                        Text("아이에게 넓은 공간에서\rAR을 사용하도록 이끌어주세요.")
                                            .font(.body)
                                            .fontWeight(.regular)
                                            .multilineTextAlignment(.center)
                                        Spacer()
                                            .frame(height: geometry.size.height * 0.05)
                                    }
                                }
                            Spacer()
                                .frame(height: geometry.size.height * 0.02)
                            NavigationLink(destination: TutorialCameraView().environmentObject(arViewDrawingModel) ) {
                                Rectangle()
                                    .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.06)
                                    .cornerRadius(20)
                                    .foregroundColor(.clear)
                                    .overlay {
                                        Image("BG_Album_01")
                                            .resizable()
                                            .opacity(0.8)
                                            .cornerRadius(20)
                                    }
                                    .overlay {
                                        Text("스캔하러 가기")
                                            .font(.headline)
                                            .fontWeight(.bold)
                                            .foregroundColor(Color.black)
                                    }
                            }
                            Spacer()
                                .frame(height: geometry.size.height * 0.03)
                        }
                        .tag(2)
                    }
                    .tabViewStyle(PageTabViewStyle())
                    .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                }
            }
            .ignoresSafeArea(.all)
        }
    }
}

struct OnboardingForParents_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingForParents()
    }
}



