import SwiftUI

// Model for user profiles
struct UserProfile: Identifiable {
    let id = UUID()
    let name: String
    let age: Int
    let city: String
    let bio: String
    let images: [String] // URLs or image names
}

// Sample data
extension UserProfile {
    static let sampleProfiles = [
        UserProfile(
            name: "Emma",
            age: 25,
            city: "Barcelona",
            bio: """
                Creative soul with a passion for art and music. Love spending weekends exploring new cafes and art galleries. Always up for interesting conversations and new adventures.

                I'm a professional photographer who sees beauty in everyday moments. My camera is my third eye, capturing life's little details that others might miss.

                When I'm not behind the lens, you'll find me:
                • Trying out new recipes in my tiny but cozy kitchen
                • Attending local art exhibitions and music festivals
                • Planning my next travel adventure
                • Learning to play the guitar (still a beginner!)

                Looking for someone who appreciates art, isn't afraid to be silly, and wants to create beautiful memories together.
                """,
            images: ["emma1", "emma2", "emma3", "emma4"]
        ),
        UserProfile(
            name: "Oliver",
            age: 28,
            city: "Madrid",
            bio: """
                Architect by day, amateur chef by night. Believer in good design, great food, and genuine connections. Looking for someone to share city adventures and cozy evenings.

                My work involves creating spaces that bring people together, and that's exactly what I'm looking for in a relationship. I believe in building strong foundations, both in architecture and relationships.

                A few things about me:
                • Love exploring urban architecture and hidden city gems
                • Passionate about sustainable design and eco-friendly living
                • Weekend hobby: Converting my balcony into an urban garden
                • Always excited to try cooking new cuisines

                Seeking someone who appreciates good design, enjoys thoughtful conversations, and wouldn't mind being my taste-tester for new recipes.
                """,
            images: ["oliver1", "oliver2", "oliver3", "oliver4"]
        ),
        UserProfile(
            name: "Sophia",
            age: 24,
            city: "Valencia",
            bio: """
                Literature student and book lover. Passionate about storytelling and photography. Seeking someone who enjoys deep conversations and spontaneous trips to the beach.

                Currently working on my thesis about modern Spanish literature while moonlighting as a creative writing teacher. I believe every person has a unique story to tell.

                Things that make me happy:
                • Early morning walks along the beach with a good book
                • Writing poetry in small cafes
                • Photography, especially capturing candid moments
                • Teaching creative writing to kids
                • Impromptu road trips to nearby towns

                Looking for someone who values intellectual connections and isn't afraid to discuss both light and deep topics.
                """,
            images: ["sophia1", "sophia2", "sophia3", "sophia4"]
        ),
        UserProfile(
            name: "Lucas",
            age: 27,
            city: "Pamplona",
            bio: """
                Tech entrepreneur who loves outdoor activities. When not working on my startup, you'll find me hiking or playing guitar. Looking for someone ambitious and adventurous.

                I'm building a platform that helps local businesses connect with their communities. I believe technology should bring people together, not keep them apart.

                What keeps me busy:
                • Running my tech startup
                • Weekend hiking and rock climbing
                • Playing guitar in a local band
                • Mentoring young entrepreneurs
                • Training for my first marathon

                Seeking someone who's passionate about their goals, enjoys outdoor adventures, and wants to make a positive impact in the world.
                """,
            images: ["lucas1", "lucas2", "lucas3", "lucas4"]
        )
    ]
}

struct PhotoCarouselView: View {
    let images: [String]
    @Binding var currentImageIndex: Int
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // Images
            TabView(selection: $currentImageIndex) {
                ForEach(0..<images.count, id: \.self) { index in
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
                    .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            // Photo indicators
            HStack(spacing: 8) {
                ForEach(0..<images.count, id: \.self) { index in
                    Circle()
                        .fill(index == currentImageIndex ? Color.white : Color.white.opacity(0.5))
                        .frame(width: 8, height: 8)
                }
            }
            .padding(.bottom, 16)
        }
    }
}

struct ProfileCardView: View {
    let profile: UserProfile
    @State private var currentImageIndex = 0
    @State private var showActionSheet = false
    @State private var showReportSheet = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .shadow(radius: 5)
            
