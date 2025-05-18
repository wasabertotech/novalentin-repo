import SwiftUI

struct BioInputView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var bio = ""
    @State private var showNextScreen = false
    @FocusState private var isBioFocused: Bool
    
    private let maxCharacters = 500
    
    private var remainingCharacters: Int {
        maxCharacters - bio.count
    }
    
    private var characterCountColor: Color {
        switch remainingCharacters {
        case ..<0: return .red
        case 0...50: return .orange
        default: return AppColors.textSecondary
        }
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
                    Text("Write Your Bio")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(AppColors.textPrimary)
                    
                    Text("Tell others about yourself")
                        .font(.system(size: 17))
                        .foregroundColor(AppColors.textSecondary)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 20)
                
                // Bio Input
                VStack(spacing: 8) {
                    ZStack(alignment: .topLeading) {
                        if bio.isEmpty {
                            Text("Share your interests, hobbies, or anything that makes you unique!")
                                .font(.system(size: 17))
                                .foregroundColor(AppColors.textSecondary)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 12)
                        }
                        
                        TextEditor(text: $bio)
                            .font(.system(size: 17))
                            .scrollContentBackground(.hidden)
                            .background(Color.clear)
                            .frame(height: 200)
                            .focused($isBioFocused)
                            .onChange(of: bio) { _, newValue in
                                if newValue.count > maxCharacters {
                                    bio = String(newValue.prefix(maxCharacters))
                                }
                            }
                    }
                    .padding(4)
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                    
                    // Character Counter
                    HStack {
                        Spacer()
                        Text("\(remainingCharacters) characters remaining")
                            .font(.system(size: 13))
                            .foregroundColor(characterCountColor)
                    }
                }
                .padding(.horizontal, 20)
                
                // Writing Suggestions
                VStack(spacing: 12) {
                    Text("Some ideas to include:")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(AppColors.textPrimary)
                    
                    ForEach([
                        "🎯 Your interests and hobbies",
                        "🎮 Favorite games or activities",
                        "🌟 What makes you unique",
                        "💭 What you're looking for"
                    ], id: \.self) { suggestion in
                        Text(suggestion)
                            .font(.system(size: 15))
                            .foregroundColor(AppColors.textSecondary)
                    }
                }
                .padding(.top, 20)
                
                Spacer()
                
                // Continue Button
                Button(action: {
                    showNextScreen = true
                }) {
                    Text("Continue")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(AppColors.buttonText)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(!bio.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? AppColors.buttonBackground : AppColors.buttonBackground.opacity(0.6))
                        .cornerRadius(12)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
                .disabled(bio.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
        }
        .onAppear {
            isBioFocused = true
        }
        // TODO: Add navigation to next screen when showNextScreen is true
    }
}

#Preview {
    BioInputView()
} 