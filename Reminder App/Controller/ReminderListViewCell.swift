//
//  ReminderListViewCell.swift
//  Reminder App
//
//  Created by Adwait Barkale on 09/09/20.
//  Copyright © 2020 Adwait Barkale. All rights reserved.
//

import UIKit

class ReminderListViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
