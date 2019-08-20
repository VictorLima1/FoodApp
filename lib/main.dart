import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/rendering.dart';
import 'package:restaurante_app/bloc/cartListBloc.dart';
import 'package:flutter/services.dart';
import 'package:restaurante_app/model/foodItem.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark));

    return BlocProvider(
      blocs: [
        Bloc((i) => CartListBloc())
      ],
      child: MaterialApp(
        title: "Pizzaria",
        home: Home(),
        debugShowCheckedModeBanner: false,
      )

    );
  }
}

class Home extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: ListView(
            children: <Widget>[
              FirstHalf(),
              SizedBox(height: 45),
              for( var foodItem in fooditemList.foodItems)
                ItemContainer(foodItem: foodItem)
            ],
          ),
        )
      )

    );
  }
}

class ItemContainer extends StatelessWidget{
  final FoodItem foodItem;
  
  ItemContainer({@required this.foodItem});

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: (){

      },
      child: Items(
        hotel: foodItem.hotel,
        itemName: foodItem.title,
        itemPrice: foodItem.price,
        imgUrl: foodItem.imgUrl,
        leftAligned: (foodItem.id % 2 == 0) ? true : false
      ),
    );
  }
}

class Items extends StatelessWidget{
  Items({
    @required this.leftAligned,
    @required this.imgUrl,
    @required this.itemName,
    @required this.itemPrice,
    @required this.hotel
  });

  final bool leftAligned;
  final String imgUrl;
  final String itemName;
  final double itemPrice;
  final String hotel;
 
  @override
  Widget build(BuildContext context){
    double containerPadding = 45;
    double containerBoderRadius = 10;

    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            left: leftAligned ? 0 : containerPadding,
            right: leftAligned ? containerPadding : 0,
          ),

          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: ClipRRect(
                  borderRadius: BorderRadius.horizontal(
                    left: leftAligned ? Radius.circular(0) : Radius.circular(containerBoderRadius),
                    right: leftAligned ? Radius.circular(containerBoderRadius) : Radius.circular(0),
                  ),

                  child: Image.network(
                    imgUrl,
                    fit: BoxFit.fitWidth
                  )
                )
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.only(
                  left: leftAligned ? 20: 0,
                  right: leftAligned ? 0 : 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            itemName,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 18
                            )
                          ),
                        ),
                        Text("R\$$itemPrice",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                        
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.black45,
                            fontSize: 15
                          ),
                          children: [
                            TextSpan(text: "ingredientes: "),
                            TextSpan(
                              text: hotel,
                              style: TextStyle(
                                fontWeight: FontWeight.w700
                              )
                            )
                          ]
                        )
                      ),
                    ),
                    SizedBox(height: containerPadding)
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class FirstHalf extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(35, 25, 0, 0),
      child: Column(children: <Widget>[
        CustomAppBar(),
        SizedBox(height: 30),
        title(),
        SizedBox(height: 30),
        searchBar(),
        SizedBox(height: 30),
        categories(),

      ],),
    );
  }
}

Widget categories(){
  return Container(
    height: 185,
    child: ListView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        CategoryListItem(
          categoryIcon: Icons.fastfood,
          categoryName: "Frango",
          avaliability: 12,
          selected: true,
        ),

        CategoryListItem(
          categoryIcon: Icons.fastfood,
          categoryName: "Carne",
          avaliability: 12,
          selected: false,
        ),

        CategoryListItem(
          categoryIcon: Icons.fastfood,
          categoryName: "Porco",
          avaliability: 12,
          selected: false,
        ),

        CategoryListItem(
          categoryIcon: Icons.fastfood,
          categoryName: "Vegetarianas",
          avaliability: 12,
          selected: false,
        ),

        CategoryListItem(
          categoryIcon: Icons.fastfood,
          categoryName: "Miojo",
          avaliability: 12,
          selected: false,
        ),
      ],
    ),
  );
}

Widget searchBar(){
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Icon(
        Icons.search,
        color: Colors.black45,
      ),

      SizedBox(width: 20),

      Expanded(
        child: TextField(
          decoration: InputDecoration(
            hintText: "Procure um sabor ou ingrediente",
            contentPadding: EdgeInsets.symmetric(vertical: 10),
            hintStyle: TextStyle(
              color: Colors.black87
            )
          ),
        ),
      )
    ],
  );
}

Widget title(){
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      SizedBox(width: 45),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Comidinhas", 
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 30,
            ),
          ),

          Text("Gostosas",
            style: TextStyle(
              fontWeight: FontWeight.w200, 
              fontSize: 30
              )
          )
        ],
      )
    ],
  );
}

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(Icons.menu),
          GestureDetector(
            onTap: (){},
            child: Container(
              margin: EdgeInsets.only(right: 30),
              child: Text("0", style: TextStyle(color: Colors.white),),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 111, 97, 100),
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          )
        ],
      )
    );
  }
}

class CategoryListItem extends StatelessWidget{
  final IconData categoryIcon;
  final String categoryName;
  final int avaliability;
  final bool selected;

  CategoryListItem({
    @required this.categoryIcon,
    @required this.categoryName,
    @required this.avaliability,
    @required this.selected
  });

  @override
  Widget build(BuildContext context){
    return Container(
      margin:EdgeInsets.only(right: 20),
      padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: selected ? Color.fromRGBO(255, 111, 97, 100) : Colors.white,
        border: Border.all(
          color: selected ? Colors.transparent : Colors.grey[200],
          width: 1.5 
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[100],
            blurRadius: 15,
            offset:  Offset(25,0),
            spreadRadius: 5
          )
        ]
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                color: selected ? Colors.transparent : Colors.transparent, 
                width: 1.5
              )
            ),
            child: Icon(
              categoryIcon,
              color: Colors.black,
              size: 30,
            ),
          ),

          SizedBox(height: 10),
          Text(
            categoryName,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
            width: 1.5,
            height: 15,
            color: Colors.black26,
          ),
          Text(
            avaliability.toString(),
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black
            )
          )
        ],
      )
    );
  }
}