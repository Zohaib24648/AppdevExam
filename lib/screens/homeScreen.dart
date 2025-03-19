import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mid/BLoC/theme.dart';
import 'package:flutter_mid/productCard.dart';
import '../BLoC/bLoc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('E-shop'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              // TODO: implement shopping cart functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () {
              context.read<ThemeBloc>().add(
                ToggleTheme(!context.read<ThemeBloc>().state.isDark),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoaded) {
            final gridDelegate =
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                );
            return GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: gridDelegate,
              itemCount: state.products.length,
              itemBuilder:
                  (context, index) =>
                      ProductCard(product: state.products[index]),
            );
          } else if (state is ProductError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline, size: 60, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${state.message}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed:
                        () => context.read<ProductBloc>().add(FetchProducts()),
                    child: const Text('Try Again'),
                  ),
                ],
              ),
            );
          }
          if (state is ProductInitial) {
            context.read<ProductBloc>().add(FetchProducts());
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
