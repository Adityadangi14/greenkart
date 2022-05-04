import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greenkart/views/homepage.dart';

import '../Getx/GreenKartController.dart';

class Filter extends StatelessWidget {
  Filter({Key? key}) : super(key: key);
  final controller = Get.put(GreenKartController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          gradientAppBar(context),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text('Select Category',
                style: GoogleFonts.roboto(
                    fontSize: 20, fontWeight: FontWeight.w600)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GetBuilder<GreenKartController>(builder: (controller) {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Premium',
                          style: GoogleFonts.montserrat(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        Checkbox(
                            value: controller.filterState['Premium'],
                            onChanged: (bool? value) {
                              controller.filterManager('Premium', value);
                            })
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'TamilNadu',
                          style: GoogleFonts.montserrat(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        Checkbox(
                            value: controller.filterState['Tamilnadu'],
                            onChanged: (bool? value) {
                              controller.filterManager('Tamilnadu', value);
                            })
                      ],
                    ),
                    Container(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(),
                            ),
                          );
                        },
                        child: Text('Apply Filter'),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.lightGreen),
                        ),
                      ),
                    )
                  ],
                ),
              );
            }),
          )
        ]),
      ),
    );
  }
}
