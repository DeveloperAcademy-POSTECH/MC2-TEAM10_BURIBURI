/*
 See the License.txt file for this sample’s licensing information.
 */

import SwiftUI

struct CameraView: View {
    @StateObject private var photomodel = PhotoDataModel()
 
    private static let barHeightFactor = 0.15
    
    
    var body: some View {
        
        NavigationStack {
            GeometryReader { geometry in
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
                            .background(.black.opacity(0.75))
                    }
                    .overlay(alignment: .center)  {
                        Color.clear
                            .frame(height: geometry.size.height * (1 - (Self.barHeightFactor * 2)))
                            .accessibilityElement()
                            .accessibilityLabel("View Finder")
                            .accessibilityAddTraits([.isImage])
                    }
                    .background(.black)
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
                photomodel.camera.takePhoto()
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
                .frame(width: getWidth() * 0.34)
        
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
            }
        }
    }
=======
	@StateObject private var photomodel = PhotoDataModel()
	@EnvironmentObject var dataModel: DataModel
	
	@State var showsDecisionPage: Bool = false // true -> 선택하는 화면 띄움
	@State var returnedTuple: (Data, [CGPoint]) = (Data(), [CGPoint]()) // convertToBackgroundRemovedPNGDataAndPointArray 함수의 반환값
	
	private static let barHeightFactor = 0.15
	
	
	var body: some View {
		
		NavigationStack {
			GeometryReader { geometry in
				ZStack {
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
								.background(.black.opacity(0.75))
						}
						.overlay(alignment: .center)  {
							Color.clear
								.frame(height: geometry.size.height * (1 - (Self.barHeightFactor * 2)))
								.accessibilityElement()
								.accessibilityLabel("View Finder")
								.accessibilityAddTraits([.isImage])
						}
						.background(.black)
				
					
					if showsDecisionPage {
						// 저장할지 undo할지 선택하는 화면
						ZStack {
							Color.black
								.opacity(0.4)
							
							VStack {
								HStack {
									Button {
										returnedTuple = (Data(), [CGPoint]())
										showsDecisionPage = false
									} label: {
										Text("Undo")
									}
									
									Button {
										let pngURL = FileManager.default.savePNGDataByFileManagerAndReturnURL(returnedTuple.0)
										if let pngURL = pngURL {
											let item = Item(url: pngURL, pointArray: returnedTuple.1)
											dataModel.items.append(item)
											dataModel.save()
											for item in dataModel.items {
												print("item.id: \(item.id)")
												print("item.url: \(item.url)")
												print("pointArray: \(item.pointArray)\n")
											}
											showsDecisionPage = false
										}
									} label: {
										Text("Save")
									}
								}
								PNGImageDataView(pngData: returnedTuple.0)
									.frame(width: 200)
							}
							
						}
						
						
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
				.frame(width: getWidth() * 0.39)
			
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
			}
		}
	}
	
	
}


