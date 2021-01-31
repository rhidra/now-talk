import 'package:now_talk/scoped_model/auth-model.dart';
import 'package:now_talk/scoped_model/contacts-model.dart';
import 'package:scoped_model/scoped_model.dart';

class MainModel extends Model with AuthModel, ContactsModel {}
