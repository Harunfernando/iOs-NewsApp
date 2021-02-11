//
//  AddUpdateViewController.swift
//  NMCNews(1)
//
//  Created by Yohan on 19/12/20.
//  Copyright © 2020 Harun Fernando. All rights reserved.
//

import UIKit
import CoreData

var username1: String?

class AddUpdateViewController: UIViewController,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    var idnewscount = [Int64]()
    var idcount:Int64?
    
    var news = [News]()
    var titleBaru = [String]()
    var descBaru = [String]()
    var imageBaru = [NSData]()
    var idnewsBaru = [Int64]()
    var iduserBaru = [String]()
    
    var titleNews: String?
    var descriptionNews: String?
    var imageNews: NSData?
    var idNews: Int64?
    var usernameNews: String?
    
    var usernameUser: String?
    
    var newsidupdate: Int64?
    var titleupdate: String?
    var descriptionupdate : String?
    var imageupdate: UIImage?
    
    var context : NSManagedObjectContext!

    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var ImagesView: UIImageView!
    @IBOutlet weak var txtDescription: UITextView!
    @IBOutlet weak var deletebutton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtDescription.delegate = self
        self.txtDescription.layer.borderWidth = 1.0
        txtDescription.layer.borderColor = UIColor.lightGray.cgColor
        txtDescription.layer.cornerRadius = 10
        ImagesView.layer.borderColor = UIColor.lightGray.cgColor
        //ImagesView.layer.cornerRadius = 10
        ImagesView.layer.borderWidth = 1.0
        ImagesView.image = UIImage(named: "Logo")
        let delegate = UIApplication.shared.delegate as! AppDelegate
        context = delegate.persistentContainer.viewContext
        
        if flag == "update"{
            txtTitle.text = titleupdate
            txtDescription.text = descriptionupdate
            ImagesView.image = imageupdate
        }else{
            self.navigationItem.rightBarButtonItem = nil
        }
    }

    @IBAction func btnBack(_ sender: Any) {
        performSegue(withIdentifier: "unwind_to_home", sender: self)
    }
    
    func loadData() {
        
        idnewscount.removeAll()
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "News")
        
        do {
            let result = try context.fetch(request) as! [NSManagedObject]
            for data in result {
                idnewscount.append(data.value(forKey: "newsid") as! Int64)
            }
        }catch {
            
            print("You have an error")
        }
        
        if idnewscount.isEmpty{
            idcount = 0
        }else{
            idcount = idnewscount[idnewscount.count-1]
            idcount = idcount! + 1
        }
    }
    
    @IBAction func btnUpload(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        
        imagePicker.sourceType = .photoLibrary
        
        imagePicker.delegate = self
        
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            picker.dismiss(animated: true, completion: nil)
//            self.createNewsItem(with: image)
            ImagesView.image = image
        }
    }
    
    @IBAction func btnSave(_ sender: Any) {
        let title = txtTitle.text as! String
        let desc = txtDescription.text as! String
      
        if title.isEmpty || desc.isEmpty{
            showalert(title: "Alert", message: "Title and Description can't be empty")
        }
        else if title.count < 4 && title.count > 12{
            showalert(title: "Alert", message: "Title must be between 4 to 12 characters")
        }else if desc.count > 150{
            showalert(title: "Alert", message: "Desc must be less than 150 characters")
        }else{
            if flag == "update"{
                loadData()
                update(with: ImagesView.image!)
            }else{
            loadData()
            createNewsItem(with: ImagesView.image!)
            }
            performSegue(withIdentifier: "unwind_to_home", sender: self)
        }
        
    }

    
    @IBAction func btndelete(_ sender: Any) {
        delete()
       performSegue(withIdentifier: "unwind_to_home", sender: self)
    }
    
    func createNewsItem (with image: UIImage) {
        let image1 = image
        let titleField = txtTitle.text
        let descriptionField = txtDescription.text
        let idnewsField = idcount

        if titleField != "" && descriptionField != "" {
            let entity = NSEntityDescription.entity(forEntityName: "News", in: self.context)
            let newitem = NSManagedObject(entity: entity!, insertInto: self.context)
            
            self.titleNews = titleField
            self.descriptionNews = descriptionField
            self.imageNews = image1.pngData() as! NSData
            self.idNews = idnewsField
            self.usernameNews = username1
            
            newitem.setValue(self.titleNews, forKey: "title")
            newitem.setValue(self.descriptionNews, forKey: "desc")
            newitem.setValue(self.imageNews, forKey: "image")
            newitem.setValue(self.idNews, forKey: "newsid")
            newitem.setValue(self.usernameNews, forKey: "userid")
            
            do {
                try self.context.save()
            }catch {
                print("Could not save data \(error.localizedDescription)")
            }
        }
        
    }
    
    func update(with image: UIImage){
        let image1 = image
        let titleField = txtTitle.text
        let descriptionField = txtDescription.text
        let idnewsField = newsidupdate
        
        if titleField != "" && descriptionField != "" {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "News")
            
            self.titleNews = titleField
            self.descriptionNews = descriptionField
            self.imageNews = image1.pngData() as! NSData
            self.idNews = idnewsField
            self.usernameNews = username1
            
            do {
                let result = try context.fetch(request) as! [NSManagedObject]
                for data in result {
                    if data.value(forKey: "newsid") as! Int64 == newsidupdate as! Int64{
                        data.setValue(titleNews, forKey: "title")
                        data.setValue(descriptionNews, forKey: "desc")
                        data.setValue(imageNews, forKey: "image")
                    }
                }
                 try self.context.save()
            }catch {
                print("You have an error")
            }
       
        }
    }
    
    func delete(){
    
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "News")
            
            do {
                let result = try context.fetch(request) as! [NSManagedObject]
                for data in result {
                    if data.value(forKey: "newsid") as! Int64 == newsidupdate as! Int64{
                        context.delete(data)
                    }
                }
                try self.context.save()
            }catch {
                print("You have an error")
            }
        
    }
    
    func showalert(title:String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okaction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(okaction)
        present(alert, animated: true,completion: nil)
    }
    
}
