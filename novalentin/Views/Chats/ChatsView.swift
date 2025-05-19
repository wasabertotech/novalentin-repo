import SwiftUI

// Models for chat functionality
struct ChatMessage: Identifiable {
    let id = UUID()
    let senderId: UUID
    let content: String
    let timestamp: Date
    var isRead: Bool
}

struct Match: Identifiable {
    let id = UUID()
    let profile: UserProfile
    let matchDate: Date
    var lastMessage: ChatMessage?
    var unreadCount: Int
    
    var lastActivityDate: Date {
        lastMessage?.timestamp ?? matchDate
    }
}

struct ChatsView: View {
    @State private var matches: [Match] = [
        // Sample matches with messages
        Match(
            profile: UserProfile(
                name: "Isabella",
                age: 26,
                city: "Sevilla",
                bio: "Professional dancer and dance instructor...",
                images: ["isabella1", "isabella2", "isabella3"]
            ),
            matchDate: Date().addingTimeInterval(-86400), // 1 day ago
            lastMessage: ChatMessage(
                senderId: UUID(),
                content: "Would you like to grab coffee this weekend?",
                timestamp: Date().addingTimeInterval(-1800), // 30 mins ago
                isRead: false
            ),
            unreadCount: 1
        ),
        Match(
            profile: UserProfile(
                name: "Marco",
                age: 29,
                city: "Bilbao",
                bio: "Marine biologist with a passion for ocean conservation...",
                images: ["marco1", "marco2", "marco3", "marco4"]
            ),
            matchDate: Date().addingTimeInterval(-172800), // 2 days ago
            lastMessage: ChatMessage(
                senderId: UUID(),
                content: "That's amazing! I love photography too!",
                timestamp: Date().addingTimeInterval(-3600), // 1 hour ago
                isRead: true
            ),
            unreadCount: 0
        )
    ]
    
    var sortedMatches: [Match] {
        matches.sorted { $0.lastActivityDate > $1.lastActivityDate }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                AppColors.background
                    .ignoresSafeArea()
                
                if sortedMatches.isEmpty {
                    // Empty state
                    VStack(spacing: 16) {
                        Image(systemName: "message.slash.fill")
                            .font(.system(size: 40))
                            .foregroundColor(AppColors.navarraBlue)
                        
                        Text("No matches yet")
                            .font(.system(size: 20))
                            .foregroundColor(AppColors.textSecondary)
                        
                        Text("When you match with someone, your conversations will appear here!")
                            .font(.system(size: 16))
                            .foregroundColor(AppColors.textSecondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    .frame(maxHeight: .infinity)
                } else {
                    List {
                        ForEach(sortedMatches) { match in
                            NavigationLink(destination: ChatDetailView(match: match)) {
                                ChatPreviewRow(match: match)
                            }
                            .listRowBackground(Color.clear)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Chats")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ChatPreviewRow: View {
    let match: Match
    
    var timeAgoText: String {
        // Simple time ago formatting - could be more sophisticated
        let seconds = Date().timeIntervalSince(match.lastActivityDate)
        if seconds < 60 {
            return "Just now"
        } else if seconds < 3600 {
            let minutes = Int(seconds / 60)
            return "\(minutes)m ago"
        } else if seconds < 86400 {
            let hours = Int(seconds / 3600)
            return "\(hours)h ago"
        } else {
            let days = Int(seconds / 86400)
            return "\(days)d ago"
        }
    }
    
    var body: some View {
        HStack(spacing: 12) {
            // Profile Image
            Circle()
                .fill(AppColors.navarraBlue.opacity(0.2))
                .frame(width: 60, height: 60)
                .overlay(
                    Image(systemName: "person.fill")
                        .foregroundColor(AppColors.navarraBlue)
                        .font(.system(size: 24))
                )
            
            VStack(alignment: .leading, spacing: 4) {
                Text(match.profile.name)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(AppColors.textPrimary)
                
                if let lastMessage = match.lastMessage {
                    Text(lastMessage.content)
                        .font(.system(size: 15))
                        .foregroundColor(AppColors.textSecondary)
                        .lineLimit(1)
                } else {
                    Text("New match!")
                        .font(.system(size: 15))
                        .foregroundColor(AppColors.navarraBlue)
                }
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text(timeAgoText)
                    .font(.system(size: 13))
                    .foregroundColor(AppColors.textSecondary)
                
                if match.unreadCount > 0 {
                    Text("\(match.unreadCount)")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(width: 18, height: 18)
                        .background(AppColors.navarraBlue)
                        .clipShape(Circle())
                }
            }
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    ChatsView()
} 