import SwiftUI

struct UnderageView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            AppColors.background
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                // Youth Image
                Image(systemName: "heart.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 120)
                    .foregroundColor(AppColors.navarraBlue)
                    .padding(.top, 60)
                
                VStack(spacing: 16) {
                    Text("Enjoy Your Youth!")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(AppColors.textPrimary)
                    
                    Text("We appreciate your interest, but NoValentin is only available for users 18 and older. Take this time to enjoy being young!")
                        .font(.system(size: 17))
                        .foregroundColor(AppColors.textSecondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                }
                
                Spacer()
                
                // Close Button
                Button(action: {
                    // This will close all modal views and return to root
                    dismiss()
                }) {
                    Text("Close App")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(AppColors.buttonText)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(AppColors.buttonBackground)
                        .cornerRadius(12)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 40)
            }
        }
    }
}

#Preview {
    UnderageView()
} 