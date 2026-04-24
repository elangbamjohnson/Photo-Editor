//
//  ContentView.swift
//  Photo Editor
//
//  Created by Johnson on 23/04/26.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    @StateObject private var viewModel = EditorViewModel()
    @State private var showingControls = false
    @State private var selectedMode: EditMode = .adjust
    
    enum EditMode {
        case adjust, filter
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                if let image = viewModel.processedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding()
                } else {
                    ContentUnavailableView("No Photo Selected", systemImage: "photo.on.rectangle", description: Text("Select a photo from your library to start editing."))
                }
                
                if viewModel.originalImage != nil {
                    VStack {
                        if showingControls {
                            if selectedMode == .adjust {
                                AdjustmentSliders(viewModel: viewModel)
                                    .transition(.move(edge: .bottom))
                            } else {
                                FilterBar(viewModel: viewModel)
                                    .transition(.move(edge: .bottom))
                            }
                            
                            Picker("Mode", selection: $selectedMode) {
                                Text("Adjust").tag(EditMode.adjust)
                                Text("Filter").tag(EditMode.filter)
                            }
                            .pickerStyle(.segmented)
                            .padding()
                        }
                        
                        HStack {
                            Button(action: {
                                withAnimation { showingControls.toggle() }
                            }) {
                                Label(showingControls ? "Hide Tools" : "Show Tools", systemImage: "wand.and.rays")
                            }
                            .padding()
                            
                            Spacer()
                            
                            PhotosPicker(selection: $viewModel.selectedItem, matching: .images) {
                                Label("Change Photo", systemImage: "photo")
                            }
                            .padding()
                        }
                    }
                    .background(Color(.systemBackground).shadow(radius: 2))
                } else {
                    PhotosPicker(selection: $viewModel.selectedItem, matching: .images) {
                        Label("Select Photo", systemImage: "plus.circle.fill")
                            .font(.headline)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.bottom, 40)
                }
            }
            .navigationTitle("Photo Editor")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if let image = viewModel.processedImage {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                        } label: {
                            Text("Save")
                        }
                    }
                    
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Reset") {
                            withAnimation { viewModel.resetAdjustments() }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
