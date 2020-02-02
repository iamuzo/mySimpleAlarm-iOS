//
//  AlarmTableViewCell.swift
//  mySimpleAlarm
//
//  Created by Uzo on 1/13/20.
//  Copyright © 2020 Uzo. All rights reserved.
//

import UIKit

protocol ToggleSwitchTableViewCellDelegate: class {
    func switchCellSwitchValueChanged(cell: SwitchTableViewCell)
}

class SwitchTableViewCell: UITableViewCell {
    
    var alarm: Alarm?
    var cellDelegate: ToggleSwitchTableViewCellDelegate?

    //MARK:- Outlets
    @IBOutlet weak var alarmStarttimeLabel: UILabel!
    @IBOutlet weak var alarmTitle: UILabel!
    @IBOutlet weak var alarmSwitch: UISwitch!
    
    //MARK:- Actions
    @IBAction func switchValueChanged(_ sender: UISwitch) {
        cellDelegate?.switchCellSwitchValueChanged(cell: self)
    }
    
    func updateViews() {
        guard let alarm = alarm else { return }
        alarmStarttimeLabel.text = alarm.startTimeAsString
        alarmTitle .text = alarm.title
        alarmSwitch.isOn = alarm.isEnabled
    }
    
    
}
