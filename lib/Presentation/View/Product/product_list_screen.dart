import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machine_test_techware/Data/Model/product_model.dart';
import 'package:machine_test_techware/Presentation/Utils/components.dart';
import 'package:machine_test_techware/Presentation/Utils/constants.dart';
import 'package:machine_test_techware/Presentation/Utils/route_manager.dart';
import 'package:machine_test_techware/Presentation/Utils/shared_preferences.dart';
import 'package:machine_test_techware/Presentation/View/Product/add_product_screen.dart';
import 'package:machine_test_techware/Presentation/View/Product/product_view_screen.dart';
import 'package:machine_test_techware/bloc/product_bloc.dart';
import 'package:machine_test_techware/bloc/product_event.dart';
import 'package:machine_test_techware/bloc/product_state.dart';

class ProductListScreen extends StatefulWidget {
  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<QRGeneratorBloc>().add(FetchData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Product List'),
        actions: [
          IconButton(
            onPressed: () {
              UserPreferences.setIsLoggedIn(false);
              UserPreferences.setPin(0);
              Navigator.pushReplacementNamed(
                context,
                RouteManager.signInScreen,
              );
            },
            icon: Icon(Icons.logout),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              onChanged: (value) {
                if (_searchController.text.isNotEmpty) {
                  context
                      .read<QRGeneratorBloc>()
                      .add(SearchProduct(value.trim()));
                } else {
                  context.read<QRGeneratorBloc>().add(FetchData());
                }
              },
              decoration: InputDecoration(
                hintText: "Search",
                hintStyle: TextStyle(color: Colors.grey),
                isCollapsed: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<QRGeneratorBloc, QRGeneratorMainState>(
                builder: (context, state) {
                  if (state is DataLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is DataFetchFail) {
                    return Center(child: Text('Error: ${state.error}'));
                  } else if (state is DataLoaded) {
                    return ListView.builder(
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> product = state.products[index];
                        return InkWell(
                          onTap: () {
                            _searchController.clear();
                            context.read<QRGeneratorBloc>().add(FetchData());
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductViewScreen(
                                  product: ProductModel(
                                    product['name'],
                                    product['measurement'],
                                    "${product['price']}",
                                  ),
                                ),
                              ),
                            );
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            shadowColor: Colors.black,
                            elevation: 10,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  title: Text(product['name'] ?? ''),
                                  subtitle: Text(
                                    'Measurement: ${product['measurement'] ?? ''}, Price: ${product['price'] ?? ''}',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(child: Text('No data'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () {
          Components.commonDialog(
            context,
            "Add Products",
            SizedBox(
                width: MediaQuery.of(context).size.width,
                child: AddProductScreen()),
          );
        },
        elevation: 0,
        backgroundColor: AppColors.primary,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
