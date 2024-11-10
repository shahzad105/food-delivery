import 'package:flutter/material.dart';
import 'package:food_delivery_ui/data/data.dart';
import 'package:food_delivery_ui/models/order.dart';

class RecentOrders extends StatelessWidget {
  const RecentOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Orders',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: 120,
            child: ListView.builder(
              scrollDirection:
                  Axis.horizontal, // Horizontal scroll for recent orders
              itemCount: currentUser.orders?.length ?? 0, // Safely handle null
              itemBuilder: (BuildContext context, int index) {
                Order order = currentUser
                    .orders![index]; // Non-nullable access after null check
                return _buildRecentOrder(context, order);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentOrder(BuildContext context, Order order) {
    return Container(
      height: 120,
      margin: EdgeInsets.all(10),
      width: 310,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(width: 1.0, color: Colors.grey[200]!),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image(
              height: 100,
              width: 100,
              image: AssetImage(
                order.food?.imageUrl ?? 'assets/images/default_food.png',
              ),
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Food Name
                  Text(
                    order.food?.name ?? "Food name", // Default name if null
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1, // Prevent overflow for long food names
                  ),
                  // Restaurant Name
                  Text(
                    order.restaurant?.name ??
                        "Restaurant", // Default name if null
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),

                  Text(
                    order.date ?? "Date", // Default date if null
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1, // Prevent overflow for the date
                  ),
                ],
              ),
            ),
          ),
          // Add to Cart Button or any other action
          Container(
            margin: EdgeInsets.only(right: 20),
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: IconButton(
              icon: Icon(Icons.add, color: Colors.white),
              onPressed: () {
                // Handle the button press (e.g., add to cart, etc.)
                // You can implement the action here
              },
            ),
          ),
        ],
      ),
    );
  }
}
