# Gramming

This is a simple iOS app for social networking.

## Getting Started

This app uses Firebase to run a social networking app.

## App Walkthrough GIF

## Lessons Learned
1. The method **viewDidLoad()** cannot perform segue, instead call segues inside **viewDidAppear(_:)**.
2. A view's frame data is not available in **awakeFromNib()** where the view object has only been initialized. Thus, accessing frame data, i.e. for purposes like modifying **layer.cornerRadius** property, must be done in **layoutSubviews()** method.
3. *Keychain* is a specialized database by Apple which is used to manage passwords, store metadata and other sensitive information. Apple provides a wrapper to allow for interaction with *Keychain*called **GenericKeychain**. However, third-party wrappers that are friendlier to use also exist, e.g. **SwiftKeychainWrapper** pod.
4. Firebase uses NoSQL database. Instead of existing in tables of relational database, data is stored as JSON object. [Click to learn more](https://firebase.google.com/docs/database/web/structure-data)
5. It is a good idea to flatten the structure of the data on Firebase. To keep flatten means to have less nesting of data and this helps with grabbing only data that's needed. All the children of a root object are pulled when accessed.
6. When attempting to access a child member of a parent, if the child does not exist, Firebase will automatically create it with the provided unique ID.
7. The **updateChildValues()** method only updates the values for specified keys without overwriting other keys. On the other hand, **setValue()** will wipe out any existing key-value data and overwrite it with new ones.
8. When using a **UITapGestureRecognizer** instance on a view object, such as a **UIImageView** instance, make sure to set it's **userInteractionEnabled** property to **true**.
9. You can use listeners for Firebase database to detect any changes in values for a parent node.
10. When not passing in a value for an argument to an instance's method, declare the value's parameter to be an optional type with nil as a default value. For example, `func update(post: Post, image? UIImage? = nil)` can be called as `someInstance.update(post: somePost)` for a cleaner look.
11. Saving a user's data can be done when both downloading and uploading files. For example, after downloading an image to display for the first time, implement caching with **NSCache** to retrieve the image for subsequent uses without having to redownload. When uploading, use data compression features, such as `image.jpegData(compressionQuality: 0.2)` for images.
