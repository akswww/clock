//
//  UserPerferences.swift
//  clock
//
//  Created by imac-1681 on 2023/7/28.
//

import Foundation

class UserPerferences: NSObject {
    static let shard = UserPerferences()
    
    var tempTime1: Double {
        get {return UserDefaults.standard.double(forKey: "tempTime")}
        set {UserDefaults.standard.set(newValue, forKey: "tempTime")}
    }
    
    var tempCity: [String] {
        get {return UserDefaults.standard.stringArray(forKey: "tempCity") ?? []}
        set {UserDefaults.standard.set(newValue, forKey: "tempCity")}
    }
    
    var tempGap: [String] {
        get {return UserDefaults.standard.stringArray(forKey: "tempGap") ?? []}
        set {UserDefaults.standard.set(newValue, forKey: "tempGap")}
    }
    
}
