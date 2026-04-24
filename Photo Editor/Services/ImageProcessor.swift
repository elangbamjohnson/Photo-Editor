import CoreImage
import CoreImage.CIFilterBuiltins
import UIKit

class ImageProcessor {
    static let shared = ImageProcessor()
    private let context = CIContext()
    
    private init() {}
    
    func applyAdjustments(to inputImage: CIImage, brightness: Float, contrast: Float, saturation: Float) -> UIImage? {
        let filter = CIFilter.colorControls()
        filter.inputImage = inputImage
        filter.brightness = brightness
        filter.contrast = contrast
        filter.saturation = saturation
        
        guard let outputImage = filter.outputImage,
              let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else {
            return nil
        }
        
        return UIImage(cgImage: cgImage)
    }
    
    func applyFilter(to inputImage: CIImage, filterName: String) -> UIImage? {
        guard let filter = CIFilter(name: filterName) else { return nil }
        filter.setValue(inputImage, forKey: kCIInputImageKey)
        
        guard let outputImage = filter.outputImage,
              let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else {
            return nil
        }
        
        return UIImage(cgImage: cgImage)
    }
}
