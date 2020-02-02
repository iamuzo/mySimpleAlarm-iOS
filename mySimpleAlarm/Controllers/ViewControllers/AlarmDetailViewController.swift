//
//  AlarmDetailViewController.swift
//  mySimpleAlarm
//
//  Created by Uzo on 1/13/20.
//  Copyright © 2020 Uzo. All rights reserved.
//

import UIKit

class AlarmDetailViewController: UIViewController {

    //MARK:- Properties
    var alarm: Alarm?
    
    //MARK:- Outlets
    @IBOutlet weak var alarmStartTimeDatePicker: UIDatePicker!
    @IBOutlet weak var alarmTitleTextField: UITextField!
    @IBOutlet weak var alarmSwitchButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        updateViews()
        customizeButtons()
    }
    
    //MARK:- Actions
    @IBAction func enableAlarmButtonTapped(_ sender: UIButton) {
        guard let alarm = alarm else { return }
        AlarmController.sharedGlobalInstance.toggleEnabled(for: alarm)
        navigationController?.popViewController(animated: true)
    }
    
    //MARK:- Custom Methods
    func updateViews() {
        guard let alarm = alarm else {
            alarmSwitchButton.isHidden = true
            return
        }
        
        alarmTitleTextField.text = alarm.title
        alarmStartTimeDatePicker.date = alarm.startTime
        alarmTitleTextField.isEnabled = false
        alarmStartTimeDatePicker.isEnabled = false
        
        if alarm.isEnabled == true {
            alarmSwitchButton.setTitle("Disable", for: .normal)
            alarmSwitchButton.setTitleColor(.red, for: .normal)
        } else {
            alarmSwitchButton.setTitle("Enable", for: .normal)
            alarmSwitchButton.setTitleColor(.darkGray, for: .normal)
        }
        
    }
    
    func customizeButtons() {
        if alarm != nil {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editAlarmButtonTapped))
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveAlarmButtonTapped))
        }
    }
    
    @objc func saveAlarmButtonTapped() {
        print("Save Alarm Button Tapped")
        guard let alarmTitle = alarmTitleTextField.text, !alarmTitle.isEmpty else { return }
        let selectedDate = alarmStartTimeDatePicker.date
            
        AlarmController.sharedGlobalInstance.create(newAlarmWith: alarmTitle, startTime: selectedDate)
        navigationController?.popViewController(animated: true)
    }
    
    @objc func editAlarmButtonTapped() {
        print("enable Editing Functionality and display save Button")
        alarmTitleTextField.isEnabled = true
        alarmStartTimeDatePicker.isEnabled = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(updateAlarmButtonTapped))
    }
    
    @objc func updateAlarmButtonTapped() {
        // first get the alarm that will be edited
        guard let alarm = alarm else {
            print("Alarm not found")
            return
        }
        
        guard let newTitle = alarmTitleTextField.text, !newTitle.isEmpty else {
            print("Alert user that alarm title must exist")
            return
        }
        
        let newDate = alarmStartTimeDatePicker.date
        let newStatus = alarm.isEnabled
        
        // call update function
        AlarmController.sharedGlobalInstance.update(existingAlarm: alarm, withNewTitle: newTitle, newIsEnabled: newStatus, andNewStartTime: newDate)
        navigationController?.popViewController(animated: true)
    }
}
