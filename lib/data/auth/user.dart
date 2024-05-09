import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
part 'user.g.dart';

@HiveType(typeId: 1)
class User extends Equatable{
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String? username;
  @HiveField(2)
  final String? email;
  @HiveField(3)
  final String? photoUrl;

  const User({required this.id,this.username,this.email,this.photoUrl});

  static const empty =  User(id: '',username: '');

  bool get isEmpty => this == User.empty;
  bool get isNotEmpty => this != User.empty;

  @override
  // TODO: implement props
  List<Object?> get props => [id,username,email,photoUrl];

}