//
//  VibePopupViewModel.swift
//  Pick Your Vibe
//
//  Created by Asaf Baibekov on 12/07/2025.
//

import Foundation

struct VibePopupViewModel {

    private(set) var vibe: Vibe
    
    private(set) var countThisWeek: Int
    
    init?(url: URL) {
        guard
            url.scheme == "pickyourvibe", url.host == "widget",
            let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
            let queryItems = components.queryItems
        else { return nil }
        
        var emoji: String?
        var label: String?
        var countThisWeek: Int?
        
        for item in queryItems {
            switch item.name {
            case "emoji":
                emoji = item.value
            case "label":
                label = item.value
            case "count":
                countThisWeek = Int(item.value ?? "")
            default:
                break
            }
        }
        
        guard let emoji, let label, let countThisWeek else {
            return nil
        }
        
        self.vibe = Vibe(emoji: emoji, label: label)
        self.countThisWeek = countThisWeek
    }
    
    init(vibe: Vibe, countThisWeek: Int) {
        self.vibe = vibe
        self.countThisWeek = countThisWeek
    }
}
