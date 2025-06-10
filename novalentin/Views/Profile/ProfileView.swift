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
    @State private var showDeleteConfirmation = false
    @State private var showSignOutConfirmation = false
    
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
                            
                            NavigationLink(destination: ContactView()) {
                                ProfileActionButton(
                                    title: "Contact Us",
                                    icon: "envelope.fill",
                                    showChevron: true
                                )
                            }
                            
                            Divider()
                                .padding(.vertical, 8)
                            
                            // Sign Out Button
                            Button(action: {
                                showSignOutConfirmation = true
                            }) {
                                HStack {
                                    Image(systemName: "rectangle.portrait.and.arrow.right")
                                        .font(.system(size: 20))
                                        .foregroundColor(AppColors.textPrimary)
                                        .frame(width: 30)
                                    
                                    Text("Sign Out")
                                        .font(.system(size: 17))
                                        .foregroundColor(AppColors.textPrimary)
                                    
                                    Spacer()
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(12)
                                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                            }
                            
                            // Delete Account Button
                            Button(action: {
                                showDeleteConfirmation = true
                            }) {
                                HStack {
                                    Image(systemName: "trash.fill")
                                        .font(.system(size: 20))
                                        .foregroundColor(.red)
                                        .frame(width: 30)
                                    
                                    Text("Delete Account")
                                        .font(.system(size: 17))
                                        .foregroundColor(.red)
                                    
                                    Spacer()
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(12)
                                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .alert("Sign Out", isPresented: $showSignOutConfirmation) {
                Button("Cancel", role: .cancel) {}
                Button("Sign Out", role: .destructive) {
                    // Here you would implement the actual sign out logic
                    // For now, we'll just exit to the welcome screen
                    exit(0)
                }
            } message: {
                Text("Are you sure you want to sign out?")
            }
            .alert("Delete Account", isPresented: $showDeleteConfirmation) {
                Button("Cancel", role: .cancel) {}
                Button("Delete", role: .destructive) {
                    // Here you would implement the actual account deletion logic
                    // For now, we'll just exit the app
                    exit(0)
                }
            } message: {
                Text("Are you sure you want to delete your account? This action cannot be undone and all your data will be permanently deleted.")
            }
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