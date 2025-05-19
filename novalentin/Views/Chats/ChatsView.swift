import SwiftUI

struct ChatsView: View {
    var body: some View {
        NavigationView {
            ZStack {
                AppColors.background
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    List {
                        ForEach(0..<5) { _ in
                            ChatPreviewRow()
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
    var body: some View {
        HStack(spacing: 12) {
            Circle()
                .fill(AppColors.navarraBlue.opacity(0.2))
                .frame(width: 60, height: 60)
                .overlay(
                    Image(systemName: "person.fill")
                        .foregroundColor(AppColors.navarraBlue)
                        .font(.system(size: 24))
                )
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Match Name")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(AppColors.textPrimary)
                
                Text("Last message preview...")
                    .font(.system(size: 15))
                    .foregroundColor(AppColors.textSecondary)
                    .lineLimit(1)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text("2m ago")
                    .font(.system(size: 13))
                    .foregroundColor(AppColors.textSecondary)
                
                Circle()
                    .fill(AppColors.navarraBlue)
                    .frame(width: 8, height: 8)
            }
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    ChatsView()
} 