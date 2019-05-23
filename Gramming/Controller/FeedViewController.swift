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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Custom
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = tableView.bounds.height * 0.65
        tableView.backgroundColor = UIColor(red: 207/255, green: 216/255, blue: 220/255, alpha: 1.0)
    }
    
    // MARK: - UITableViewDataSource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "FeedTableCell", for: indexPath) as! FeedTableCell
    }
    
    @IBAction func signOutButtonPressed(_ sender: Any) {
        KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        print("ID removed from keychain")
        try! Auth.auth().signOut()
        performSegue(withIdentifier: "backToSignIn", sender: nil)
    }
}
