import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            DiscoverView()
                .tabItem {
                    Label("Discover", systemImage: "flame.fill")
                }
                .tag(0)
            
            LikesView()
                .tabItem {
                    Label("Likes", systemImage: "heart.fill")
                }
                .tag(1)
            
            ChatsView()
                .tabItem {
                    Label("Chats", systemImage: "message.fill")
                }
                .tag(2)
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
                .tag(3)
        }
        .tint(AppColors.navarraBlue)
    }
}

#Preview {
    MainTabView()
} 