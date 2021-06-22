//
//  DataStore.swift
//  GithubClient
//
//  Created by Shota Fuchikami on 2021/06/22.
//

import Foundation

/// Handle UserDefaults
struct DataStore {
    
    private static let ud = UserDefaults.standard
    
    static func saveString(_ value: String?, forKey: String) {
        ud.set(value, forKey: forKey)
    }
    
    static func getString(forKey: String) -> String? {
        return ud.string(forKey: forKey)
    }
    
    static func delete(forKey: String) {
        ud.removeObject(forKey: forKey)
    }
}
