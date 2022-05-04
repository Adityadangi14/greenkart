import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greenkart/Getx/GreenKartController.dart';
import 'package:greenkart/Getx/cart_controller.dart';
import 'package:greenkart/jsonManager/jsonManager.dart';
import 'package:greenkart/views/filter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GreenKartController controller = Get.put(GreenKartController());

  List<TextEditingController> textFieldController = [];

  @override
  void initState() {
    // TODO: implement initState
    if (controller.json == null) {
      controller.getGreenKartJson();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            gradientAppBar(context),
            const SizedBox(
              width: 5,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Filter()));
              },
              child: Container(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Icon(Icons.filter_alt_outlined),
                            Padding(
                              padding: EdgeInsets.all(3),
                              child: Text(
                                'Filter',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                ),
                              ),
                            )
                          ],
                        ),
                        controller.filterState['Premium'] == true ||
                                controller.filterState['Tamilnadu'] == true
                            ? Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.red.shade700,
                                ),
                                height: 8,
                                width: 8,
                              )
                            : Container()
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GetBuilder<GreenKartController>(builder: (controller) {
                return controller.loading.value == true
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : AnimationLimiter(
                        child: Container(
                          child: GridView.builder(
                            padding: const EdgeInsets.all(8),
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 200,
                                    childAspectRatio: 2 / 3,
                                    crossAxisSpacing: 18,
                                    mainAxisSpacing: 21),
                            itemCount: controller.json!.length,
                            itemBuilder: (BuildContext context, int index) {
                              textFieldController
                                  .add(TextEditingController(text: "1"));
                              return AnimationConfiguration.staggeredGrid(
                                position: index,
                                duration: const Duration(milliseconds: 375),
                                columnCount: 6,
                                child: ScaleAnimation(
                                  child: FadeInAnimation(
                                    child: Container(
                                        child: Column(children: [
                                      Container(
                                        height: 120,
                                        width: double.maxFinite,
                                        child: FittedBox(
                                          fit: BoxFit.fill,
                                          child: Image(
                                            image: AssetImage(controller
                                                .json![index].pImage!),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        controller.json![index].pName!,
                                        style: GoogleFonts.notoSans(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      controller.json![index].pDetails == null
                                          ? const Text(
                                              'No detail available',
                                              style: TextStyle(
                                                  fontStyle: FontStyle.italic,
                                                  color: Colors.black54),
                                            )
                                          : Text(
                                              controller.json![index].pDetails!,
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 12,
                                                  color: Colors.black54),
                                            ),
                                      Text(
                                          'Price: ${controller.json![index].pCost!.toString()}'),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Row(
                                          children: [
                                            const Text('Qty :'),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Expanded(
                                                child: TextField(
                                              controller:
                                                  textFieldController[index],
                                            ))
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      AddToCart(textFieldController[index].text,
                                          controller.json![index].pId),
                                    ])),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
              }),
            )
          ],
        ),
      ),
    );
  }
}

Stack gradientAppBar(context) {
  CartController cartController = Get.put(CartController());
  return Stack(
    children: [
      Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xffA2FF00),
              Color(0xff4DBD04),
              Color(0xff04BD4D),
            ],
          ),
        ),
      ),
      Positioned(
        top: 10,
        left: 13,
        child: Text(
          'GreenKart',
          style:
              GoogleFonts.satisfy(color: Colors.green.shade700, fontSize: 30),
        ),
      ),
      Positioned(
        right: 30,
        top: 18,
        child: Stack(
          children: [
            const Icon(
              Icons.shopping_cart,
              color: Colors.white70,
              size: 27,
            ),
            GetBuilder<CartController>(
              builder: (cartController) {
                return Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      height: 15,
                      width: 15,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.red),
                      child:  Center(
                        child:  Text(
                          cartController.cart.length.toString(),
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ));
              }
            ),
          ],
        ),
      )
    ],
  );
}

class AddToCart extends StatefulWidget {
  final String? qty;
  final int? pId;

  AddToCart(this.qty, this.pId) : super();

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  CartController cartController = Get.put(CartController());
  bool? cartState;
  @override
  Widget build(BuildContext context) {
    return cartState !=null && cartState == true  ?Row(children: [
      Expanded(
        child: Center(
          child: Container(
            color: Colors.grey,
            height: 15,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: Text(
                  'Added to cart',
                  style: GoogleFonts.robotoCondensed(
                    fontSize: 12,
                  ),
                )),
                const SizedBox(
                  width: 5,
                ),
                const Icon(
                  Icons.shopping_cart,
                  size: 10,
                )
              ],
            ),
          ),
        ),
      ),
    ]) : InkWell(
      onTap: ()async{
        bool value =  await cartController.addItem(widget.qty!, widget.pId!);

        if(value==true){
          cartState= value;
          setState(() {
            
          });
        }
      },
      child: Row(children: [
        Expanded(
          child: Center(
            child: Container(
              color: Colors.amber,
              height: 15,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: Text(
                    'Add to cart',
                    style: GoogleFonts.robotoCondensed(
                      fontSize: 12,
                    ),
                  )),
                  const SizedBox(
                    width: 5,
                  ),
                  const Icon(
                    Icons.shopping_cart,
                    size: 10,
                  )
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
