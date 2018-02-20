//
//  TableViewController.swift
//  CoreDataSampleApp
//
//  Created by Apple-1 on 20/02/18.
//  Copyright © 2018 Apple-1. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    private var dateCellExpanded: Bool = false
    @IBOutlet weak var btnView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if dateCellExpanded {
                dateCellExpanded = false
            } else {
                dateCellExpanded = true
            }
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            if dateCellExpanded {
                UIView.animate(withDuration: 0.25, animations: {
                   self.btnView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
                })
                return 100
            } else {
                UIView.animate(withDuration: 0.25, animations: {
                    self.btnView.transform = CGAffineTransform(rotationAngle: 0)
                })
                return 50
            }
        }
        return 50
    }
}
