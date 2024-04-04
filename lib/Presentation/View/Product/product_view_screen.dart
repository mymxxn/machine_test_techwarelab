import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machine_test_techware/Data/Model/product_model.dart';
import 'package:machine_test_techware/Presentation/Utils/constants.dart';
import 'package:machine_test_techware/bloc/product_bloc.dart';
import 'package:machine_test_techware/bloc/product_state.dart';
import 'package:barcode_widget/barcode_widget.dart' as barcode;

class ProductViewScreen extends StatelessWidget {
  ProductViewScreen({super.key, required this.product});
  final ProductModel product;
  var qrKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name ?? ''),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RepaintBoundary(
              key: qrKey,
              child: barcode.BarcodeWidget(
                backgroundColor: Colors.white,
                barcode: barcode.Barcode.qrCode(),
                data: product.name ?? '', // Access text from QRGeneratorState
                width: double.infinity,
                height: size.height / 2,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            buildTile(
              firstText: "Product: ",
              secondText: "${product.name}",
            ),
            SizedBox(
              height: 8,
            ),
            Row(children: [
              Expanded(
                  child: buildTile(
                firstText: "Measurement: ",
                secondText: "${product.measurement}",
              )),
              Expanded(
                  child: buildTile(
                firstText: "Price: ",
                secondText: "${product.price}",
              ))
            ])
          ],
        ),
      ),
    );
  }
}

buildTile({required String firstText, required String secondText}) => Row(
      children: [
        Text(
          firstText,
          style: TextStyle(
              color: Colors.black87, fontSize: 15, fontWeight: FontWeight.w500),
        ),
        Text(
          secondText,
          style: TextStyle(
              color: Colors.black87, fontSize: 14, fontWeight: FontWeight.w400),
        )
      ],
    );
