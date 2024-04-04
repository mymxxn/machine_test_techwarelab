import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:machine_test_techware/Data/Model/product_model.dart';
import 'package:machine_test_techware/Data/Repositories/product_repository.dart';
import 'package:machine_test_techware/bloc/product_event.dart';
import 'package:machine_test_techware/bloc/product_state.dart';
import 'package:bloc/bloc.dart';

class QRGeneratorBloc extends Bloc<QRGeneratorEvent, QRGeneratorMainState> {
  List<Map<String, dynamic>> _localProducts = [];
  final ProductRepository _repository;

  QRGeneratorBloc(this._repository) : super(QRGeneratorInitial()) {
    on<TextChanged>((event, emit) {
      emit(QRGeneratorState(event.text));
    });
    on<AddProduct>(
      (event, emit) async {
        try {
          await _repository.addProduct(
            name: event.productName,
            measurement: event.productMeasurement,
            price: event.productPrice,
          );
          emit(ProductAdd());
        } catch (error) {
          emit(QRGeneratorFailure(error.toString()));
        }
      },
    );
    on<FetchData>(
      (event, emit) async {
        try {
          QuerySnapshot querySnapshot =
              await FirebaseFirestore.instance.collection('products').get();
          _localProducts = querySnapshot.docs
              .map((doc) => doc.data() as Map<String, dynamic>)
              .toList();
          emit(DataLoaded(_localProducts));
        } catch (error) {
          emit(DataFetchFail(error.toString()));
        }
      },
    );
    on<DeleteProduct>(
      (event, emit) async {
        try {
          await _repository.deleteProduct(name: event.productName);
          emit(ProductDelete());
        } catch (error) {
          emit(QRGeneratorFailure(error.toString()));
        }
      },
    );
    on<SearchProduct>(
      (event, emit) async {
        try {
          log("${_localProducts}");
          // Filter the local products list based on the search query
          List<Map<String, dynamic>> filteredProducts = _localProducts
              .where((product) => product['name']
                  .toLowerCase()
                  .contains(event.query.toLowerCase()))
              .toList();

          // Emit the filtered list as DataLoaded state
          emit(DataLoaded(filteredProducts));
        } catch (error) {
          emit(QRGeneratorFailure(error.toString()));
        }
      },
    );
  }
}
