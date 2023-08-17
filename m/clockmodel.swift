//
//  clockmodel.swift
//  clock
//
//  Created by imac-1681 on 2023/7/16.
//
import UIKit
import Foundation
import RealmSwift
class RealmModel: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var hour: Int
    @Persisted var min: Int
    @Persisted var delTime:Int
    @Persisted var swichStatus:Bool
    
    @Persisted var whatDay:String
    @Persisted var whatMusic:String
    @Persisted var delaySwich:Bool
    @Persisted var whattext:String
    @Persisted var nickff: List<Int>
    @Persisted var selectMusic: List<Int>
    
    convenience init(hour: Int,min: Int,delTime: Int,swichStatus: Bool,delaySwich:Bool,whatMusic:String,whatDay:String,whattext:String, nickff: List<Int>, selectMusic: List<Int>) {
        self.init()
        self.hour = hour
        self.min = min
        self.delTime = delTime
        self.swichStatus = swichStatus
        
        self.whatDay = whatDay
        self.whatMusic = whatMusic
        self.delaySwich = delaySwich
        self.whattext = whattext
        self.nickff = nickff
        self.selectMusic = selectMusic
    }
}
class time {
    var hour = [Int](0...23)
    var minute = [Int](0...59)
    static var time_shared = time()
    private init() {}
}
struct setTime {
    
    var hour:Int
    
    var min:Int
    
    var delTime:Int
    
    var swichStaus:Bool
    
    var whatDay:String
    
    var whatMusic:String
    
    var delaySwich:Bool
    
    var whattext:String
    
    var nickff: List<Int>
    
    var selectMusic: List<Int>
}
