//
//  ViewController.swift
//  Reminder App
//
//  Created by Adwait Barkale on 08/09/20.
//  Copyright © 2020 Adwait Barkale. All rights reserved.
//

import UIKit
import UserNotifications

class RemindersListViewController: UIViewController {

    @IBOutlet weak var tableReminders: UITableView!
    var arrReminders:[MyReminder] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableReminders.delegate = self
        tableReminders.dataSource = self
    }
    
    @IBAction func btnAddReminderTapped(_ sender: UIBarButtonItem) {
        //Show Add Reminder VC
        let addReminderVC = storyboard?.instantiateViewController(identifier: "AddReminderViewController") as! AddReminderViewController
        addReminderVC.completion = { title,body,date in
            let newReminder = MyReminder(name: title, date: date, identifier: "id_\(title)")
            self.arrReminders.append(newReminder)
            self.tableReminders.reloadData()
            
            let content = UNMutableNotificationContent()
            content.title = title
            content.sound = .default
            content.body = body
            
            let targetDate = date
            let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year,.month,.day,.hour
                ,.minute,.second], from: targetDate), repeats: false)
            
            let request = UNNotificationRequest(identifier: "xyz", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { (error) in
                if error != nil{
                    print("Error Firing Notification")
                }
            }
            
        }
        navigationController?.pushViewController(addReminderVC, animated: true)
        
    }
    
    @IBAction func btnTestNotificationTapped(_ sender: UIBarButtonItem) {
        //Fire Notification, Button to be Removed at End(Only for Testing Purpose)
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound]) { (success, err) in
            if success{
                self.fireTestNotification()
            }else{
                print("Notification Permission Denied")
            }
        }
    }
    
    func fireTestNotification()
    {
        let content = UNMutableNotificationContent()
        content.title = "Good Morning"
        content.sound = .default
        content.body = "Hey! Have a Great Day Ahead"
        
        let targetDate = Date().addingTimeInterval(10)
        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year,.month,.day,.hour
            ,.minute,.second], from: targetDate), repeats: false)
        
        let request = UNNotificationRequest(identifier: "xyz", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if error != nil{
                print("Error Firing Notification")
            }
        }
    }

}

extension RemindersListViewController: UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrReminders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableReminders.dequeueReusableCell(withIdentifier: "ReminderListViewCell") as! ReminderListViewCell
        cell.lblTitle.text = arrReminders[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

