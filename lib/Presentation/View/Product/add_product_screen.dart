import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machine_test_techware/Data/Repositories/product_repository.dart';
import 'package:machine_test_techware/Presentation/Utils/components.dart';

import 'package:barcode_widget/barcode_widget.dart' as barcode;
import 'package:machine_test_techware/Presentation/Utils/constants.dart';
import 'package:machine_test_techware/Presentation/Utils/snackbar_services.dart';
import 'package:machine_test_techware/bloc/product_bloc.dart';
import 'package:machine_test_techware/bloc/product_event.dart';
import 'package:machine_test_techware/bloc/product_state.dart';

class AddProductScreen extends StatelessWidget {
  AddProductScreen({super.key});
  TextEditingController nameController = TextEditingController();
  TextEditingController meassurementController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // final QRGeneratorBloc bloc = BlocProvider.of<QRGeneratorBloc>(context);
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Components.commonTextfield(
            txt: 'Product Name',
            controller: nameController,
            inputtype: TextInputType.text,
          ),
          SizedBox(
            height: 15,
          ),
          Components.commonTextfield(
              txt: 'Measurement',
              controller: meassurementController,
              inputtype: TextInputType.text),
          SizedBox(
            height: 15,
          ),
          Components.commonTextfield(
              txt: 'Price',
              controller: priceController,
              inputtype: TextInputType.text),
          SizedBox(
            height: 30,
          ),
          BlocListener<QRGeneratorBloc, QRGeneratorMainState>(
            listener: (context, state) {
              log("message55555500");
              if (state is ProductAdd) {
                log("message");
                nameController.clear();
                meassurementController.clear();
                priceController.clear();
                SnackBarServices.successSnackbar("Product Added Successfully");
                context.read<QRGeneratorBloc>().add(FetchData());
                Navigator.pop(context);
              } else if (state is QRGeneratorFailure) {
                SnackBarServices.errorSnackbar(state.error);
              }
            },
            child: ElevatedButton(
              onPressed: () async {
                if (nameController.text.isEmpty) {
                  SnackBarServices.errorSnackbar("Please enter Product Name");
                  return;
                }
                if (meassurementController.text.isEmpty) {
                  SnackBarServices.errorSnackbar(
                      "Please enter Product Measurement");
                  return;
                }
                if (priceController.text.isEmpty) {
                  SnackBarServices.errorSnackbar("Please enter Product Price");
                  return;
                }
                context.read<QRGeneratorBloc>().add(AddProduct(
                    nameController.text,
                    meassurementController.text,
                    priceController.text));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
                fixedSize: Size(width, 50),
              ),
              child: Text(
                "Add",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
