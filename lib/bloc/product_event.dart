import 'package:equatable/equatable.dart';

abstract class QRGeneratorEvent extends Equatable {
  const QRGeneratorEvent();

  @override
  List<Object?> get props => [];
}

class TextChanged extends QRGeneratorEvent {
  final String text;

  const TextChanged(this.text);

  @override
  List<Object?> get props => [text];
}

class AddProduct extends QRGeneratorEvent {
  final String productName;
  final String productMeasurement;
  final String productPrice;

  const AddProduct(
      this.productName, this.productMeasurement, this.productPrice);

  @override
  List<Object?> get props => [productName, productMeasurement, productPrice];
}

class DeleteProduct extends QRGeneratorEvent {
  final String productName;

  const DeleteProduct(this.productName);

  @override
  List<Object?> get props => [productName];
}

class FetchData extends QRGeneratorEvent {}

class SearchProduct extends QRGeneratorEvent {
  final String query;

  const SearchProduct(this.query);

  @override
  List<Object?> get props => [query];
}
