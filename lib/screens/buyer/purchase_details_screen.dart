import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handcrafts/api/controllers/order_api_controller.dart';
import 'package:handcrafts/api/models/order_item.dart';
import 'package:handcrafts/prefs/shared_pref_controller.dart';
import 'package:handcrafts/utils/constants.dart';
import 'package:handcrafts/api/controllers/cart_controller.dart';
import 'package:handcrafts/api/models/cart_model.dart';
import 'package:handcrafts/widgets/small_text.dart';
import 'package:intl/intl.dart';
import '../../api/models/order.dart';
import '../../widgets/all_appBar.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_text_form_field.dart';
import '../../widgets/text_form_label.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PurchaseDetails extends StatefulWidget {
  double? productsPrice;

  PurchaseDetails({Key? key, this.productsPrice}) : super(key: key);

  @override
  State<PurchaseDetails> createState() => _PurchaseDetailsState();
}

class _PurchaseDetailsState extends State<PurchaseDetails> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _addressController;
  late TextEditingController _deliveryTimeController;
  late TextEditingController _deliveryDateController;
  final TextEditingController _payMethodController = TextEditingController(
      text: 'عند الإستلام');

  final CartController _cartController = Get.find();


/*  // String => storeId,  double => storeProductsPrice
  Map<String, double> get totalCartProductsPriceByStore {
    Map<String, double> totalPriceByStore = {};
    Map<String, List<CartModel>> itemsByStore = _cartController
        .getItemsByStore();

    // Loop through the itemsByStore map to calculate the total price for each store
    itemsByStore.forEach((storeId, itemsInStore) {
      double totalPriceForStore = 0;
      for (var item in itemsInStore) {
        totalPriceForStore += item.quantity! * item.price!;
      }
      totalPriceByStore[storeId] = totalPriceForStore;
    });
    return totalPriceByStore;
  }*/

/*  double calculateTotalDeliveryPrice() {
    double totalDeliveryPrice = 0;

    Map<String, double> totalPriceByStore = totalCartProductsPriceByStore;

    // Loop through the totalPriceByStore map and sum up the delivery prices for all stores
    totalPriceByStore.forEach((storeId, totalPrice) {
      double deliveryPriceForStore = calculateDeliveryPriceForStore(storeId);
      totalDeliveryPrice += deliveryPriceForStore;
    });

    return totalDeliveryPrice;
  }*/

  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _addressController = TextEditingController();
    _deliveryTimeController = TextEditingController();
    _deliveryDateController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _addressController.dispose();
    _deliveryTimeController.dispose();
    _deliveryDateController.dispose();
    _payMethodController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: isLoading ?
          SizedBox(
            height: MediaQuery.of(context).size.height, // Occupies full height
            child: Center(
              child: CircularProgressIndicator(
                color: kPrimaryColor,
              ),
            ),
          )
              :Column(
            children: [
              Column(
                children: [
                  AllAppBar(
                    back: true,
                    text: 'شراء',
                    spaceBeforeLogo: 65,
                  ),
                  SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 30.w, right: 30.w, top: 20.h),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            SizedBox(height: 15.h),
                            const TextFormLabel(
                                icon: "assets/icons/address.svg",
                                label: 'العنوان'),
                            SizedBox(height: 5.h),
                            SizedBox(
                              height:100,
                              child: AppTextFormField(
                                controller: _addressController,
                                onChanged: (value) {
                                },
                                maxLines: 3,
                              ),
                            ),
                            SizedBox(height: 22.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      const TextFormLabel(
                                          icon: "assets/icons/calendar.svg",
                                          label: 'تاريخ التوصيل(اختياري)'),
                                      SizedBox(height: 5.h),
                                      AppTextFormField(
                                        controller: _deliveryDateController,
                                        onChanged: (value) {},
                                        hintText: '2023-08-26',
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 18.w,
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      const TextFormLabel(
                                          icon: "assets/icons/time.svg",
                                          label: 'وقت التوصيل(اختياري)'),
                                      SizedBox(height: 5.h),
                                      AppTextFormField(
                                        controller: _deliveryTimeController,
                                        onChanged: (value) {},
                                        hintText: '10:30',
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 22.h),
                            const TextFormLabel(
                                icon: "assets/icons/pay_method.svg",
                                label: 'وسيلة الدفع'),
                            SizedBox(height: 5.h),
                            AppTextFormField(
                              controller: _payMethodController,
                              enabled: false,
                              onChanged: (value) {},
                              maxLines: 1,
                            ),
                            SizedBox(height: 12.h),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 40.h),
              Padding(
                padding: const EdgeInsets.all(10).r,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SmallText(
                          text: 'المجموع',
                          size: 14.sp,
                          color: Colors.grey,
                        ),
                        RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: '${_cartController
                                    .totalCartProductsPrice}',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: kPrimaryColor,
                                ),
                              ),
                              TextSpan(
                                text: ' ₪',
                                style: TextStyle(fontSize: 14.0,
                                  color: kPrimaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SmallText(
                          text: 'التوصيل',
                          size: 14.sp,
                          color: Colors.grey,
                        ),
                        RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: '4',
                                style: TextStyle(fontSize: 20.0,
                                  color: kPrimaryColor,
                                ),
                              ),
                              TextSpan(
                                text: ' ₪',
                                style: TextStyle(fontSize: 14.0,
                                  color: kPrimaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SmallText(
                          text: 'الإجمالي',
                          size: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: '${_cartController
                                    .totalCartProductsPrice + 4}',
                                style: const TextStyle(
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black
                                ),
                              ),
                              const TextSpan(
                                text: ' ₪',
                                style: TextStyle(fontSize: 16.0,
                                    color: Colors.black
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 60.h,
                    ),
                  ],
                ),
              ),
              GetBuilder<CartController>(builder: (controller) {
                return AppButton(
                  onPressed: () async {
                    // double productsPrice = controller.totalCartProductsPrice;
                    // List<CartModel> products = controller.getItems;
                    await confirmOrder();
                    controller.clear();
                    // controller.addItemsToHistory();
                  },
                  text:
                  'تأكيد الطلب',
                );
              })
            ],
          ),
        ),
      ),
    );
  }



  List<Orderr> createOrdersList() {
    print('iam here 2');
    List<Orderr> orders = [];
    Map<String, List<CartModel>> itemsByStore = _cartController
        .getItemsByStore();

    // Loop through the itemsByStore map to calculate the total price for each store
    itemsByStore.forEach((storeId, itemsInStore) {
      double totalPriceForStore = 0;
      for (var item in itemsInStore) {
        totalPriceForStore += item.quantity! * item.price!;
      }
      orders.add(createOrderForEachStore(
          storeId, totalPriceForStore,
          _deliveryDateController.text.trim(),
          _deliveryTimeController.text.trim(),
          _addressController.text.trim(),
          itemsInStore
      ));
    });
    return orders;
  }

