import SwiftUI

struct ContactView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.openURL) private var openURL
    
    var body: some View {
        VStack(spacing: 32) {
            // Header Image
            Image(systemName: "envelope.fill")
                .font(.system(size: 60))
                .foregroundColor(AppColors.navarraBlue)
                .padding(.top, 60)
            
            VStack(spacing: 16) {
                Text("Contact Us")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(AppColors.textPrimary)
                
                Text("Please contact us at")
                    .font(.system(size: 17))
                    .foregroundColor(AppColors.textSecondary)
                
                Button(action: {
                    if let url = URL(string: "mailto:info@app.com") {
                        openURL(url)
                    }
                }) {
                    Text("info@app.com")
                        .font(.system(size: 17, weight: .medium))
                        .foregroundColor(AppColors.navarraBlue)
                }
                
                Text("and we will review your inquiry.")
                    .font(.system(size: 17))
                    .foregroundColor(AppColors.textSecondary)
            }
            .multilineTextAlignment(.center)
            .padding(.horizontal, 32)
            
            Spacer()
        }
        .navigationTitle("Contact Us")
        .navigationBarTitleDisplayMode(.inline)
        .background(AppColors.background.ignoresSafeArea())
    }
}

#Preview {
    NavigationView {
        ContactView()
    }
} 