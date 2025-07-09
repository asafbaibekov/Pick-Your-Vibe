//
//  UserDefaultsVibeStorable.swift
//  Pick Your Vibe
//
//  Created by Asaf Baibekov on 09/07/2025.
//


import Foundation

final class UserDefaultsVibeStorable: Storable {
    
    private let selectedVibeKey = "selectedVibe"
    
    private let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    func save(_ value: [Vibe]?) async throws {
        let encoded = try JSONEncoder().encode(value)
        await Task.detached(priority: .userInitiated) {
            self.userDefaults.set(encoded, forKey: self.selectedVibeKey)
        }.value
    }

    func load() async throws -> [Vibe]? {
        return try await Task.detached(priority: .utility) {
            guard let data = self.userDefaults.data(forKey: self.selectedVibeKey) else { return nil }
            return try JSONDecoder().decode([Vibe].self, from: data)
        }.value
    }
}
