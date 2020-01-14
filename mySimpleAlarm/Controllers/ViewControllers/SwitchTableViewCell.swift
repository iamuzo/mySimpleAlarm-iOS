//
//  AlarmTableViewCell.swift
//  mySimpleAlarm
//
//  Created by Uzo on 1/13/20.
//  Copyright © 2020 Uzo. All rights reserved.
//

import UIKit

protocol ToggleSwitchTableViewCellDelegate {
    func toggleSwitchCell(isOn: Bool)
}

class SwitchTableViewCell: UITableViewCell {
    
    var alarm: Alarm?
    var delegate: ToggleSwitchTableViewCellDelegate?

    //MARK:- Outlets
    @IBOutlet weak var alarmStarttimeLabel: UILabel!
    @IBOutlet weak var alarmTitle: UILabel!
    @IBOutlet weak var alarmSwitch: UISwitch!
    
    //MARK:- Actions
    @IBAction func switchValueChanged(_ sender: UISwitch) {
        self.delegate?.toggleSwitchCell(isOn: sender.isOn)
    }
    
    func updateViews() {
        guard let alarm = alarm else { return }
        alarmStarttimeLabel.text = alarm.startTimeAsString
        alarmTitle .text = alarm.title
        alarmSwitch.isOn = alarm.isEnabled
    }
    
    
}
