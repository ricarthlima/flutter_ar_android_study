import 'package:flutter/material.dart';
import 'package:flutter_ar_android_study/ui/home/view/home_view_model.dart';
import 'package:provider/provider.dart';

class HomeBottomNavigationBar extends StatelessWidget {
  const HomeBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(builder: (context, homeViewModel, child) {
      return NavigationBar(
        selectedIndex: homeViewModel.indexPage,
        onDestinationSelected: (int value) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            homeViewModel.indexPage = value;
          });
        },
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.home),
            label: "Início",
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite),
            label: "Favoritos",
          ),
          NavigationDestination(
            icon: Icon(Icons.shopping_cart_rounded),
            label: "Carrinho",
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: "Perfil",
          ),
        ],
      );
    });
  }
}
