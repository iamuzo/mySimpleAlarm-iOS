//
//  AlarmViewController.swift
//  mySimpleAlarm
//
//  Created by Uzo on 1/13/20.
//  Copyright © 2020 Uzo. All rights reserved.
//

import UIKit

class AlarmViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: Outlets
    @IBOutlet weak var alarmTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alarmTableView.delegate = self
        alarmTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        alarmTableView.reloadData()
    }
    
    //MARK: TableView Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AlarmController.sharedGlobalInstance.alarms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = alarmTableView.dequeueReusableCell(withIdentifier: "alarmCell", for: indexPath) as? SwitchTableViewCell else { return UITableViewCell() }
        
        let alarm = AlarmController.sharedGlobalInstance.alarms[indexPath.row]
        cell.alarm = alarm
        cell.updateViews()
        cell.cellDelegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            //first find the alarm at the row that the user clicked on
            let alarm = AlarmController.sharedGlobalInstance.alarms[indexPath.row]
            
            // next delete that alarm via the GlobalSharedInstance
            AlarmController.sharedGlobalInstance.delete(existingAlarm: alarm)
            
            // then delete the row from the data source
            alarmTableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //IIDOO
        if segue.identifier == "toAlarmDetailVC" {
            guard let indexPath = alarmTableView.indexPathForSelectedRow, let destinationVC = segue.destination as? AlarmDetailViewController else { return }
            
            let alarm = AlarmController.sharedGlobalInstance.alarms[indexPath.row]
            
            destinationVC.alarm = alarm
        }
    }

}

extension AlarmViewController: ToggleSwitchTableViewCellDelegate {
    func switchCellSwitchValueChanged(cell: SwitchTableViewCell) {
        
        guard let indexPath = alarmTableView.indexPath(for: cell) else { return}
        let alarm = AlarmController.sharedGlobalInstance.alarms[indexPath.row]
        AlarmController.sharedGlobalInstance.toggleEnabled(for: alarm)
    }
}
