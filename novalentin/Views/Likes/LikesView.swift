import SwiftUI

// Model for received likes
struct ReceivedLike: Identifiable {
    let id = UUID()
    let profile: UserProfile
    let timestamp: Date
}

struct LikesView: View {
    @State private var receivedLikes: [ReceivedLike] = [
        // Sample data
        ReceivedLike(
            profile: UserProfile(
                name: "Isabella",
                age: 26,
                city: "Sevilla",
                bio: """
                    Professional dancer and dance instructor. I believe in expressing emotions through movement and finding joy in every step of life.
                    
                    When I'm not in the dance studio, I love:
                    • Exploring local food markets
                    • Practicing yoga
                    • Reading contemporary literature
                    • Learning new dance styles
                    
                    Looking for someone who appreciates art, movement, and isn't afraid to step onto the dance floor!
                    """,
                images: ["isabella1", "isabella2", "isabella3"]
            ),
            timestamp: Date().addingTimeInterval(-3600)
        ),
        ReceivedLike(
            profile: UserProfile(
                name: "Marco",
                age: 29,
                city: "Bilbao",
                bio: """
                    Marine biologist with a passion for ocean conservation. My work involves studying marine ecosystems and working on preservation projects.
                    
                    Life outside the lab:
                    • Scuba diving instructor
                    • Amateur photographer
                    • Environmental activist
                    • Surfing enthusiast
                    
                    Seeking someone who shares my love for the ocean and environmental consciousness.
                    """,
                images: ["marco1", "marco2", "marco3", "marco4"]
            ),
            timestamp: Date().addingTimeInterval(-7200)
        )
    ]
    
    @State private var currentIndex = 0
    @State private var gestureTranslation: CGFloat = 0
    
    var body: some View {
        NavigationView {
            ZStack {
                AppColors.background
                    .ignoresSafeArea()
                
                VStack(spacing: 16) {
                    if !receivedLikes.isEmpty {
                        // Header with likes count
                        Text("\(receivedLikes.count) people like you")
                            .font(.system(size: 22, weight: .semibold))
                            .foregroundColor(AppColors.textPrimary)
                            .padding(.top, 8)
                        
                        // Profile cards stack
                        ZStack {
                            ForEach(receivedLikes.indices.prefix(2).reversed(), id: \.self) { index in
                                ProfileCardView(profile: receivedLikes[index].profile)
                                    .padding(.horizontal)
                                    .offset(x: index == currentIndex ? gestureTranslation : 0)
                                    .rotationEffect(.degrees(index == currentIndex ? Double(gestureTranslation / 20) : 0))
                                    .gesture(
                                        DragGesture()
                                            .onChanged { gesture in
                                                if index == currentIndex {
                                                    gestureTranslation = gesture.translation.width
                                                }
                                            }
                                            .onEnded { gesture in
                                                if index == currentIndex {
                                                    withAnimation {
                                                        handleSwipe(gesture.translation.width)
                                                    }
                                                }
                                            }
                                    )
                            }
                        }
                        .padding(.bottom, 8)
                        
                        // Action Buttons
                        HStack(spacing: 40) {
                            actionButton(systemName: "xmark", color: .red) {
                                handleSwipe(-500)
                            }
                            
                            actionButton(systemName: "heart.fill", color: AppColors.navarraBlue) {
                                handleSwipe(500)
                            }
                        }
                        .padding(.bottom, 24)
                        
                    } else {
                        // No likes view
                        VStack(spacing: 16) {
                            Image(systemName: "heart.slash.fill")
                                .font(.system(size: 40))
                                .foregroundColor(AppColors.navarraBlue)
                            
                            Text("No new likes yet")
                                .font(.system(size: 20))
                                .foregroundColor(AppColors.textSecondary)
                            
                            Text("Keep using the app to get more matches!")
                                .font(.system(size: 16))
                                .foregroundColor(AppColors.textSecondary)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                        }
                        .frame(maxHeight: .infinity)
                        .padding(.bottom, 24)
                    }
                }
                .padding(.top, 8)
            }
            .navigationTitle("Likes")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func handleSwipe(_ translation: CGFloat) {
        let threshold: CGFloat = 150
        
        if abs(translation) > threshold {
            if translation > 0 {
                // Right swipe - Match
                print("Matched with \(receivedLikes[currentIndex].profile.name)")
                // Here you would typically trigger a match notification and update the chat list
            } else {
                // Left swipe - Pass
                print("Passed on \(receivedLikes[currentIndex].profile.name)")
            }
            
            // Remove the current profile from likes
            if currentIndex < receivedLikes.count {
                receivedLikes.remove(at: currentIndex)
            }
        }
        
        gestureTranslation = 0
    }
    
    private func actionButton(systemName: String, color: Color, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(systemName: systemName)
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.white)
                .frame(width: 64, height: 64)
                .background(color)
                .clipShape(Circle())
                .shadow(radius: 5)
        }
    }
}

#Preview {
    LikesView()
} 