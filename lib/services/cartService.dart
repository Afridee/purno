import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../models/customer.dart'; // Replace with the actual path to your Customer model
import '../models/customer_order.dart';
import 'authService.dart';
import 'crudService.dart'; // Replace with the actual path to your CustomerOrder model


class CartService extends GetxController {
  final CRUDService crudService = Get.put(CRUDService());
  final AuthService authService = Get.put(AuthService());
  List<OrderProduct> products = [];
  Customer? selectedCustomer;
  bool isLoading = false;

  double get totalPrice => products
      .map((item) => item.price * item.quantity)
      .fold(0, (prev, curr) => prev + curr);

  selectCustomer({required Customer customer}){
    selectedCustomer = customer;
    update();
  }

  clearSelectedCustomer(){
    selectedCustomer = null;
    update();
  }

  addToCart({required OrderProduct product}){
    products.add(product);
    update();
  }

  increaseQty({required int productIndex}){
    products[productIndex].quantity = products[productIndex].quantity + 1;
    update();
  }

  decreaseQty({required int productIndex}){
    if(products[productIndex].quantity==1){
      removeFromCart(productIndex: productIndex);
    }else{
      products[productIndex].quantity = products[productIndex].quantity - 1;
    }
    update();
  }

  removeFromCart({required int productIndex}){
    products.removeAt(productIndex);
    update();
  }

  clearCart(){
    products.clear();
    selectedCustomer = null;
    update();
  }
  
  placeOrder() async{
    isLoading = true;
    update();

    var uuid = const Uuid();
    CustomerOrder order = CustomerOrder(orderId: uuid.v1(), totalAmount: totalPrice, status: "Active", customer: selectedCustomer!, paymentMethod: "", cardDetails: "", cardNetwork: "", posMachineUsed: "", fulfillmentType: "", fulfilledBy: authService.user!.fullName, orderPlacedAt: DateTime.now(), products: products, discount: 0, transactionFee: 0, netPayable: totalPrice, businessID: authService.businesses.first.uid);
    await crudService.createCustomerOrder(order);
    clearCart();

    isLoading = false;
    update();
  }
}