Orderr createOrderForEachStore(String storeId, double totalPrice,
             String deliveryDate, String deliveryTime,
         String address, List<CartModel> items) {
  print('iam here 3   ${items[0].name}');

  Orderr order = Orderr();
  order.userId = int.parse(SharedPrefController().id);
  order.storeId = int.parse(storeId);
  order.total = totalPrice;
  order.deliveryTime = deliveryTime;
  order.deliveryDate = deliveryDate;
  order.address = address;
  order.orderItems = [];
  for(int i = 0; i < items.length ; i++){
    OrderItem orderItem = OrderItem();
    orderItem.productId = items[i].id;
    orderItem.productName = items[i].name;
    // orderItem.productImage = items[i].img;
    orderItem.quantity = items[i].quantity;
    orderItem.price = items[i].price;
    order.orderItems?.add(orderItem);
    print('iam here 333   ${orderItem.productName}');
  }
  return order;
}

Future<void> confirmOrder() async {
  if (checkData()) {
    print('iam here 1');
    setState(() {
      isLoading = true;
    });
    bool isSent = await OrderApiController().addOrder(createOrdersList());
    setState(() {
      isLoading = false;
    });
    if(isSent) {
      navigate();
    }
  }
}

void navigate(){
  Navigator.pushReplacementNamed(context, '/sent_successfully_screen');
}

bool checkData() {
  if (_addressController.text.isNotEmpty) {
    if (_deliveryTimeController.text.isNotEmpty) {
      if (isTimeValid(_deliveryTimeController.text.trim())) {
        return true;
      } else {
        Get.snackbar(
            'مهلاً', 'أدخل الوقت كما هو مطلوب', colorText: kPrimaryColor);
        return false;
      }
    }
    if (_deliveryDateController.text.isNotEmpty) {
      if (isTimeValid(_deliveryDateController.text.trim())) {
        return true;
      } else {
        Get.snackbar(
            'مهلاً', 'أدخل اليوم كما هو مطلوب', colorText: kPrimaryColor);
        return false;
      }
    }
    return true;
  }
  Get.snackbar('مهلاً', 'الرجاء ملء باقي الحقول', colorText: kPrimaryColor);
  return false;
}

bool isTimeValid(String timeString) {
  try {
    DateFormat timeFormat = DateFormat('HH:mm');
    timeFormat.parseStrict(timeString);
    return true;
  } catch (e) {
    return false;
  }
}

bool isDateValid(String dateString) {
  try {
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    dateFormat.parseStrict(dateString);
    return true;
  } catch (e) {
    return false;
  }
}

}
