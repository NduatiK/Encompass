# Encompass
A wrapper for hypersolo's navigation library – Compass [hyperoslo/Compass](https://github.com/hyperoslo/Compass)



---
# Installation
```ruby
pod 'Encompass', :git => 'https://github.com/NduatiK/Encompass.git'
```
---

## Why even use a navigation library?

_*TL;DR Version*_
True decoupling


When I started out with iOS, Storyboards were everything. IBActions were intuitive, segues so logical and it all felt perfect. But then I would do this:

![](https://raw.githubusercontent.com/nduatik/Encompass/master/Storyboards.png)


It became obvious that segues were chains that strongly coupled my code. Each view controller would have to know the name/type of its neighbours. One change here would break 5 things there...

That's when I came across Compass - hypersolo's central navigation library that promised that my "controllers [would] become agnostic and views stay stupid." So I dove in and it was glorious. 

All that was needed was to declare the routes and their paths	:

```swift
func application(_ application: UIApplication,
                 didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
  Navigator.scheme = "compass"
  Navigator.routes = ["profile:{username}", "login:{username}", "logout"]
  return true
}
```
Then define a handler: 


```swift
Navigator.handle = { [weak self] location in
  let arguments = location.arguments

  let rootController = self?.window.rootViewController as? UINavigationController

  switch location.path {
    case "profile:{username}":
      let profileController = ProfileController(title: arguments["username"])
      rootController?.pushViewController(profileController, animated: true)
    case "login:{username}":
      let loginController = LoginController(title: arguments["username"])
      rootController?.pushViewController(loginController, animated: true)
    case "logout":
      self?.clearLoginSession()
      self?.switchToLoginScreen()
    default: 
      break
  }
}
```
Optionally one could also use Routers to handle the above process.

```swift
struct ProfileRoute: Routable {

  func navigate(to location: Location, from currentController: CurrentController) throws {
    guard let username = location.arguments["username"] else { return }

    let profileController = ProfileController(title: username)
    currentController.navigationController?.pushViewController(profileController, animated: true)
  }
}

// in AppDelegate
let router = Router()
router.routes = [
  "profile:{username}": ProfileRoute(),
  "logout": LogoutRoute()
]

router.navigate(to: location, from: navigationController)


```

And finally, from anywhere in your code, Navigate!

```swift
@IBOutlet func logoutButtonTouched() {
  Navigator.navigate(urn: "logout")
}
```

---

This was great for a while, then I noticed two problem:

- Strings, strings everywhere!

`Navigator.navigate(urn: "logaut")` would fail because of a spelling error and the compiler could not save me. 

- Type safety was absent
To pass data through the navigator one would have to do something like:

```swift
Navigator.navigate(url: url, payload: (firstName: "foo", lastName: "bar"))
```

The payload could be *Any*thing

---

After doing some reading on Mirrors and Enumeration and interacting with the beautiful code powering [Malibu](https://github.com/hyperoslo/Malibu), another [hypersolo](https://github.com/hyperoslo) library, it occurred to me that I could use an enumeration-powered router that would name paths using enum names (which were guaranteed to be unique). Values could be passed using associated types and type safety would be possible when passing values.

---

# How to Use Encompass

Define an enumeration of your routes

```swift


// Must implement RouteConvertible
enum SampleRoutes: RouteConvertible {
    
	// Define a static array of all the routes 
	// you want to be registered
	// For enums with associatedTypes, 
	// you must provide data that will only be used
	// during registration

    static var All: [SampleRoutes] {
        return [
            .notifications,
            .settings,
            .puppyDetails(for: Puppy()),
            .changePuppyName(oldName: "")
       ]
    }
 
	case notifications,
	case settings,
	case puppyDetails(puppy: Puppy()),
	case changePuppyName(oldName: "")

 
    var routeHandler: RouteHandler {
        switch self {
        case .notifications:
            return RouteHandler({ (_, currentController) in
                let notificationVC = // initialize...
				currentController.navigationController?
					.pushViewController(notificationVC, animated: true)
            })
            
        case .settings:
				// same as notifications ...
				
		case .puppyDetails:
            return RouteHandler({ (payload, currentController) in
            // Note that dictionary name matches associated type name
            guard let selectedPuppy = payload["for"]  as? Puppy else { return }
                let puppyDetailsVC = // initialize...
                puppyDetailsVC.puppy = selectedPuppy
				currentController.navigationController?
					.pushViewController(puppyDetailsVC, animated: true)
            })
            
		case .changePuppyName:
            return RouteHandler({ (payload, currentController) in
            // Note that dictionary name matches associated type name
            guard let oldName = payload["oldName"] as? String else { return }
					let changeNameVC = // initialize...
					changeNameVC.puppyName = oldName
					currentController.present(changeNameVC, animated: true)
            })
	}
}


```

Create a router for these routes and register it

```swift
// Somewhere in AppDelegate at launch

Navigator.registerRouter(Encompasser<SampleRoutes>())
            
Navigator.handle = { [weak self] location in

	// Get your top view controller
	let rootController = self?.window.rootViewController as? UINavigationController
  
	Navigator.navigate(to: location, from: currentController)
}
```


And finally, from anywhere in your code, Navigate!

```swift
func showPuppy(puppy: Puppy) {
	SampleRouter.navigate(to: .puppyDetails(for: puppy))
}
```

Todos
---
- 🔲 Unwrap payload arguments automatically - perhaps into a named tuple
- 🔲 Add deeplinking support
- 🔲 Make puppy demo


Author
---

Nduati Kuria

Credits
---

Ideas from [Compass](https://github.com/hyperoslo/Compass) and [Malibu](https://github.com/hyperoslo/Malibu) both by [hypersolo](https://github.com/hyperoslo)