            VStack(spacing: 0) {
                // Photo Carousel with Action Buttons
                ZStack(alignment: .topTrailing) {
                    PhotoCarouselView(images: profile.images, currentImageIndex: $currentImageIndex)
                        .frame(height: 400)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    // Block and Report Buttons
                    HStack(spacing: 12) {
                        Button(action: {
                            showReportSheet = true
                        }) {
                            Image(systemName: "flag.fill")
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                                .frame(width: 36, height: 36)
                                .background(Color.black.opacity(0.5))
                                .clipShape(Circle())
                        }
                        
                        Button(action: {
                            showActionSheet = true
                        }) {
                            Image(systemName: "hand.raised.fill")
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                                .frame(width: 36, height: 36)
                                .background(Color.black.opacity(0.5))
                                .clipShape(Circle())
                        }
                    }
                    .padding(16)
                }
                
                // Profile Info
                ScrollView {
                    VStack(alignment: .leading, spacing: 12) {
                        // Name, Age and City
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
                        .padding(.top, 20)
                        
                        // Bio
                        Text(profile.bio)
                            .font(.system(size: 16))
                            .foregroundColor(AppColors.textSecondary)
                            .lineSpacing(4)
                            .padding(.top, 4)
                            .padding(.bottom, 20)
                    }
                    .padding(.horizontal, 20)
                }
                .frame(height: 150)
            }
        }
        .frame(height: 550)
        .confirmationDialog("Block User", isPresented: $showActionSheet, titleVisibility: .visible) {
            Button("Block \(profile.name)", role: .destructive) {
                // Implement block functionality
                print("Blocked \(profile.name)")
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("This user will no longer be able to see your profile or contact you.")
        }
        .confirmationDialog("Report User", isPresented: $showReportSheet, titleVisibility: .visible) {
            Button("Inappropriate Content", role: .destructive) {
                // Implement report functionality
                print("Reported \(profile.name) for inappropriate content")
            }
            Button("Harassment", role: .destructive) {
                // Implement report functionality
                print("Reported \(profile.name) for harassment")
            }
            Button("Fake Profile", role: .destructive) {
                // Implement report functionality
                print("Reported \(profile.name) for fake profile")
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Why are you reporting this profile?")
        }
    }
}

struct DiscoverView: View {
    @State private var profiles = UserProfile.sampleProfiles
    @State private var currentIndex = 0
    @State private var gestureTranslation: CGFloat = 0
    
    var body: some View {
        NavigationView {
            ZStack {
                AppColors.background
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    if !profiles.isEmpty {
                        // Profile Cards Stack
                        ZStack {
                            ForEach(profiles.indices.prefix(2).reversed(), id: \.self) { index in
                                ProfileCardView(profile: profiles[index])
                                    .padding(.horizontal)
                                    .offset(x: index == currentIndex ? CGFloat(gestureTranslation) : 0)
                                    .rotationEffect(
                                        .degrees(index == currentIndex ? Double(gestureTranslation / 20) : 0)
                                    )
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
                        .padding(.top, 10)
                        
                        Spacer()
                        
                        // Action Buttons
                        HStack(spacing: 40) {
                            actionButton(systemName: "xmark", color: .red) {
                                handleSwipe(-500)
                            }
                            
                            actionButton(systemName: "heart.fill", color: AppColors.navarraBlue) {
                                handleSwipe(500)
                            }
                        }
                        .padding(.bottom, 30)
                    } else {
                        // No profiles view - Centered in the screen
                        VStack(spacing: 16) {
                            Image(systemName: "heart.slash.fill")
                                .font(.system(size: 40))
                                .foregroundColor(AppColors.navarraBlue)
                            
                            Text("No more profiles to show")
                                .font(.system(size: 20))
                                .foregroundColor(AppColors.textSecondary)
                        }
                        .frame(maxHeight: .infinity)
                    }
                }
            }
            .navigationTitle("Discover")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func handleSwipe(_ translation: CGFloat) {
        let threshold: CGFloat = 150
        
        if abs(translation) > threshold {
            if translation > 0 {
                // Right swipe - Like
                print("Liked \(profiles[currentIndex].name)")
            } else {
                // Left swipe - Pass
                print("Passed \(profiles[currentIndex].name)")
            }
            
            // Remove the current profile
            if currentIndex < profiles.count {
                profiles.remove(at: currentIndex)
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
    DiscoverView()
} 