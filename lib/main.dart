import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'BLoC/bLoc.dart';
import 'BLoC/theme.dart';
import 'repository/product_repository.dart';
import 'screens/homeScreen.dart';
import 'screens/coming_soon_screen.dart';
import 'screens/product_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final productRepository = ProductRepository();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeBloc()),
        BlocProvider(
          create: (context) => ProductBloc(repository: productRepository),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedThemeWidget(
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'E-Commerce App',
            debugShowCheckedModeBanner: false,
            theme: state.themeData,
            home: const MainScreen(),
          );
        },
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const ComingSoonScreen(),
    const ComingSoonScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

// Removed unused HomePage widget
