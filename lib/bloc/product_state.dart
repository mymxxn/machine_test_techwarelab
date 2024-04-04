import 'package:equatable/equatable.dart';

abstract class QRGeneratorMainState extends Equatable {}

class QRGeneratorInitial extends QRGeneratorMainState {
  @override
  List<Object?> get props => [];
}

class QRGeneratorState extends QRGeneratorMainState {
  final String text;

  QRGeneratorState(this.text);

  @override
  List<Object?> get props => [text];
}

class ProductAdd extends QRGeneratorMainState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ProductDelete extends QRGeneratorMainState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class QRGeneratorSuccess extends QRGeneratorMainState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class QRGeneratorFailure extends QRGeneratorMainState {
  final String error;

  QRGeneratorFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class DataLoading extends QRGeneratorMainState {
  DataLoading();

  @override
  List<Object> get props => [];
}

class DataFetchFail extends QRGeneratorMainState {
  final String error;
  DataFetchFail(this.error);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class DataLoaded extends QRGeneratorMainState {
  final List<Map<String, dynamic>> products;

  DataLoaded(this.products);

  @override
  List<Object> get props => [products];
}

class FilterProduct extends QRGeneratorMainState {
  final List<Map<String, dynamic>> filterProducts;
  FilterProduct(this.filterProducts);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
