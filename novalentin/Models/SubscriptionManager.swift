import SwiftUI
import StoreKit

class SubscriptionManager: ObservableObject {
    @Published var isSubscribed = false
    @Published var isTrialActive = false
    @Published var trialEndDate: Date?
    
    static let shared = SubscriptionManager()
    
    private init() {
        // Initialize with no subscription
        // In a real app, you would load the state from UserDefaults or your backend
    }
    
    func startTrial() {
        isTrialActive = true
        trialEndDate = Calendar.current.date(byAdding: .day, value: 7, to: Date())
        // In a real app, you would save this to UserDefaults or your backend
    }
    
    func subscribe() {
        isSubscribed = true
        // In a real app, you would handle the actual subscription purchase through StoreKit
    }
    
    func checkSubscriptionStatus() -> Bool {
        if isSubscribed {
            return true
        }
        
        if let endDate = trialEndDate, isTrialActive {
            return Date() < endDate
        }
        
        return false
    }
} 