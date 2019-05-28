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

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var addImageView: CircularImageView!
    @IBOutlet var captionTextField: CustomTextField!
    
    var posts = [Post]()
    var imagePicker: UIImagePickerController!
    static var imageCache = NSCache<NSString, UIImage>()
    var imageSelected = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting up table view delegate, data source and customizing
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = tableView.bounds.height * 0.65
        tableView.backgroundColor = UIColor(red: 207/255, green: 216/255, blue: 220/255, alpha: 1.0)
        
        // Image picker controller initialization
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        // Data service listener
        
        DataService.dataService.REF_POSTS.observe(.value, with: { (snapshot) in
            if let snapshotAll = snapshot.children.allObjects as? [DataSnapshot] {
                // Removing all posts from local array since the for loop adds all the posts from Firebase
                // This is avoid re-adding existing posts
                self.posts.removeAll()
                for snap in snapshotAll {
                    print("Snap: \(snap)")
                    
                    if let postDict = snap.value as? Dictionary<String, Any> {
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
        
        let post = posts[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FeedTableCell", for: indexPath) as? FeedTableCell {
            
            if let image = FeedViewController.imageCache.object(forKey: post.imageURL as NSString) {
                cell.update(post: posts[indexPath.row], image: image)
                return cell
            } else {
                cell.update(post: posts[indexPath.row])
                return cell
            }
        } else {
            return FeedTableCell()
        }
    }
    
    // MARK: - UIImagePickerControllerDelegate methods
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            addImageView.image = image
            imageSelected = true
        } else {
            print("A valid image wasn't selected!")
            imageSelected = false
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    @IBAction func addImageTapped(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func signOutButtonPressed(_ sender: Any) {
        KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        print("ID removed from keychain")
        try! Auth.auth().signOut()
        performSegue(withIdentifier: "backToSignIn", sender: nil)
    }
    
    @IBAction func postButtonTapped(_ sender: Any) {
        guard let caption = captionTextField.text, caption != "" else {
            print("Error posting: A caption must be entered!")
            return
        }
        
        guard let image = addImageView.image, imageSelected == true else {
            print("Error posting: An image must be selected!")
            return
        }
        
        if let imageData = image.jpegData(compressionQuality: 0.2) {
            
            let imageUID = UUID().uuidString
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            
            let imageStorageItem = DataService.dataService.REF_POST_IMAGES.child(imageUID)
            imageStorageItem.putData(imageData, metadata: metadata) { (metadata, error) in
                if error != nil {
                    print("Unable to upload to Firebase Storage: \(String(describing: error))")
                } else {
                    print("Successfully uploaded to Firebase Storage!")
                    imageStorageItem.downloadURL(completion: { (url, error) in
                        if error != nil {
                            print("Unable to get the download URL for uploaded image!")
                        } else {
                            if url != nil {
                                if let downloadURL = url?.absoluteString {
                                    self.postToFirebase(imageURL: downloadURL)
                                }
                            }
                        }
                    })
                }
            }
        }
    }
    
    func postToFirebase(imageURL: String) {
        let post: Dictionary<String, Any> = [
            "caption": captionTextField.text!,
            "imageURL": imageURL,
            "likes": 0
        ]
        
        let firebasePost = DataService.dataService.REF_POSTS.childByAutoId()
        firebasePost.setValue(post)
        
        captionTextField.text = ""
        imageSelected = false
        addImageView.image = UIImage(named: "add-image")
    }
    
}
