//
//  NewsViewController.swift
//  NMCNews(1)
//
//  Created by Yohan on 19/12/20.
//  Copyright © 2020 Harun Fernando. All rights reserved.
//

import UIKit
import CoreData

var flag = "add"

class NewsViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource{
    
    var titleBaru = [String]()
    var descBaru = [String]()
    var imageBaru = [NSData]()
    var idnewsBaru = [Int64]()
    var usernameBaru = [String]()

    var username: String?
    
    var titleNews: String?
    var descriptionNews: String?
    var imageNews: NSData?
    var usernameNews:String?
    
    var titletemp: String?
    var desctemp: String?
    var imagetemp: UIImage?
    var usernametemp: String?
    var newsidtemp: Int64?
    
    var context : NSManagedObjectContext!
    @IBOutlet weak var tvNews: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let delegate = UIApplication.shared.delegate as! AppDelegate
        context = delegate.persistentContainer.viewContext
        
        tvNews.dataSource = self
        tvNews.delegate = self
        username1 = username
        loadData()
        tvNews.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
        tvNews.reloadData()
    }
    
    func loadData() {
        
        titleBaru.removeAll()
        descBaru.removeAll()
        imageBaru.removeAll()
        idnewsBaru.removeAll()
        usernameBaru.removeAll()
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "News")
        
        do {
            let result = try context.fetch(request) as! [NSManagedObject]
            for data in result {
                titleBaru.append(data.value(forKey: "title") as! String)
                descBaru.append(data.value(forKey: "desc") as! String)
                imageBaru.append(data.value(forKey: "image") as! NSData)
                idnewsBaru.append(data.value(forKey: "newsid") as! Int64)
                usernameBaru.append(data.value(forKey: "userid") as! String)
            }
            tvNews.reloadData()
        }catch {
            print("You have an error")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleBaru.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        print("hallo ")
        titletemp = titleBaru[indexPath.row]
        desctemp = descBaru[indexPath.row]
        imagetemp = UIImage(data: imageBaru[indexPath.row] as! Data)
        usernametemp = usernameBaru[indexPath.row]
        newsidtemp = idnewsBaru[indexPath.row]
        performSegue(withIdentifier: "detailsegue", sender: self)
    }
    
    @IBAction func unwindToReturnhome(_ unwindSegue: UIStoryboardSegue) {
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewsTableViewCell
                cell.titleNews.text = titleBaru[indexPath.row]
                cell.descNews.text = descBaru[indexPath.row]
                cell.backgroundImageNews?.image = UIImage(data: imageBaru[indexPath.row] as! Data)
    
                cell.newsid.isHidden = true
                cell.userid.isHidden = true
                cell.userid.text = usernameBaru[indexPath.row]
                cell.newsid.text = "\(idnewsBaru[indexPath.row])"
        
                return cell
    }
    
    @IBAction func btnadd(_ sender: Any) {
        flag = "add"
        performSegue(withIdentifier: "addupdate", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addupdate"{
            if let nav = segue.destination as? UINavigationController,
                let destination = nav.topViewController as? AddUpdateViewController{
                destination.usernameUser = username
            }
        }
        else if segue.identifier == "detailsegue"{
            if let nav = segue.destination as? UINavigationController,
                let destination = nav.topViewController as? DetailViewController{
                
                destination.titleDetail = titletemp
                destination.descriptionDetail = desctemp
                destination.imageDetail = imagetemp
                destination.usernameDetail = usernametemp
                destination.usernameCompare = username
                destination.newsidDetail = newsidtemp
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
        
    }
}
