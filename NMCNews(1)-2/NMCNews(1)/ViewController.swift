//
//  ViewController.swift
//  NMCNews(1)
//
//  Created by Harun Fernando on 16/12/20.
//  Copyright © 2020 Harun Fernando. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var passwordLbl: UILabel!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var signInLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    
    // Reference to managed object context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        txtUsername.layer.cornerRadius = 5
        txtPassword.layer.cornerRadius = 5
        
        loginBtn.backgroundColor = UIColor.blue
        loginBtn.layer.cornerRadius = 5
        loginBtn.setTitleColor(UIColor.white, for: .normal)
        
        txtPassword.isSecureTextEntry = true
    
    }
    
    @IBAction func loginBtn(_ sender: Any) {
        validation()
    }
    
    @IBAction func register(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showalert(title:String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(okAction)
        present(alert, animated: true,completion: nil)
    }

    func validation(){
        let Username:String = txtUsername.text!
        let Password:String = txtPassword.text!
        
        if(Username != "" && Password != "") {
            if CheckUsernameAndPassword(username: Username, password: Password){
                performSegue(withIdentifier: "logintonewssegue", sender: self)
            }else{
                showalert(title: "Alert", message: "User doesn't exist")
            }
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if segue.identifier == "logintonewssegue" {
            if let nav = segue.destination as? UINavigationController,
                let destination = nav.topViewController as? NewsViewController{
                destination.username = txtUsername.text!
            }
        }
    }
    
    func CheckUsernameAndPassword(username : String, password : String) -> Bool{
        //check user
        let usernameinput = txtUsername.text
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        var managedObjectContext = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        request.predicate = NSPredicate(format: "username == %@ AND password == %@", username ,password)
        
        //let response = try! context.fetch(request) as! [User]
        
        var result = [NSManagedObject]()
        
        do{
            result = try context.fetch(request) as! [NSManagedObject]
        }catch{
            
        }
        
        for username in result{
            if ((username.value(forKeyPath: "username") as! String)) == usernameinput{
                //iduser = username.value(forKeyPath: "username") as! String
                return true
            }
        }
        
        return false
        
        //return response.count > 0 ? true : false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }

    

}

