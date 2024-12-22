import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purnomerchant/constants/themecolors.dart';
import 'package:purnomerchant/screens/Account%20and%20Setting/setting.dart';
import 'package:purnomerchant/screens/Cart/Cart.dart';
import 'package:purnomerchant/screens/Customers/customers.dart';
import '../../models/product.dart';
import '../../services/authService.dart';
import '../../services/cartService.dart';
import '../../widgets/navDrawer.dart';
import '../Account and Setting/account.dart';
import '../Inventory/products.dart';
import 'hometab.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>  with SingleTickerProviderStateMixin{

  late TabController _tabController;
  int _currentIndex = 0; // Track the selected index for the bottom navigation
  final AuthService authService = Get.put(AuthService());
  // List of items for bottom navigation bar

  List<Product> productList = [
    Product(
      productName: 'Imported Russian Diet Coke',
      price: 500.0,
      sku: '35001202',
      gtn: '20221202',
      stock: 50.0,
      unitType: 'pieces',
      description: 'Imported Russian Diet Coke in a can.',
      productImage: 'https://firebasestorage.googleapis.com/v0/b/purno-7e189.firebasestorage.app/o/Screenshot%202024-12-22%20at%2010.56.11%E2%80%AFPM.png?alt=media&token=533662df-b19d-4d98-8f16-e8a530812f68',
      category: 'Beverages',
      businessID: ""
    ),
    Product(
      productName: 'Deshi Shagor Bananas',
      price: 200.0,
      sku: '35001203',
      gtn: '20221203',
      stock: 100.0,
      unitType: 'kg',
      description: 'Fresh and ripe Deshi Shagor Bananas.',
      productImage: 'https://firebasestorage.googleapis.com/v0/b/purno-7e189.firebasestorage.app/o/Screenshot%202024-12-22%20at%2010.56.11%E2%80%AFPM.png?alt=media&token=533662df-b19d-4d98-8f16-e8a530812f68',
      category: 'Fruits & Vegetables',
        businessID: ""
    ),
    Product(
      productName: 'Imported Organic Swedish Apples',
      price: 200.0,
      sku: '35001204',
      gtn: '20221204',
      stock: 30.0,
      unitType: 'kg',
      description: 'Fresh organic Swedish apples.',
      productImage: 'https://firebasestorage.googleapis.com/v0/b/purno-7e189.firebasestorage.app/o/Screenshot%202024-12-22%20at%2010.56.11%E2%80%AFPM.png?alt=media&token=533662df-b19d-4d98-8f16-e8a530812f68',
      category: 'Fruits & Vegetables',
        businessID: ""
    ),
    Product(
      productName: 'Walton HS-15 Professional Juicer',
      price: 5200.0,
      sku: '35001205',
      gtn: '20221205',
      stock: 20.0,
      unitType: 'pieces',
      description: 'Professional juicer with multiple speed settings.',
      productImage: 'https://firebasestorage.googleapis.com/v0/b/purno-7e189.firebasestorage.app/o/Screenshot%202024-12-22%20at%2010.56.11%E2%80%AFPM.png?alt=media&token=533662df-b19d-4d98-8f16-e8a530812f68',
      category: 'Electronics',
        businessID: ""
    ),
    Product(
      productName: 'Red Grapes',
      price: 100.0,
      sku: '35001206',
      gtn: '20221206',
      stock: 75.0,
      unitType: 'kg',
      description: 'Fresh and sweet red grapes.',
      productImage: 'https://firebasestorage.googleapis.com/v0/b/purno-7e189.firebasestorage.app/o/Screenshot%202024-12-22%20at%2010.56.11%E2%80%AFPM.png?alt=media&token=533662df-b19d-4d98-8f16-e8a530812f68',
      category: 'Fruits & Vegetables',
        businessID: ""
    ),
    Product(
      productName: 'Malaysian Oranges',
      price: 320.0,
      sku: '35001207',
      gtn: '20221207',
      stock: 60.0,
      unitType: 'kg',
      description: 'Juicy and sweet Malaysian oranges.',
      productImage: 'https://firebasestorage.googleapis.com/v0/b/purno-7e189.firebasestorage.app/o/Screenshot%202024-12-22%20at%2010.56.11%E2%80%AFPM.png?alt=media&token=533662df-b19d-4d98-8f16-e8a530812f68',
      category: 'Fruits & Vegetables',
        businessID: ""
    ),
  ];

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this); // 3 tabs
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _children = [
      Home(productList: productList),
      OrdersScreen(),
      ScanScreen(),
      MoreScreen(),
    ];

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text('Home', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          bottom: _currentIndex==0? TabBar(
            controller: _tabController,
            indicatorColor: Colors.purple, // Highlight color for selected tab
            indicatorWeight: 3.0, // Make the indicator thicker
            labelColor: Colors.purple, // Text color for selected tab
            unselectedLabelColor: Colors.grey, // Text color for unselected tabs
            tabs: const [
              Tab(text: 'Products'),
              Tab(text: 'Categories'),
              Tab(text: 'Keypad'),
            ],
          ) : null,
          actions: [
            IconButton(onPressed: (){
              Get.to(Cart());
            }, icon: const Icon(Icons.shopping_cart, color: light_purple))
          ],
        ),
        drawer: Drawer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Drawer Header
              UserAccountsDrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                accountName: Container(
                  width: 200,
                  child: Text(
                    authService.user!.fullName,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),
                ),
                accountEmail: Text(authService.user!.emailAddress, style: const TextStyle(color: Colors.grey)), // You can add email here if needed
                currentAccountPicture: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.purple,
                    child: Text(
                      authService.user!.fullName[0], // Your app's logo or a character
                      style: const TextStyle(
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              // Drawer Body
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    // Drawer Item 1
                    ListTile(
                      leading: const Icon(Icons.store),
                      title: const Text('Inventory'),
                      onTap: () {
                        Get.to(InventoryProducts());
                      },
                    ),
                    // Drawer Item 2
                    ListTile(
                      leading: const Icon(Icons.assignment),
                      title: const Text('Orders'),
                      onTap: () {
                        // Handle navigation for Orders
                      },
                    ),
                    // Drawer Item 3
                    ListTile(
                      leading: const Icon(Icons.person),
                      title: const Text('Customers'),
                      onTap: () {
                        Get.to(CustomersPage());
                      },
                    ),
                    // Drawer Item 4
                    ListTile(
                      leading: const Icon(Icons.help),
                      title: const Text('Support'),
                      onTap: () {
                        // Handle navigation for Support
                      },
                    ),
                    // Drawer Item 5
                    ListTile(
                      leading: const Icon(Icons.account_circle),
                      title: const Text('Account'),
                      onTap: () {
                        Get.to(Account());
                      },
                    ),
                    // Drawer Item 6
                    ListTile(
                      leading: const Icon(Icons.settings),
                      title: const Text('Settings'),
                      onTap: () {
                        Get.to(Settings());
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index; // Update the selected index
          });
        },
        selectedItemColor: Colors.purple, // Color for selected icon
        unselectedItemColor: Colors.grey, // Color for unselected icons
        showUnselectedLabels: true, // Display labels for unselected items
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.center_focus_strong), // Scan icon
            label: 'Scan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
        ],
      ),
    );
  }
}


// Sample screens for navigation (you can replace these with your actual screens

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Orders Screen'));
  }
}

class ScanScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Icon(Icons.qr_code_scanner, size: 100, color: Colors.purple));
  }
}

class MoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('More Screen'));
  }
}