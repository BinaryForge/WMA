//
//  UserHome.swift
//  WMA
//
//  Created by Alexey Kuznetsov on 9/27/18.
//  Copyright © 2018 Alexey Cain. All rights reserved.
//

import UIKit

class UserHome: UIViewController {


    @IBOutlet weak var leadingConst: NSLayoutConstraint!
    var menuOpen = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func openMenu(_ sender: Any) {
        if menuOpen == false{
            leadingConst.constant = 0
        }else{
            leadingConst.constant = -140
        }
        menuOpen = !menuOpen
    }
    
    @IBAction func timeOffClicked(_ sender: Any) {
        if menuOpen == false{
            leadingConst.constant = 0
        }else{
            leadingConst.constant = -140
        }
        menuOpen = !menuOpen
    }
    
}
