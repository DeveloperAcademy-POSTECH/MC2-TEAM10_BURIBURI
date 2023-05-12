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
                    .frame(width: 80, height: 80)
            }
            
            Button {
                photomodel.camera.takePhoto()
            } label: {
                Label {
                    Text("Take Photo")
                } icon: {
                    Circle()
                        .foregroundColor(.white)
                        .frame(width: 80, height: 80)
                        .overlay {
                            Circle()
                                .stroke(Color.black, lineWidth: 2)
                                .foregroundColor(.white)
                                .frame(width: 68, height: 68)
                        }
//                    Image("Stella_08")
//                        .resizable()
//                        .frame(width: 90, height: 90)
                }
            }
        
    
            
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
            NavigationLink(destination: ARView()) {
                Image(systemName: "chevron.left")
            }
        }
    }

    
    }
    
