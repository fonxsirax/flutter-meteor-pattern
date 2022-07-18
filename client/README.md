# arquiteturadesoftware

      This project was developed with the aim of promoting a good style of programming, so that several people can work together on the same project and the expected result will be the desired.

## Getting Started

      This is the Client Part of flutter-meteor-pattern to find the server part go to .../server/

## Routes and Navigation
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
 
 The CreateModelForm script was used to create and edit PostModels (our struct), it receives a callback Function which will designate the result of the form.
 We call this script from Navigation for Create and for Edit we just use a simple modal:
 ```dart
   _openEditPostModelModal(BuildContext context, id) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return CreateModelForm(_submitForm, id);
        });
  }
``` 
An interesting thing about this proposal is that all Crud methods are written on HomePage but we want to pass then to be executed after CreateModelForm creates a form.

 
 ## Pattern
      Our app uses modular pattern and the repository was organize into: Components, Models, Pages, Repositories, Utils.
In Constants we define which connection we should stablish and the current controller used, for example, if i and to mock the controller with other objects that we have on meteor, we could easily change the current Controller with something like:
 
 
 ~~currentcontroller = HomeController(HomeRepositoryMeteor());~~
 **static var currentcontroller = HomeController(HomeRepositoryImpl());**
 
 Note that in setUp test we could do something like that:
   setUp(() {
    Constants.currentcontroller = HomeController(HomeRepositoryImpl());
  });
  
  In this case we have a guarantee that the test will reproduce something expected.
  
  
To achieve this in the CRUD we create a abstract class for HomeRepository
```dart
abstract class HomeRepository {
  Future<List<PostModel>> getPosts();
}
```    
and implements few ways to fill HomeRepository
```dart
//EMPTY REPO EXAMPLE
class HomeRepositoryEmpty implements HomeRepository {
  @override
  Future<List<PostModel>> getPosts() {
    return Future(() => []);
  }
}
//MOCK EXAMPLE
class HomeRepositoryImpl implements HomeRepository {
  @override
  Future<List<PostModel>> getPosts() async {
    await Future.delayed(Duration(seconds: 5));
    return List.generate(
        3,
        (index) => PostModel(
            tittle: "Tittle $index",
            description: "Description $index",
            id: index.toString()
        ));
  }
}
//METEOR EXAMPLE
class HomeRepositoryMeteor implements HomeRepository {
  @override
  Future<List<PostModel>> getPosts() async {
    List<PostModel> recoveredPosts = [];
    var snapshot = [];
    snapshot = await Constants.connection.call('getAllPosts');
    print("tamanho do snapshot = ${snapshot.length}");

    for (int i = 0; i < snapshot.length; i++) {
      var post = PostModel(
          tittle: snapshot[i]["tittle"],
          description: snapshot[i]["description"],
          date: snapshot[i]["createdAt"].toString(),
          id: snapshot[i]["_id"]);
      recoveredPosts.add(post);
    }
    return recoveredPosts;
  }
}
``` 
## Testing
Unit tests are handy for verifying the behavior of a single function, method, or class. The test package provides the core framework for writing unit tests, and the flutter_test package provides additional utilities for testing widgets.
For example we can use Unit test to check if my mock are working correctly:
```dart
main(){
  HomeController controller = HomeController(HomeRepositoryImpl());

  setUp(() => {
    controller = HomeController(HomeRepositoryImpl())
  });

  group("Testando meu mock", () {
    test("Posts is empty", () {
      expect(controller.posts, isEmpty);
    });

    test("Posts is not empty", () async {
      await controller.getPosts();
      final posts = controller.posts;
      expect(posts.length, 10);
      expect(posts[0].tittle, "Tittle 0");
    });
  });
}
```  
Widget Tests are used to test widget, lets test our Home Page
```dart
main() {
  setUp(() {
    Constants.currentcontroller = HomeController(HomeRepositoryImpl());
  });

  group("Home Page Test", ()  {
    testWidgets("Home Page - Click and load, edit", (tester) async {//
      await tester.pumpWidget(MaterialApp(
          home: HomePage()
      ));
      expect(find.text('Home Page'), findsOneWidget);
      await tester.pumpAndSettle();
      //expect(find.byType(CircularProgressIndicator), findsOneWidget);
      //await tester.pumpAndSettle();
      expect(find.byType(ListTile), findsNWidgets(3));

      await tester.tap(find.byKey(Key('1')));

      await tester.pumpAndSettle();
      expect(find.text("Descrição"), findsOneWidget);
      expect(find.text("Título do post"), findsOneWidget);
      expect(find.text("Publicar"), findsOneWidget);
    });//

    testWidgets("Home Page - Click and load, add", (tester) async {//
      await tester.pumpWidget(MaterialApp(
          home: HomePage(),
          routes: {
            AppRoutes.POST_CREATE: (ctx) => const CreateModelPage(),
          },
      ));
      expect(find.text('Home Page'), findsOneWidget);
      await tester.pumpAndSettle();
      //expect(find.byType(CircularProgressIndicator), findsOneWidget);
      //await tester.pumpAndSettle();
      expect(find.byType(ListTile), findsNWidgets(3));

      await tester.tap(find.byKey(const Key('add')));

      await tester.pumpAndSettle();
      expect(find.text('Criar novo post'), findsOneWidget);
      expect(find.text("Título do post"), findsOneWidget);
      expect(find.text("Publicar"), findsOneWidget);
    });//
  });
}
```  

      
## Conclusion
- We showed how simple it can be to an app in flutter communicate with the meteor. 
- We created a CRUD and an efficient way to organize and test the app with Modular.
- We use Navigation efficiently

