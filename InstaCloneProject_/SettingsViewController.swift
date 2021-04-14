//
//  SettingsViewController.swift
//  InstaCloneProject_
//
//  Created by Şeyma Nur on 13.04.2021.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func logoutClicked(_ sender: Any) {
    
        do{
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "toViewController", sender: nil)
        }catch{
            print("error")
        }
    }
    

}
