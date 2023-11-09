import 'package:music_mates_app/data/model/user_model.dart';

class UserList {
  final List<UserModel> users;

  UserList.musicMatesJson(Map<String, dynamic> data)
      : users = (data["musicMates"] as List)
            .map((e) => UserModel.fromJson(e))
            .toList();
}
