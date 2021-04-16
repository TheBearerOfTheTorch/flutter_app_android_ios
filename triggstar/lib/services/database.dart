import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:triggstar/models/dbUser.dart';

class DatabaseService{
  final String uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference userCollection = Firestore.instance.collection('users');

  Future<void> updateUserData(String firstname,String lastname,String email,
      String number,String password) async
  {
    return await userCollection.document(uid).setData(
        {'firstname':firstname,'lastname':lastname,'email':email,
          'number':number,'password':password}
          );
  }
  //users list from snap
  List<DBuser> _userListFromSnapshot(QuerySnapshot snapshot)
  {
    return snapshot.documents.map((doc) {
      return DBuser(
        firstname: doc.data['firstname']??'',
        lastname: doc.data['lastname']??'',
        email: doc.data['email']??'',
        number: doc.data['number']??0
      );
    }).toList();
  }
  //get users stream
  Stream<List<DBuser>> get users{
    return userCollection.snapshots().map(_userListFromSnapshot);
  }
}