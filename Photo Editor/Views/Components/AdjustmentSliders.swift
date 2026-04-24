import SwiftUI

struct AdjustmentSliders: View {
    @State var viewModel: EditorViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            adjustmentRow(label: "Brightness", value: $viewModel.brightness, range: -0.5...0.5)
            adjustmentRow(label: "Contrast", value: $viewModel.contrast, range: 0.5...1.5)
            adjustmentRow(label: "Saturation", value: $viewModel.saturation, range: 0...2.0)
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
    }
    
    private func adjustmentRow(label: String, value: Binding<Float>, range: ClosedRange<Float>) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text(label)
                    .font(.caption)
                Spacer()
                Text(String(format: "%.2f", value.wrappedValue))
                    .font(.caption.monospacedDigit())
            }
            Slider(value: value, in: range) { _ in
                viewModel.applyAdjustments()
            }
        }
    }
}
