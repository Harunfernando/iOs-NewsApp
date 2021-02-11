//
//  RegisterViewController.swift
//  NMCNews(1)
//
//  Created by Harun Fernando on 16/12/20.
//  Copyright © 2020 Harun Fernando. All rights reserved.
//

import UIKit
import CoreData

var usercount:Int64 = 1

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var signUpLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var firstNameLbl: UILabel!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var lastNameLbl: UILabel!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var passwordLbl: UILabel!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var logoImg: UIImageView!
    
    // Reference to managed object context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtFirstName.layer.cornerRadius = 5
        txtLastName.layer.cornerRadius = 5
        txtUsername.layer.cornerRadius = 5
        txtPassword.layer.cornerRadius = 5
        
        registerBtn.backgroundColor = UIColor.blue
        registerBtn.layer.cornerRadius = 5
        registerBtn.setTitleColor(UIColor.white, for: .normal)
        
        txtPassword.isSecureTextEntry = true
        
    }

    @IBAction func registAction(_ sender: Any) {
        validation()
    }
    
    @IBAction func loginAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! ViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func validation(){
        var firstName:String = txtFirstName.text!
        var lastName:String = txtLastName.text!
        var username:String = txtUsername.text!
        var password:String = txtPassword.text!
        
        if (firstName.count < 4 || firstName.count > 12) {
            showAlert(title: "Alert", message: "First name can't be less than 4 character")
        }else if (lastName.count < 4 || lastName.count > 12) {
            showAlert(title: "Alert", message: "Last name can't be less than 4 character")
        }else if (username.count < 4 || username.count > 12){
            showAlert(title: "Alert", message: "Username can't be less than 4 character")
        }else if (password.count < 4 || password.count > 12){
            showAlert(title: "Alert", message: "Password can't be less than 4 character")
        }
        else{
            saveUser()
            performSegue(withIdentifier: "regist_success", sender: self)
        }
    }
    
    func saveUser(){
        let firstName = txtFirstName.text
        let lastName = txtLastName.text
        let username = txtUsername.text
        let password = txtPassword.text
    
        // Create new user
        let newUser = User(context: self.context)
        newUser.firstName = firstName
        newUser.lastName = lastName
        newUser.username = username
        newUser.password = password
        newUser.userid = usercount
        
        // Save data
        do{
            try self.context.save()
            usercount += 1
        }
        catch{
            
        }
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    
    func showAlert(title:String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(okAction)
        present(alert, animated: true,completion: nil)
    }

}
