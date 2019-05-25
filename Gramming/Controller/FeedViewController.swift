//
//  FeedViewController.swift
//  Gramming
//
//  Created by SB on 5/20/19.
//  Copyright © 2019 SB. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting up table view delegate, data source and customizing
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = tableView.bounds.height * 0.65
        tableView.backgroundColor = UIColor(red: 207/255, green: 216/255, blue: 220/255, alpha: 1.0)
        
        // Data service listener
        
        DataService.dataService.REF_POSTS.observe(.value, with: { (snapshot) in
            if let snapshotAll = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshotAll {
                    print("Snap: \(snap)")
                    
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let post = Post(postKey: key, postData: postDict)
                        self.posts.append(post)
                    }
                }
            }
            self.tableView.reloadData()
        })
    }
    
    // MARK: - UITableViewDataSource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedTableCell", for: indexPath) as! FeedTableCell
        cell.update(post: posts[indexPath.row])
        
        return cell
    }
    
    @IBAction func signOutButtonPressed(_ sender: Any) {
        KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        print("ID removed from keychain")
        try! Auth.auth().signOut()
        performSegue(withIdentifier: "backToSignIn", sender: nil)
    }
}
