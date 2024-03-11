import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreHandler {
  // Function to save data to Firestore
  Future<void> saveDataToFirestore(
      String collection, Map<String, dynamic> data) async {
    try {
      await FirebaseFirestore.instance.collection(collection).add(data);
      print('Data saved to Firestore successfully!');
    } catch (e) {
      print('Error saving data to Firestore: $e');
    }
  }

  //Function to delete collection from firestore
  Future<void> deleteCollection(String collectionName) async {
    var collectionRef = FirebaseFirestore.instance.collection(collectionName);

    var querySnapshot = await collectionRef.get();
    for (var documentSnapshot in querySnapshot.docs) {
      await documentSnapshot.reference.delete();
    }

    print('Collection deleted: $collectionName');
  }

  // Function to get data from Firestore
  Future<List<Object?>> getDataFromFirestore(String? collection) async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection(collection!).get();

      List<Object?> dataList = querySnapshot.docs
          .map((QueryDocumentSnapshot snapshot) => snapshot.data())
          .toList();
      for (var element in dataList) {
        print("----> ${element}");
      }

      return dataList;
    } catch (e) {
      print('Error getting data from Firestore: $e');
      return [];
    }
  }
}
