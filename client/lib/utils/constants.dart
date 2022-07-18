import 'package:dart_meteor/dart_meteor.dart';
import '../app/modules/home_controller.dart';
import '../app/modules/repositories/home/home_repository_meteor.dart';
class Constants {
  static var currentcontroller = HomeController(HomeRepositoryMeteor());
  //static var currentcontroller = HomeController(HomeRepositoryImpl());
  static var connection = MeteorClient.connect(url: 'http://192.168.15.36:3000/');
}
