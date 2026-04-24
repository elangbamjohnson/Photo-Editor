//
//  EditorViewModel.swift
//  Photo Editor
//
//  Created by Johnson on 23/04/26.
//

import SwiftUI
import CoreImage
import PhotosUI
import Combine

class EditorViewModel: ObservableObject {
    @Published var selectedItem: PhotosPickerItem? {
        didSet { Task { await loadImage() } }
    }
    
    @Published var originalImage: UIImage?
    @Published var processedImage: UIImage?
    
    // Adjustments
    @Published var brightness: Float = 0.0
    @Published var contrast: Float = 1.0
    @Published var saturation: Float = 1.0
    
    // Filters
    let filters = ["CISepiaTone", "CIPhotoEffectNoir", "CIPhotoEffectChrome", "CIPhotoEffectFade", "CIPhotoEffectInstant", "CIPhotoEffectProcess", "CIPhotoEffectTonal", "CIPhotoEffectTransfer"]
    @Published var selectedFilter: String?
    
    private let processor = ImageProcessor.shared
    private var ciImage: CIImage?
    
    func loadImage() async {
        guard let data = try? await selectedItem?.loadTransferable(type: Data.self),
              let uiImage = UIImage(data: data) else { return }
        
        await MainActor.run {
            self.originalImage = uiImage
            self.processedImage = uiImage
            self.ciImage = CIImage(image: uiImage)
            resetAdjustments()
        }
    }
    
    func applyAdjustments() {
        guard let ciImage = ciImage else { return }
        
        // Combine filter and adjustments
        var currentCI = ciImage
        if let filterName = selectedFilter {
            if let filtered = CIFilter(name: filterName) {
                filtered.setValue(currentCI, forKey: kCIInputImageKey)
                if let output = filtered.outputImage {
                    currentCI = output
                }
            }
        }
        
        let result = processor.applyAdjustments(
            to: currentCI,
            brightness: brightness,
            contrast: contrast,
            saturation: saturation
        )
        
        DispatchQueue.main.async {
            self.processedImage = result
        }
    }
    
    func applyFilter(_ filterName: String) {
        selectedFilter = filterName
        applyAdjustments()
    }
    
    func resetAdjustments() {
        brightness = 0.0
        contrast = 1.0
        saturation = 1.0
        selectedFilter = nil
        processedImage = originalImage
    }
}
