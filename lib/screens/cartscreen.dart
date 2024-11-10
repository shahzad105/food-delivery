import 'package:flutter/material.dart';
import 'package:food_delivery_ui/data/data.dart';
import 'package:food_delivery_ui/models/order.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  // This function adds a separator between each item (e.g., a divider)
  Widget separatorBuilder(BuildContext context, int index) {
    return Divider(); // Creates a divider between cart items
  }

  // Calculate total cost of items in the cart
  double getTotalCost() {
    return currentUser.cart?.fold(
            0,
            (sum, order) =>
                sum! + (order.food?.price ?? 0) * (order.quantity ?? 0)) ??
        0;
  }

  @override
  Widget build(BuildContext context) {
    final cartItems = currentUser.cart;

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: Text(
          'Cart (${cartItems?.length ?? 0})', // Dynamically updates the cart count
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      body: cartItems == null || cartItems.isEmpty
          ? Center(
              child: Text(
                "Your cart is empty",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            )
          : ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                if (index < cartItems.length) {
                  Order order = cartItems[index];
                  return CartItemWidget(order: order);
                }
                // This is the footer widget for the total cost
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Cost:",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "\$${getTotalCost().toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                  ],
                );
              },
              separatorBuilder: separatorBuilder,
              itemCount:
                  cartItems.length + 1, // Add 1 for the total cost widget
            ),
      bottomSheet: Container(
        height: 100,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              offset: Offset(0, -1), // Corrected to Offset
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Center(
          child: TextButton(
            onPressed: () {
              // Implement checkout functionality
            },
            child: Text(
              'Check Out',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}

class CartItemWidget extends StatelessWidget {
  final Order order;

  const CartItemWidget({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(right: 10),
            width: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                    order.food?.imageUrl ?? "assets/images/default_image.png"),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                order.food?.name ?? 'Food Name',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                order.restaurant?.name ?? 'Restaurant Name',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.black26, width: .8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "-",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      (order.quantity ?? 0).toString(),
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '+',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Text(
            "\$${(order.food?.price ?? 0).toStringAsFixed(2)}",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
