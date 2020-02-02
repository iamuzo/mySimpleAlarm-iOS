//
//  AlarmController.swift
//  mySimpleAlarm
//
//  Created by Uzo on 1/13/20.
//  Copyright © 2020 Uzo. All rights reserved.
//

import Foundation

class AlarmController {
    
    //MARK:- Global Shared Instance
    static let sharedGlobalInstance = AlarmController()
    
    //MARK:- Properties
    var alarms: [Alarm] = []
    
    init() {
        loadFromLocalPersistenceStore()
    }
    
    //MARK:- CRUD
    func create(newAlarmWith title: String, isEnabled: Bool = true, startTime: Date) {
        let alarm = Alarm(title: title, isEnabled: isEnabled, startTime: startTime)
        alarms.append(alarm)
        saveToLocalPersistenceStore()
    }

    func update(existingAlarm alarm: Alarm, withNewTitle title: String, newIsEnabled isEnabled: Bool, andNewStartTime startTime: Date) {
        guard let indexOfAlarmToUpdate = alarms.firstIndex(of: alarm) else {
            print("Cannot find an alarm at the index of the editedAlarm")
            return
        }
        let alarmToUpdate = alarms[indexOfAlarmToUpdate]
        if alarmToUpdate == alarm {
            alarmToUpdate.title = title
            alarmToUpdate.isEnabled = isEnabled
            alarmToUpdate.startTime = startTime
            saveToLocalPersistenceStore()
        } else {
            print("The two objects are not the same")
        }
    }
    
    func delete(existingAlarm alarm: Alarm) {
        if let index = alarms.firstIndex(of: alarm) {
            alarms.remove(at: index)
            saveToLocalPersistenceStore()
        }
    }
    
    
    //MARK:- Local Persistence
    private func localFilePersistenceURL() -> URL {
       let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
       let dir = path[0]
       let filepath = "mySimpleAlarm.json"
       let fileURL = dir.appendingPathComponent(filepath)
       return fileURL
   }
    
    func saveToLocalPersistenceStore() {
        let jsonEncoder = JSONEncoder()
        
        do {
            let data = try jsonEncoder.encode(alarms)
            try data.write(to: localFilePersistenceURL())
        } catch {
            print("Error saving data: \(error); \(error.localizedDescription)")
        }
    }
    
    func loadFromLocalPersistenceStore(){
       let jsonDecoder = JSONDecoder()
       
       do {
           let data = try Data(contentsOf: localFilePersistenceURL())
           let decodedData = try jsonDecoder.decode([Alarm].self, from: data)
           self.alarms = decodedData
       } catch {
           print("Error loading data from local persistence store: \(error); \(error.localizedDescription)")
       }
   }
}
