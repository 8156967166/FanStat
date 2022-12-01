//
//  ViewController.swift
//  FanStat
//
//  Created by Bimal@AppStation on 21/11/22.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func registerNowButtonAction(_ sender: Any) {
        self.performSegue(withIdentifier: "RegistrationViewController", sender: nil)
    }

}

