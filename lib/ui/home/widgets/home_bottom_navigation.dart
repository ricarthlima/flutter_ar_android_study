import 'package:flutter/material.dart';

class HomeBottomNavigationBar extends StatelessWidget {
  const HomeBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      onDestinationSelected: (value) {},
      destinations: [
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
  }
}
