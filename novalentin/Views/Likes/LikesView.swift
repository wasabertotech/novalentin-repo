import SwiftUI

// Model for received likes
struct ReceivedLike: Identifiable {
    let id = UUID()
    let profile: UserProfile
    let timestamp: Date
}

struct LikesView: View {
    @State private var receivedLikes = [
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
                
                VStack(spacing: 0) {
                    if !receivedLikes.isEmpty {
                        // Header with likes count
                        Text("\(receivedLikes.count) people like you")
                            .font(.system(size: 22, weight: .semibold))
                            .foregroundColor(AppColors.textPrimary)
                            .padding(.top, 8)
                            .padding(.bottom, 10)
                        
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
                        .frame(height: UIScreen.main.bounds.height * 0.65)
                        
                        Spacer()
                        
                        // Action Buttons
                        HStack(spacing: 40) {
                            Button(action: {
                                withAnimation {
                                    handleSwipe(-500)
                                }
                            }) {
                                Image(systemName: "xmark")
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundColor(.white)
                                    .frame(width: 64, height: 64)
                                    .background(Color.red)
                                    .clipShape(Circle())
                                    .shadow(radius: 5)
                            }
                            
                            Button(action: {
                                withAnimation {
                                    handleSwipe(500)
                                }
                            }) {
                                Image(systemName: "heart.fill")
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundColor(.white)
                                    .frame(width: 64, height: 64)
                                    .background(AppColors.navarraBlue)
                                    .clipShape(Circle())
                                    .shadow(radius: 5)
                            }
                        }
                        .padding(.bottom, 30)
                        
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
                    }
                }
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
}

#Preview {
    LikesView()
} 