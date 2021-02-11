//
//  DetailViewController.swift
//  NMCNews(1)
//
//  Created by Yohan on 20/12/20.
//  Copyright © 2020 Harun Fernando. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var txtDescription: UILabel!
    @IBOutlet weak var showedit: UIBarButtonItem!
    @IBOutlet weak var txtUsername: UILabel!
    
    var titleDetail:String?
    var imageDetail: UIImage?
    var descriptionDetail: String?
    var usernameDetail: String?
    var newsidDetail: Int64?
    
    var usernameCompare: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(titleDetail)
        txtTitle.text = titleDetail
        image.image = imageDetail
        txtDescription.text = descriptionDetail
        txtUsername.text = ("By : \(usernameDetail as! String)")
        
        if usernameDetail != usernameCompare{
            self.navigationItem.rightBarButtonItem = nil
        }
        
    }
    
    @IBAction func btnEdit(_ sender: Any) {
        performSegue(withIdentifier: "editsegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nav = segue.destination as? UINavigationController,
            let destination = nav.topViewController as? AddUpdateViewController{
            destination.newsidupdate = newsidDetail
            destination.titleupdate = titleDetail
            destination.descriptionupdate = descriptionDetail
            destination.imageupdate = imageDetail
            flag = "update"
        }
    }
    
}
