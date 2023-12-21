/*
 See the License.txt file for this sample’s licensing information.
 */

import SwiftUI

struct CameraView: View {
    @StateObject private var photomodel = PhotoDataModel()
    @EnvironmentObject var dataModel: DataModel
    @EnvironmentObject var heavyViewStatusModel: HeavyViewStatusModel
    
    @Environment(\.dismiss) private var dismiss
    
    @State var showsDecisionPage: Bool = false // true -> 선택하는 화면 띄움
    @State var returnedTuple: (Data, [CGPoint]) = (Data(), [CGPoint]()) // convertToBackgroundRemovedPNGDataAndPointArray 함수의 반환값
    
    // 화면 제어 관련 state 변수
    @State var scanButtonActive = true
    
    private static let barHeightFactor = 0.15
    
    var body: some View {
        
        NavigationStack {
            GeometryReader { geometry in
                if heavyViewStatusModel.cameraViewIsDrawn {
                    ZStack {
                        if !showsDecisionPage {
                            ViewfinderView(image:  $photomodel.viewfinderImage )
                                .overlay(alignment: .top) {
                                    Color.black
                                        .opacity(0)
                                        .frame(height: geometry.size.height * Self.barHeightFactor)
                                }
                                .overlay(alignment: .topLeading) {
                                    buttonsView2()
                                        .frame(height: geometry.size.height * Self.barHeightFactor)
                                        .background(.black.opacity(0))
                                }
                                .overlay(alignment: .bottom) {
                                    buttonsView()
                                        .frame(height: geometry.size.height * Self.barHeightFactor)
                                        .background(.black.opacity(0.2))
                                }
                            
                                .overlay(alignment: .center)  {
                                    Color.clear
                                        .frame(height: geometry.size.height * (1 - (Self.barHeightFactor * 2)))
                                        .accessibilityElement()
                                        .accessibilityLabel("View Finder")
                                        .accessibilityAddTraits([.isImage])
                                }
                                .background(.black)
                        } else {
                            ZStack {
                                ViewfinderView(image: $photomodel.viewfinderImage)
                                    .overlay {
                                        Color.black
                                            .opacity(0.7)
                                    }
                                    .overlay(alignment: .center) {
                                        PNGImageDataView(pngData: returnedTuple.0)
                                            .frame(width: getWidth() * 0.5)
                                    }
                                    .overlay(alignment: .bottom) {
                                        buttonsView3()
                                            .frame(height: geometry.size.height * Self.barHeightFactor)
                                    }
                                    .overlay(alignment: .topTrailing) {
                                        buttonsView4()
                                            .frame(height: geometry.size.height * Self.barHeightFactor)
                                    }
                                
                            }
                        }
                    }
                } else {
                    EmptyView()
                }
            }
            .task {
                await photomodel.camera.start()
                await photomodel.loadPhotos()
                await photomodel.loadThumbnail()
            }
            .navigationTitle("Camera")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
            .ignoresSafeArea()
            .statusBar(hidden: true)
            .onAppear {
                heavyViewStatusModel.resetCameraView()
            }
            .onDisappear {
                heavyViewStatusModel.hideCameraView()
            }
        }
        .navigationBarHidden(true)
    }
    
    private func buttonsView() -> some View {
        HStack(spacing: 0) {
            
            Spacer()
                .frame(width: getWidth() * 0.05)
            
            NavigationLink(destination: AlbumForParentsView()) {
                //                    Image("C_Fedora3_02")
                if let safeURL = dataModel.items.last?.url {
                    PNGImageURLView(pngURL: safeURL)
                        .frame(width: 60, height: 60)
                }}
            .frame(width: getWidth() * 0.15)
            
            Spacer()
                .frame(width: getWidth() * 0.15)
            
            Button {
                if scanButtonActive {
                    scanButtonActive = false
                    photomodel.camera.takePhoto()
                    
                    // takePhoto()하고, camera가 photoOutput()해서 Camera.tempPhotoData에 무언가 채워지는지 scanTimer로 0.05초 간격으로 확인한다.
                    let scanTimer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) {t in
                        // Camera.tempPhotoData가 비어있지 않으면 returnedTuple에 convert함수의 반환값을 저장한다.
                        if !Camera.tempPhotoData.isEmpty {
                            Task(priority: .medium) {
                                returnedTuple = await convertToBackgroundRemovedPNGDataAndPointArray(Camera.tempPhotoData)
                                // Camera.tempPhotoData와 t를 초기화한다.
                                Camera.tempPhotoData = Data()
                                showsDecisionPage = true
                            }
                            t.invalidate()
                            // 선택 페이지가 보이게 한다.
                        }
                    }
                }
                
            } label: {
                Label {
                    Text("Take Photo")
                } icon: {
                    Circle()
                        .foregroundColor(.white)
                        .frame(width: 80, height: 80)
                        .overlay {
                            Circle()
                                .stroke(Color.gray, lineWidth: 2)
                                .foregroundColor(.white)
                                .frame(width: 68, height: 68)
                        }
                    //                    Image("Stella_08")
                    //                        .resizable()
                    //                        .frame(width: 90, height: 90)
                }
            }
            .frame(width: getWidth() * 0.30)
            
            Spacer()
                .frame(width: getWidth() * 0.35)
            
        }
        .buttonStyle(.plain)
        .labelStyle(.iconOnly)
        .padding()
    }
    
    private func buttonsView2() -> some View {
        HStack {
            Spacer()
                .frame(width: getWidth() * 0.05)
            NavigationLink(destination: ARView().environmentObject(heavyViewStatusModel)) {
                HStack {
                    Image(systemName: "chevron.left")
                        .foregroundColor(Color.white)
                    Text("AR")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .padding(.trailing)
                    
                }
            }
        }
    }
    
    private func buttonsView3() -> some View {
        Button(action: {
            let pngURL = FileManager.default.savePNGDataByFileManagerAndReturnURL(returnedTuple.0)
            if let pngURL = pngURL {
                let item = Item(url: pngURL, pointArray: returnedTuple.1)
                dataModel.items.append(item)
                dataModel.save()
            }
            showsDecisionPage = false
            scanButtonActive = true
        }) {
            Image(systemName: "checkmark.circle.fill")
                .resizable()
                .frame(width: 60, height: 60)
                .foregroundColor(Color.white)
        }
    }
    
    private func buttonsView4() -> some View {
        Button(action: {
            returnedTuple = (Data(), [CGPoint]())
            showsDecisionPage = false
            scanButtonActive = true
        }) {
            Text("다시 찍기")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(Color.white)
                .padding(.trailing)
        }
    }
}


