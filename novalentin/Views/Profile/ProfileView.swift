import SwiftUI

struct ProfileView: View {
    @State private var currentUser = UserProfile(
        name: "Alex",
        age: 25,
        city: "Barcelona",
        bio: """
            Photography enthusiast and coffee lover. Always looking for new perspectives and interesting conversations.
            
            Interests:
            • Street photography
            • Coffee brewing
            • Urban exploration
            • Modern art
            
            Let's share stories and create new ones together!
            """,
        images: ["user1", "user2", "user3", "user4"]
    )
    
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
                                Text("\(currentUser.name), \(currentUser.age)")
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundColor(AppColors.textPrimary)
                                
                                Text(currentUser.city)
                                    .font(.system(size: 17))
                                    .foregroundColor(AppColors.textSecondary)
                            }
                        }
                        .padding(.top, 20)
                        
                        // Profile Actions
                        VStack(spacing: 16) {
                            NavigationLink(destination: ProfilePreviewView(profile: currentUser)) {
                                ProfileActionButton(
                                    title: "Preview Profile",
                                    icon: "eye",
                                    showChevron: true
                                )
                            }
                            
                            NavigationLink(destination: Text("Edit Profile")) {
                                ProfileActionButton(
                                    title: "Edit Profile",
                                    icon: "pencil",
                                    showChevron: true
                                )
                            }
                            
                            NavigationLink(destination: Text("Settings")) {
                                ProfileActionButton(
                                    title: "Settings",
                                    icon: "gear",
                                    showChevron: true
                                )
                            }
                            
                            NavigationLink(destination: Text("Help & Support")) {
                                ProfileActionButton(
                                    title: "Help & Support",
                                    icon: "questionmark.circle",
                                    showChevron: true
                                )
                            }
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
    var showChevron: Bool = true
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(AppColors.navarraBlue)
                .frame(width: 30)
            
            Text(title)
                .font(.system(size: 17))
                .foregroundColor(AppColors.textPrimary)
            
            Spacer()
            
            if showChevron {
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(AppColors.textSecondary)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

#Preview {
    ProfileView()
} 