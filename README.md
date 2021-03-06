# Gramming

This is a simple iOS app for social networking.

## Getting Started

This app uses Firebase to run a simple social networking app. This app utilizes Cocoapods to integrate Firebase SDK libraries. Firebase Authentication is used to allow users to sign-in using either Facebook or email login. Firebase Realtime Database is used to structure data used in the app and finally Firebase Storage is used to upload and download images.

## App Walkthrough GIF

This GIF show the app in action (Facebook and email sign-in options, updates to Firebase Auth and Firebase DB after sign-in, making a post with a caption, displaying the post in the UI, the post data being updated in Firebase DB and uploaded to Firebase Storage, making another post, liking posts, and signing out)

![Gramming Walkthrough](walkthrough.gif)

## Lessons Learned
1. The method **viewDidLoad()** cannot perform segue, instead call segues inside **viewDidAppear(_:)**.
2. A view's frame data is not available in **awakeFromNib()** where the view object has only been initialized. Thus, accessing frame data, i.e. for purposes like modifying **layer.cornerRadius** property, can be done in **layoutSubviews()** method.
3. *Keychain* is a specialized database by Apple which is used to manage passwords, store metadata and other sensitive information. Apple provides a wrapper to allow for interaction with *Keychain* called **GenericKeychain**. However, third-party wrappers that are friendlier to use also exist, e.g. **SwiftKeychainWrapper** pod.
4. Firebase uses NoSQL database. Instead of existing in tables of relational database, data is stored as JSON object. [Click to learn more!](https://firebase.google.com/docs/database/web/structure-data)
5. It is a good idea to flatten the structure of the data on Firebase. To keep data flatten means to have less nesting of data and this helps with grabbing only data that's needed. All the children of a parent node are pulled when that node is accessed.
6. When attempting to access a child member of a parent, if the child does not exist, Firebase will automatically create it with the provided unique ID.
7. The **updateChildValues()** method only updates the values for specified keys without overwriting other keys. On the other hand, **setValue()** will wipe out any existing key-value data and overwrite it with new ones.
8. When using a **UITapGestureRecognizer** instance on a view object, such as a **UIImageView** instance, make sure to set it's **userInteractionEnabled** property to **true**.
9. You can use listeners for Firebase database to detect any changes in values for a parent node.
10. When not passing in a value for an argument to an instance's method, declare the value's parameter to be an optional type with nil as a default value. For example, `func update(post: Post, image UIImage? = nil)` can be called as `someInstance.update(post: somePost)` for a cleaner look.
11. Saving a user's mobile data can be done when both downloading and uploading files. For example, after downloading an image to display for the first time, implement caching with **NSCache** to retrieve the image for subsequent uses without having to redownload. When uploading, use data compression features, such as `image.jpegData(compressionQuality: 0.2)` for images.

## License

    Copyright 2019 Soumik Barua

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
