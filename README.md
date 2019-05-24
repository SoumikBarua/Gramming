# Gramming

This is a simple iOS app for social networking.

## Getting Started

This app uses Firebase to run a social networking app.

## App Walkthrough GIF

## Lessons Learned
1. The method **viewDidLoad()** cannot perform segue, instead call segues inside **viewDidAppear(_:)**.
2. A view's frame data is not available in **awakeFromNib()** where the view object has only been initialized. Thus, accessing frame data, i.e. for purposes like modifying **cornerRadius** property, must be done in **layoutSubviews()** method.
3. *Keychain* is a specialized database by Apple which is used to manage passwords, store metadata and other sensitive information. Apple provides a wrapper to allow for interaction with *Keychain*called **GenericKeychain**. However, third-party wrappers that are friendlier to use also exist, e.g. **SwiftKeychainWrapper** pod.
4. Firebase uses NoSQL database. Instead of existing in tables of relational database, data is stored as JSON object. [Click to learn more](https://firebase.google.com/docs/database/web/structure-data)
5. It is a good idea to flatten the structure of the data on Firebase. To keep flatten means to have less nesting of data and this helps with grabbing only data that's needed. All the children of a root object are pulled when accessed.
