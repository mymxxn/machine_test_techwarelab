import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machine_test_techware/Data/Model/product_model.dart';
import 'package:machine_test_techware/Presentation/View/Product/product_view_screen.dart';
import 'package:machine_test_techware/bloc/product_bloc.dart';
import 'package:machine_test_techware/bloc/product_event.dart';
import 'package:machine_test_techware/bloc/product_state.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScanner extends StatefulWidget {
  const QrScanner({super.key});

  @override
  State<QrScanner> createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.width * 0.8,
        child: _buildQrView(context));
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? MediaQuery.of(context).size.width * 0.8
        : MediaQuery.of(context).size.width * 0.8;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          overlayColor: Colors.white,
          borderColor: Theme.of(context).primaryColor,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    controller.resumeCamera();
    setState(() {
      this.controller = controller;
    });

    controller.scannedDataStream.listen((scanData) async {
      setState(() {
        result = scanData;
      });

      controller.pauseCamera();
      context.read<QRGeneratorBloc>().add(SearchProduct(result?.code ?? ''));
      Navigator.pop(context);
      context.read<QRGeneratorBloc>().stream.listen((state) {
        if (state is DataLoaded && state.products.isNotEmpty) {
          // Retrieve the first product
          ProductModel firstProduct = ProductModel(
              state.products.first['name'],
              state.products.first['measurement'],
              state.products.first['price']);

          // Navigate to ProductViewScreen with the first product
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductViewScreen(product: firstProduct),
            ),
          );
        }
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();

    super.dispose();
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }
}
