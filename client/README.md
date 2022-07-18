# arquiteturadesoftware

A new Flutter project.

## Getting Started

Our app uses modular pattern so the repository was organize into: Components, Models, Pages, Repositories, Utils

In app Widget we have two routes, 
```dart
      routes: {
        AppRoutes.AUTH_OR_HOME: (ctx) => const AuthOrHomePage(),
        AppRoutes.POST_CREATE: (ctx) => const CreateModelPage(),
      }
```

      
      
 One to autentication and other for Crud with meteor.
 In the autentication we use a StreamBuilder to return the correct path depending on if the server has a good connection and if the user has already log in.
 In the Crud we have a simple Scaffold with a list of the registered objects, and a button to register more.
 Note that in Constants we define which connection we should stablish and the current controller used, for example, if i and to mock the controller with other objects that we have on meteor, we could easily change the current Controller with something like:
 
 ~~currentcontroller = HomeController(HomeRepositoryMeteor());~~
 **static var currentcontroller = HomeController(HomeRepositoryImpl());**
 
 Note that in setUp test we could do something like that:
   setUp(() {
    Constants.currentcontroller = HomeController(HomeRepositoryImpl());
  });
  
  In this case we have a garantier that the test will reproduce something expected
      
## Navigation
