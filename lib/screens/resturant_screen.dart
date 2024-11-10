import 'package:flutter/material.dart';
import 'package:food_delivery_ui/models/food.dart';
import 'package:food_delivery_ui/models/restaurant.dart';
import 'package:food_delivery_ui/widgets/rating_star.dart';

class RestaurantScreen extends StatefulWidget {
  final Restaurant restaurant;

  const RestaurantScreen({super.key, required this.restaurant});
  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Hero(
                  tag: widget.restaurant.imageUrl.toString(),
                  child: Image.asset(
                    widget.restaurant.imageUrl.toString(),
                    height: 220,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back_ios),
                        iconSize: 30,
                        color: Colors.white,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.favorite),
                        iconSize: 30,
                        color: Theme.of(context).primaryColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.restaurant.name.toString(),
                        style: TextStyle(
                          fontSize: 22,
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "0.3 miles away",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  RatingStar(rating: widget.restaurant.rating ?? 5),
                  SizedBox(height: 6),
                  Text(
                    widget.restaurant.address ?? "Address",
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          foregroundColor: Colors.white,
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 5,
                        ),
                        child: Text(
                          "Reviews",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          foregroundColor: Colors.white,
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 5,
                        ),
                        child: Text(
                          "Contact",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Menu',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 400,
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                children:
                    List.generate(widget.restaurant.menu!.length, (index) {
                  Food food = widget.restaurant.menu![index];
                  return BuildMenuItems(food: food);
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BuildMenuItems extends StatelessWidget {
  final Food food;

  const BuildMenuItems({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          // The image container with a fixed height and width
          Container(
            height: 170,
            width: 170, // Ensures consistency with the height
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: AssetImage(food.imageUrl ?? ""),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // The gradient overlay on top of the image
          Container(
            height: 170,
            width: 170,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.black.withOpacity(0.3),
                  Colors.black45.withOpacity(0.3),
                  Colors.black26.withOpacity(0.3),
                ],
                stops: [0.1, 0.4, 0.6],
              ),
            ),
          ),
          // Text overlay for the food name and price
          Positioned(
            top: 45,
            left: 0,
            right: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  food.name ?? "Food Name", // Displaying food name
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 5),
                Text(
                  "\$${food.price?.toStringAsFixed(2) ?? '0.00'}", // Displaying price
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          // Add to cart button in the bottom-right corner
          Positioned(
            bottom: 8,
            right: 8,
            child: TextButton(
              onPressed: () {
                // Handle add to cart functionality
              },
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                shape: CircleBorder(),
                padding: EdgeInsets.all(10),
                elevation: 5,
              ),
              child: Icon(
                Icons.add_shopping_cart, // Button icon
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
