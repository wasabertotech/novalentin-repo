import SwiftUI

struct ProfilePreviewView: View {
    let profile: UserProfile
    @Environment(\.dismiss) private var dismiss
    @State private var currentPhotoIndex = 0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Photos carousel
                ZStack(alignment: .bottom) {
                    // Main photo view
                    TabView(selection: $currentPhotoIndex) {
                        ForEach(0..<profile.images.count, id: \.self) { index in
                            ZStack {
                                Rectangle()
                                    .fill(AppColors.navarraBlue.opacity(0.2))
                                
                                // Placeholder image (replace with actual images later)
                                Image(systemName: "person.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(AppColors.navarraBlue)
                                    .frame(width: 150)
                            }
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .frame(height: 450)
                    
                    // Photo indicators
                    HStack(spacing: 8) {
                        ForEach(0..<profile.images.count, id: \.self) { index in
                            Circle()
                                .fill(index == currentPhotoIndex ? Color.white : Color.white.opacity(0.5))
                                .frame(width: 8, height: 8)
                        }
                    }
                    .padding(.bottom, 16)
                }
                
                VStack(alignment: .leading, spacing: 16) {
                    // Name and age
                    HStack {
                        Text("\(profile.name), \(profile.age)")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(AppColors.textPrimary)
                        
                        Text("•")
                            .foregroundColor(AppColors.textSecondary)
                        
                        Text(profile.city)
                            .font(.system(size: 20))
                            .foregroundColor(AppColors.textSecondary)
                    }
                    .padding(.top, 16)
                    
                    // Bio
                    Text(profile.bio)
                        .font(.system(size: 16))
                        .foregroundColor(AppColors.textSecondary)
                        .lineSpacing(4)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            }
        }
        .navigationTitle("Profile Preview")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { dismiss() }) {
                    Text("Done")
                        .foregroundColor(AppColors.navarraBlue)
                }
            }
        }
    }
}

#Preview {
    NavigationView {
        ProfilePreviewView(profile: UserProfile(
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
        ))
    }
} 