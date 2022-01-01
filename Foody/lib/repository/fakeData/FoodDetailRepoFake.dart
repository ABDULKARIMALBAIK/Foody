import 'package:foody/model/modelFake/Spice.dart';

class FoodDetailRepoFake{

  List<Spice> getSpices(){

    List<Spice> spices = [];
    spices.add(Spice(1,"Cumin",10));
    spices.add(Spice(2,"Ground ginger",12));
    spices.add(Spice(3,"Nutmeg",15));
    spices.add(Spice(4,"Powder ginger",10));
    spices.add(Spice(5,"Chili powder",5));
    spices.add(Spice(6,"Hot-red-chili-flakes",8));
    spices.add(Spice(7,"Smoked paprika",10));
    spices.add(Spice(8,"dill",4));
    spices.add(Spice(1,"chives",8));

    return spices;
  }
}