import 'package:flutter/widgets.dart';

FoodItemList fooditemList = FoodItemList(foodItems: [
  FoodItem(
    id: 1,
    title: "Frango",
    hotel: "frango, mussarela, cebola, catupiry, milho, ervilhas",
    price: 14.49,
    imgUrl: "https://www.hojetemfrango.com.br/wp-content/uploads/2019/01/shutterstock_333724454.jpg"
  ),
  FoodItem(
    id: 2,
    title: "Carne",
    hotel: "carne seca, mussarela, cebola, bacon",
    price: 14.49,
    imgUrl: "https://media-cdn.tripadvisor.com/media/photo-s/0e/5b/c6/ac/pizza-carne-seca.jpg"
  ),
  FoodItem(
    id: 3,
    title: "Vegetariana",
    hotel: "mussarela de búfala, tomate, palmito, parmesão, azeitona, manjericão",
    price: 14.49,
    imgUrl: "https://www.saberviver.pt/wp-content/uploads/2018/04/pizzavegetariana_destaque-618x385.jpg"
  )
]);

class FoodItemList{
  List<FoodItem>  foodItems;

  FoodItemList({@required this.foodItems});
}

class FoodItem{
  int id;
  String title;
  String hotel;
  double price;
  String imgUrl;
  int quantity;

  FoodItem({
    @required this.id,
    @required this.title,
    @required this.hotel,
    @required this.price,
    @required this.imgUrl,
    this.quantity = 1
  });

  void incrementQuantity(){
    this.quantity = this.quantity + 1;
  }

  void decrementQuantity(){
    this.quantity = this.quantity - 1;
  }
}