/*
 See the License.txt file for this sample’s licensing information.
 */

import SwiftUI

struct CameraView: View {
    @StateObject private var photomodel = PhotoDataModel()
    @EnvironmentObject var dataModel: DataModel
    
    @State var showsDecisionPage: Bool = false // true -> 선택하는 화면 띄움
    @State var returnedTuple: (Data, [CGPoint]) = (Data(), [CGPoint]()) // convertToBackgroundRemovedPNGDataAndPointArray 함수의 반환값
    
    // 화면 제어 관련 state 변수
    @State var scanButtonActive = true
    
    private static let barHeightFactor = 0.15
    
    
    var body: some View {
        
        NavigationStack {
            GeometryReader { geometry in
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
                        
                        //                        ZStack {
                        //                            ViewfinderView(image: $photomodel.viewfinderImage)
                        //                            Color.black
                        //                                .opacity(0.4)
                        //                            VStack {
                        //                                Spacer()
                        //                                    .frame(height: getHeight() * 0.1)
                        //                                HStack {
                        //                                    Spacer()
                        //                                        .frame(width: getWidth() * 0.7)
                        //                                    Button(action: {
                        //                                        returnedTuple = (Data(), [CGPoint]())
                        //                                        showsDecisionPage = false
                        //                                    }) {
                        //                                        Text("다시 찍기")
                        //                                            .font(.title3)
                        //                                            .fontWeight(.bold)
                        //                                            .foregroundColor(Color("AccentColor"))
                        //                                    }
                        //                                    .frame(width: getWidth() * 0.3)
                        //                                }
                        //                                .frame(height: getHeight() * 0.1)
                        //                                PNGImageDataView(pngData: returnedTuple.0)
                        //                                    .frame(width: getWidth() * 0.5, height: getHeight() * 0.2)
                        //                                Spacer()
                        //                                    .frame(height: getHeight() * 0.3)
                        //                                Button(action: {
                        //                                    let pngURL = FileManager.default.savePNGDataByFileManagerAndReturnURL(returnedTuple.0)
                        //                                        if let pngURL = pngURL {
                        //                                            let item = Item(url: pngURL, pointArray: returnedTuple.1)
                        //                                            dataModel.items.append(item)
                        //                                            dataModel.save()
                        //                                            showsDecisionPage = false
                        //                                        }
                        //                                }) {
                        //                                    Image(systemName: "checkmark.circle.fill")
                        //                                }
                        ////                                .frame(height: getHeight() * 0.1)
                        //                                .frame(width: 60, height: 60)
                        
                        
                        //                                HStack {
                        //                                    Button(action: {
                        //                                        returnedTuple = (Data(), [CGPoint]())
                        //                                        showsDecisionPage = false
                        //                                    }) {
                        //                                        Text("Undo")
                        //                                            .font(.title3)
                        //                                            .fontWeight(.bold)
                        //                                            .padding()
                        //                                            .background(Color.gray.opacity(0.5))
                        //                                            .cornerRadius(20)
                        //                                    }
                        //
                        //                                    Button(action: {
                        //                                        let pngURL = FileManager.default.savePNGDataByFileManagerAndReturnURL(returnedTuple.0)
                        //                                            if let pngURL = pngURL {
                        //                                                let item = Item(url: pngURL, pointArray: returnedTuple.1)
                        //                                                dataModel.items.append(item)
                        //                                                dataModel.save()
                        //                                                showsDecisionPage = false
                        //                                            }
                        //                                    }) {
                        //                                        Text("Save")
                        //                                            .font(.title3)
                        //                                            .fontWeight(.bold)
                        //                                            .padding()
                        //                                            .background(Color.yellow)
                        //                                            .cornerRadius(20)
                        //                                    }
                        //                                }
                        //                            }
                        //                        }
                        //                    }
                        
                        
                        
//                        if showsDecisionPage {
//                            // 저장할지 undo할지 선택하는 화면
//                            ZStack {
//                                Color.black
//                                    .opacity(0.4)
//
//                                VStack {
//                                    HStack {
//                                        Button {
//                                            returnedTuple = (Data(), [CGPoint]())
//                                            showsDecisionPage = false
//                                            scanButtonActive = true
//                                        } label: {
//                                            Text("Undo")
//                                        }
//
//                                        Button {
//                                            let pngURL = FileManager.default.savePNGDataByFileManagerAndReturnURL(returnedTuple.0)
//                                            if let pngURL = pngURL {
//                                                let item = Item(url: pngURL, pointArray: returnedTuple.1)
//                                                dataModel.items.append(item)
//                                                dataModel.save()
//                                                showsDecisionPage = false
//                                                scanButtonActive = true
//                                            }
//                                        } label: {
//                                            Text("Save")
//                                        }
//                                    }
//                                    PNGImageDataView(pngData: returnedTuple.0)
//                                        .frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 300)
//                                }
//                            }
                        }
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
            }
        .navigationBarHidden(true)
        }
        
        private func buttonsView() -> some View {
            HStack(spacing: 60) {
                
                Spacer()
                
                NavigationLink(destination: AlbumForParentsView()) {
                    Image("C_Fedora3_02")
                        .resizable()
                        .frame(width: 60, height: 60)
                }
                
                Button {
                    if scanButtonActive {
                        scanButtonActive = false
                        photomodel.camera.takePhoto()
                        
                        // takePhoto()하고, camera가 photoOutput()해서 Camera.tempPhotoData에 무언가 채워지는지 scanTimer로 0.05초 간격으로 확인한다.
                        let scanTimer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) {t in
                            // Camera.tempPhotoData가 비어있지 않으면 returnedTuple에 convert함수의 반환값을 저장한다.
                            if !Camera.tempPhotoData.isEmpty {
                                returnedTuple = convertToBackgroundRemovedPNGDataAndPointArray(Camera.tempPhotoData)
                                // Camera.tempPhotoData와 t를 초기화한다.
                                Camera.tempPhotoData = Data()
                                t.invalidate()
                                // 선택 페이지가 보이게 한다.
                                showsDecisionPage = true
                            }
                        }
                    }
                    
                } label: {
                    Label {
                        Text("Take Photo")
                    } icon: {
                        Circle()
                            .foregroundColor(.white)
                            .frame(width: 60, height: 60)
                            .overlay {
                                Circle()
                                    .stroke(Color.black, lineWidth: 2)
                                    .foregroundColor(.white)
                                    .frame(width: 48, height: 48)
                            }
                        //                    Image("Stella_08")
                        //                        .resizable()
                        //                        .frame(width: 90, height: 90)
                    }
                }
                
                
                
                Spacer()
                    .frame(width: getWidth() * 0.3)
                
            }
            .buttonStyle(.plain)
            .labelStyle(.iconOnly)
            .padding()
        }
        
        private func buttonsView2() -> some View {
            HStack {
                Spacer()
                    .frame(width: getWidth() * 0.05)
                NavigationLink(destination: ARView()) {
                    Text("AR")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .padding(.trailing)
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


