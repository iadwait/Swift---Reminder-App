//
//  AddReminderViewController.swift
//  Reminder App
//
//  Created by Adwait Barkale on 09/09/20.
//  Copyright © 2020 Adwait Barkale. All rights reserved.
//

import UIKit

class AddReminderViewController: UIViewController {
    
    
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtBody: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    var btnSave: UIButton!
    
    public var completion: ((String,String,Date) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI()
    {
        title = "New Reminder"
        navigationItem.largeTitleDisplayMode = .never
        
        btnSave = UIButton(type: .custom)
        btnSave.frame = .init(x: 0, y: 0, width: 50, height: 30)
        btnSave.setTitle("Save", for: .normal)
        btnSave.addTarget(self, action: #selector(btnSaveTapped), for: .touchUpInside)
        btnSave.setTitleColor(.systemBlue, for: .normal)
        let saveBarBtnItem = UIBarButtonItem(customView: btnSave)
        saveBarBtnItem.customView?.widthAnchor.constraint(equalToConstant: 50).isActive = true
        saveBarBtnItem.customView?.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.navigationItem.rightBarButtonItem = saveBarBtnItem
    }
    
    @objc func btnSaveTapped()
    {
        if let title = txtTitle.text,txtTitle.text != "",
            let body = txtBody.text,txtBody.text != ""
        {
            let targetDate = datePicker.date
            completion?(title,body,targetDate)
            navigationController?.popViewController(animated: true)
        }else{
            let alert = UIAlertController(title: "Missing Data", message: "Please Enter Data for all the Fields", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "ok", style: .cancel, handler: nil)
            alert.addAction(okAction)
            present(alert,animated: true)
        }
    }
    
}
