import SwiftUI

struct ChatDetailView: View {
    let match: Match
    @State private var messageText = ""
    @State private var messages: [ChatMessage] = []
    @FocusState private var isInputFocused: Bool
    
    // Sample user ID (in a real app, this would come from authentication)
    let currentUserId = UUID()
    
    init(match: Match) {
        self.match = match
        // Initialize with sample messages
        let matchId = match.id
        _messages = State(initialValue: [
            ChatMessage(
                senderId: matchId,
                content: "Hey there! Thanks for the match!",
                timestamp: Date().addingTimeInterval(-3600 * 2),
                isRead: true
            ),
            ChatMessage(
                senderId: currentUserId,
                content: "Hi! I really liked your profile, especially your interest in photography!",
                timestamp: Date().addingTimeInterval(-3600),
                isRead: true
            ),
            ChatMessage(
                senderId: matchId,
                content: "Thank you! I see you're into photography too. What kind of photos do you like to take?",
                timestamp: Date().addingTimeInterval(-1800),
                isRead: true
            )
        ])
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Chat messages
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(messages) { message in
                            MessageBubble(message: message, isFromCurrentUser: message.senderId == currentUserId)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 12)
                }
                .onChange(of: messages.count) { _ in
                    // Scroll to bottom when new message is added
                    withAnimation {
                        proxy.scrollTo(messages.last?.id, anchor: .bottom)
                    }
                }
            }
            
            // Input area
            VStack(spacing: 0) {
                Divider()
                HStack(spacing: 12) {
                    TextField("Type a message...", text: $messageText, axis: .vertical)
                        .textFieldStyle(.roundedBorder)
                        .focused($isInputFocused)
                        .lineLimit(1...5)
                    
                    Button(action: sendMessage) {
                        Image(systemName: "arrow.up.circle.fill")
                            .font(.system(size: 32))
                            .foregroundColor(messageText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? 
                                AppColors.textSecondary : AppColors.navarraBlue)
                    }
                    .disabled(messageText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
                .background(Color.white)
            }
        }
        .navigationTitle(match.profile.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: MatchProfileView(profile: match.profile)) {
                    Image(systemName: "info.circle")
                        .foregroundColor(AppColors.navarraBlue)
                }
            }
        }
    }
    
    private func sendMessage() {
        let trimmedMessage = messageText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedMessage.isEmpty else { return }
        
        let newMessage = ChatMessage(
            senderId: currentUserId,
            content: trimmedMessage,
            timestamp: Date(),
            isRead: false
        )
        
        messages.append(newMessage)
        messageText = ""
        
        // Simulate received message (for demo purposes)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let response = ChatMessage(
                senderId: match.id,
                content: "That's interesting! Tell me more...",
                timestamp: Date(),
                isRead: false
            )
            messages.append(response)
        }
    }
}

struct MessageBubble: View {
    let message: ChatMessage
    let isFromCurrentUser: Bool
    
    var body: some View {
        HStack {
            if isFromCurrentUser { Spacer() }
            
            VStack(alignment: isFromCurrentUser ? .trailing : .leading, spacing: 4) {
                Text(message.content)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(isFromCurrentUser ? AppColors.navarraBlue : Color.gray.opacity(0.2))
                    .foregroundColor(isFromCurrentUser ? .white : AppColors.textPrimary)
                    .cornerRadius(16)
                
                Text(formatTimestamp(message.timestamp))
                    .font(.system(size: 12))
                    .foregroundColor(AppColors.textSecondary)
            }
            
            if !isFromCurrentUser { Spacer() }
        }
    }
    
    private func formatTimestamp(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

struct MatchProfileView: View {
    let profile: UserProfile
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Profile image
                Circle()
                    .fill(AppColors.navarraBlue.opacity(0.2))
                    .frame(width: 120, height: 120)
                    .overlay(
                        Image(systemName: "person.fill")
                            .foregroundColor(AppColors.navarraBlue)
                            .font(.system(size: 48))
                    )
                
                // Profile info
                VStack(spacing: 8) {
                    Text("\(profile.name), \(profile.age)")
                        .font(.system(size: 24, weight: .bold))
                    
                    Text(profile.city)
                        .font(.system(size: 18))
                        .foregroundColor(AppColors.textSecondary)
                }
                
                // Bio
                Text(profile.bio)
                    .font(.system(size: 16))
                    .foregroundColor(AppColors.textSecondary)
                    .padding(.horizontal)
                    .multilineTextAlignment(.center)
            }
            .padding()
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        ChatDetailView(match: Match(
            profile: UserProfile(
                name: "Isabella",
                age: 26,
                city: "Sevilla",
                bio: "Professional dancer and dance instructor...",
                images: ["isabella1", "isabella2", "isabella3"]
            ),
            matchDate: Date().addingTimeInterval(-86400),
            lastMessage: nil,
            unreadCount: 0
        ))
    }
} 