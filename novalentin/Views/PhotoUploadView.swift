import SwiftUI
import PhotosUI

struct PhotoUploadView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var selectedItems: [PhotosPickerItem] = []
    @State private var loadedPhotos: [PhotoItem] = []
    @State private var showBioInput = false
    @State private var isLoading = false
    
    private let maxPhotos = 4
    private let gridColumns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    
    var body: some View {
        ZStack {
            AppColors.background
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                // Header
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(AppColors.textPrimary)
                    }
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                VStack(spacing: 16) {
                    Text("Add Your Photos")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(AppColors.textPrimary)
                    
                    Text("Add at least 1 photo to continue")
                        .font(.system(size: 17))
                        .foregroundColor(AppColors.textSecondary)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 20)
                
                ScrollView {
                    // Photo Grid
                    LazyVGrid(columns: gridColumns, spacing: 12) {
                        // Existing Photos
                        ForEach(loadedPhotos) { photo in
                            PhotoCell(photo: photo) {
                                if let index = loadedPhotos.firstIndex(where: { $0.id == photo.id }) {
                                    loadedPhotos.remove(at: index)
                                }
                            }
                        }
                        
                        // Add Photo Button
                        if loadedPhotos.count < maxPhotos {
                            PhotosPicker(selection: $selectedItems,
                                       maxSelectionCount: maxPhotos - loadedPhotos.count,
                                       matching: .images) {
                                AddPhotoCell()
                                    .aspectRatio(1, contentMode: .fill)
                            }
                        }
                        
                        // Empty Cells
                        ForEach(0..<max(0, maxPhotos - loadedPhotos.count - 1), id: \.self) { _ in
                            EmptyPhotoCell()
                                .aspectRatio(1, contentMode: .fill)
                        }
                    }
                    .padding(.horizontal, 20)
                    .animation(.easeInOut, value: loadedPhotos.count)
                }
                .onChange(of: selectedItems) { _, newItems in
                    Task {
                        isLoading = true
                        var newPhotos: [PhotoItem] = []
                        
                        for item in newItems {
                            if let data = try? await item.loadTransferable(type: Data.self),
                               let uiImage = UIImage(data: data) {
                                let photo = PhotoItem(image: Image(uiImage: uiImage))
                                newPhotos.append(photo)
                            }
                        }
                        
                        await MainActor.run {
                            loadedPhotos.append(contentsOf: newPhotos)
                            selectedItems.removeAll()
                            isLoading = false
                        }
                    }
                }
                
                Spacer()
                
                // Photo count indicator
                HStack {
                    Image(systemName: "photo.fill")
                        .foregroundColor(AppColors.textSecondary)
                    Text("\(loadedPhotos.count)/\(maxPhotos) photos added")
                        .font(.system(size: 15))
                        .foregroundColor(AppColors.textSecondary)
                }
                .padding(.bottom, 10)
                
                // Continue Button
                Button(action: {
                    showBioInput = true
                }) {
                    if isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    } else {
                        Text("Continue")
                            .font(.system(size: 17, weight: .semibold))
                    }
                }
                .foregroundColor(AppColors.buttonText)
                .frame(maxWidth: .infinity)
                .padding()
                .background(!loadedPhotos.isEmpty && !isLoading ? AppColors.buttonBackground : AppColors.buttonBackground.opacity(0.6))
                .cornerRadius(12)
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
                .disabled(loadedPhotos.isEmpty || isLoading)
            }
        }
        .fullScreenCover(isPresented: $showBioInput) {
            BioInputView()
        }
    }
}

// Photo Item to handle loaded images
struct PhotoItem: Identifiable {
    let id = UUID()
    let image: Image
}

// Photo Cell with Delete Button
struct PhotoCell: View {
    let photo: PhotoItem
    let onDelete: () -> Void
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            photo.image
                .resizable()
                .aspectRatio(1, contentMode: .fill)
                .frame(maxWidth: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            
            Button(action: onDelete) {
                Image(systemName: "xmark.circle.fill")
                    .font(.system(size: 22))
                    .foregroundColor(.white)
                    .background(Circle().fill(Color.black.opacity(0.5)))
            }
            .padding(8)
        }
    }
}

// Add Photo Cell
struct AddPhotoCell: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .stroke(AppColors.navarraBlue.opacity(0.3), style: StrokeStyle(lineWidth: 2, dash: [5]))
                .background(Color.white.cornerRadius(12))
            
            VStack(spacing: 8) {
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 32))
                    .foregroundColor(AppColors.navarraBlue)
                Text("Add Photo")
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(AppColors.navarraBlue)
            }
        }
    }
}

// Empty Photo Cell
struct EmptyPhotoCell: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .stroke(Color.clear)
            .background(Color.white.opacity(0.5).cornerRadius(12))
    }
}

#Preview {
    PhotoUploadView()
} 