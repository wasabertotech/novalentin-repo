import SwiftUI

struct NameInputView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var name = ""
    @State private var showPhotoUpload = false
    
    private var remainingCharacters: Int {
        20 - name.count
    }
    
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
                    Text("What's your name?")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(AppColors.textPrimary)
                    
                    Text("This is how you'll appear on NoValentin")
                        .font(.system(size: 17))
                        .foregroundColor(AppColors.textSecondary)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 20)
                
                // Name Input
                VStack(spacing: 8) {
                    TextField("Enter your name", text: $name)
                        .font(.system(size: 17))
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                        .onChange(of: name) { _, newValue in
                            if newValue.count > 20 {
                                name = String(newValue.prefix(20))
                            }
                        }
                    
                    HStack {
                        Text("\(remainingCharacters) characters remaining")
                            .font(.system(size: 13))
                            .foregroundColor(AppColors.textSecondary)
                        Spacer()
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                Spacer()
                
                // Continue Button
                Button(action: {
                    showPhotoUpload = true
                }) {
                    Text("Continue")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(AppColors.buttonText)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? AppColors.buttonBackground.opacity(0.6) : AppColors.buttonBackground)
                        .cornerRadius(12)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
                .disabled(name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
        }
        .fullScreenCover(isPresented: $showPhotoUpload) {
            PhotoUploadView()
        }
    }
}

#Preview {
    NameInputView()
} 