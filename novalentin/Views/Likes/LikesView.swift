import SwiftUI

struct LikesView: View {
    var body: some View {
        NavigationView {
            ZStack {
                AppColors.background
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    // Grid of likes will go here
                    Text("People who like you")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(AppColors.textPrimary)
                }
            }
            .navigationTitle("Likes")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    LikesView()
} 