//
//  LoginViewController.swift
//  TStudySwift01
//
//  Created by ways on 2018/1/8.
//  Copyright © 2018年 tikeyc. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var userNameTextField: UITextField!
    
    @IBOutlet var passWordTextField: UITextField!
    
    @IBAction func loginButtonClick(_ sender: UIButton) {
        
        let user = userNameTextField.text
        let password = passWordTextField.text

        guard let inputUser = user else { return }
        
        if inputUser == "admin" && password == "666" {
            UserInstance.nickname = inputUser
            UserInstance.password = password!
            print("login successed")
        } else {
            print("login failed")
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
