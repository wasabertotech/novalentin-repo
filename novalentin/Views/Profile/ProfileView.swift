import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationView {
            ZStack {
                AppColors.background
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        // Profile Header
                        VStack(spacing: 16) {
                            Circle()
                                .fill(AppColors.navarraBlue.opacity(0.2))
                                .frame(width: 120, height: 120)
                                .overlay(
                                    Image(systemName: "person.fill")
                                        .foregroundColor(AppColors.navarraBlue)
                                        .font(.system(size: 48))
                                )
                            
                            VStack(spacing: 4) {
                                Text("Your Name, 25")
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundColor(AppColors.textPrimary)
                                
                                Text("Your Bio Preview...")
                                    .font(.system(size: 17))
                                    .foregroundColor(AppColors.textSecondary)
                            }
                        }
                        .padding(.top, 20)
                        
                        // Profile Actions
                        VStack(spacing: 16) {
                            ProfileActionButton(title: "Edit Profile", icon: "pencil")
                            ProfileActionButton(title: "Settings", icon: "gear")
                            ProfileActionButton(title: "Help & Support", icon: "questionmark.circle")
                        }
                        .padding(.horizontal, 20)
                    }
                }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ProfileActionButton: View {
    let title: String
    let icon: String
    
    var body: some View {
        Button(action: {}) {
            HStack {
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(AppColors.navarraBlue)
                    .frame(width: 30)
                
                Text(title)
                    .font(.system(size: 17))
                    .foregroundColor(AppColors.textPrimary)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(AppColors.textSecondary)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
        }
    }
}

#Preview {
    ProfileView()
} 