import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_contact_app/blocs/contact/contact_bloc.dart';
import 'package:get_contact_app/blocs/info/info_bloc.dart';
import 'package:get_contact_app/blocs/login/login_bloc.dart';
import 'package:get_contact_app/core/network/dio_client.dart';
import 'package:get_contact_app/repository/contact_repository.dart';
import 'package:get_contact_app/screens/contact/contact_page.dart';
import 'package:get_contact_app/screens/login/login_page.dart';
import 'package:get_contact_app/screens/info/info_page.dart';
import 'package:get_contact_app/screens/menu/menu_page.dart';
import 'package:get_contact_app/core/observer/simple_bloc_observer.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(DioClient()),
        ),
        BlocProvider<ContactBloc>(
            create: (context) =>
                ContactBloc(contactRepository: ContactRepository())),
        BlocProvider<InfoBloc>(
          create: (context) => InfoBloc(contactRepository: ContactRepository()),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(DioClient()),
      child: MaterialApp(
        title: 'Get Contact',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0072ff)),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const LoginPage(), // Halaman login sebagai default
          '/menu': (context) =>
              const MyHomePage(title: 'GetContact'), // Halaman utama
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    InfoPage(),
    ContactPage(),
    MenuPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65), //ukuran AppBar
        child: ClipRRect(
          child: AppBar(
            backgroundColor: const Color(0xFF0072ff),
            elevation: 5,
            title: Text(
              widget.title,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
                color: Colors.white,
                shadows: [
                  Shadow(
                    blurRadius: 5,
                    offset: Offset(1, 1),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Konten halaman (body)
          Expanded(
            child: _pages.elementAt(_selectedIndex),
          ),
          const Divider(
            thickness: 1,
            color: Colors.blue,
            indent: 10,
            endIndent: 10,
          ),
        ],
      ),
      bottomNavigationBar: ClipRRect(
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: Colors.blue[900],
          unselectedItemColor: Colors.black,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Info',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.call),
              label: 'Contact',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              label: 'Menu',
            ),
          ],
        ),
      ),
    );
  }
}
