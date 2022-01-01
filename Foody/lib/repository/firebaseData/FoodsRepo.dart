import 'package:cloud_firestore/cloud_firestore.dart';

class FoodsRepo {


  Stream<QuerySnapshot> categories(){
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    return _firestore.collection('category').snapshots();
  }

  Stream<QuerySnapshot> bannerData(){

    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    return _firestore.collection('banner').snapshots();  //.limit(1)

  }

  Stream<QuerySnapshot> foods(int foodType){

    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    return _firestore.collection('food').where('category_id' , isEqualTo: foodType).snapshots();  //.limit(1)
  }

  Stream<QuerySnapshot> searchFoods(String foodName){

    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    return _firestore.collection('food')
        .where('name' , isGreaterThanOrEqualTo: foodName)
        .where('name' , isLessThan: foodName + 'z')
        .snapshots();
  }

}