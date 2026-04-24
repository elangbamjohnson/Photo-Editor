import SwiftUI

struct FilterBar: View {
    @ObservedObject var viewModel: EditorViewModel
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(viewModel.filters, id: \.self) { filter in
                    VStack {
                        Text(filter.replacingOccurrences(of: "CI", with: "").replacingOccurrences(of: "PhotoEffect", with: ""))
                            .font(.system(size: 10, weight: .medium))
                            .lineLimit(1)
                            .frame(width: 70)
                        
                        Button(action: {
                            withAnimation {
                                viewModel.applyFilter(filter)
                            }
                        }) {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(viewModel.selectedFilter == filter ? Color.blue : Color.gray.opacity(0.3))
                                .frame(width: 60, height: 60)
                                .overlay(
                                    Image(systemName: "camera.filters")
                                        .foregroundColor(viewModel.selectedFilter == filter ? .white : .primary)
                                )
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
        .padding(.vertical, 8)
        .background(Color(.secondarySystemBackground))
    }
}
