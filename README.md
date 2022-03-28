#  RealmExample
An example App for exploring [realm.io](https://realm.io/) in combination with SwiftUI.

## Steps
- Add [real-swift](https://github.com/realm/realm-swift) as package dependency.

## Learnings
### Realm
- Realm by MongoDB, is an application on top of a [MongoDB Atlas database](https://www.mongodb.com/atlas).

### @StateObject vs @ObservedObject
- By using @StateObject in a view, the view is the owner of the observed object and stores this object somewhere else.
When the view redraws, this object won't be re-initialized and thus keeps its state.
- By using @ObservedObject in a view, the view is not the owner of the observed object and only gets a copy of whom ever
injects it into this view. When the view redraws, the observed object is the re-initialized.
-> see [@StateObject vs. @ObservedObject: The differences explained](https://www.avanderlee.com/swiftui/stateobject-observedobject-differences/)
- Use @State for very simple data like Int, Bool, or String. Think situations like whether a toggle is on or off, or whether a dialog is open or closed.
- Use @StateObject to create any type that is more complex than what @State can handle. Ensure that the type conforms to ObservableObject, and has @Published wrappers on the properties you would like to cause the view to re-render, or you’d like to update from a view. Always use @StateObject when you are instantiating a model.
- Use @ObservedObject to allow a parent view to pass down to a child view an already created ObservableObject (via @StateObject).
- Use @EnvironmentObject to consume an ObservableObject that has already been created in a parent view and then attached via the view’s environmentObject() view modifier.
-> [source](https://purple.telstra.com/blog/swiftui---state-vs--stateobject-vs--observedobject-vs--environme)
- [What’s the difference between @StateObject and @ObservedObject?](https://www.donnywals.com/whats-the-difference-between-stateobject-and-observedobject/)
- [Deciding when to use @State, @Binding, @StateObject, @ObservedObject, and @EnvironmentObject](https://swiftuipropertywrappers.com/)
- [What’s the difference between @ObservedObject, @State, and @EnvironmentObject?](https://www.hackingwithswift.com/quick-start/swiftui/whats-the-difference-between-observedobject-state-and-environmentobject)

### Actors (eg. @MainActor)
- [Nonisolated and isolated keywords](https://www.avanderlee.com/swift/nonisolated-isolated/)
- Actors in Swift are a great way to synchronize access to a shared mutable state. In some cases, however, we want to control actor isolation as we might be sure immutable state is accessed only. By making use of the nonisolated and isolated keywords, we gain precise control over actor isolation.
- Initializers are not async. Therefore we have to write our own init.
    - [Stored Property Isolation](https://github.com/apple/swift-evolution/blob/main/proposals/0327-actor-initializers.md#stored-property-isolation)

## TODO's
- LoginView -> AuthenticationManager(): I haven't found a solution yet for the error in Swift 5.6: "Expression requiring global actor 'MainActor' cannot appear in default-value expression of property '_authManager'; this is an error in Swift 6"
    - [Is this a possible solution?](https://stackoverflow.com/questions/71396296/how-do-i-fix-expression-requiring-global-actor-mainactor-cannot-appear-in-def)
