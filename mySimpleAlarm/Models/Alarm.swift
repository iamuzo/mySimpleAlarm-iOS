//
//  Alarm.swift
//  mySimpleAlarm
//
//  Created by Uzo on 1/13/20.
//  Copyright © 2020 Uzo. All rights reserved.
//

import Foundation

class Alarm: Codable {
    
    //MARK:- Properties
    var title: String
    var isEnabled: Bool
    var startTime: Date
    var uuid: String
  
    init(title: String, isEnabled: Bool = true, startTime: Date = Date()) {
        self.title = title
        self.isEnabled = isEnabled
        self.startTime = startTime
        self.uuid = UUID().uuidString
    }
    
    // Computed Properties
    var startTimeAsString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .medium
        let alarmTime = dateFormatter.string(from: self.startTime)
        return(alarmTime)
    }

}

extension Alarm: Equatable {
    static func == (lhs: Alarm, rhs: Alarm) -> Bool {
        return (
            lhs.title == rhs.title
        )
    }
}
