import 'package:flutter/material.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        title: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Pesquisar...',
              hintStyle: Theme.of(context).textTheme.bodyMedium,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
                borderSide: BorderSide(
                  color:
                  Theme.of(context).colorScheme.outlineVariant,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
                borderSide: BorderSide(
                  color:
                  Theme.of(context).colorScheme.outlineVariant,
                ),
              ),
              filled: true,
              fillColor: Theme.of(context).colorScheme.surface,
              prefixIcon: const Icon(Icons.search),
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  // TODO: Implementar ação de conta do usuário
                },
                icon: Icon(
                  Icons.account_circle_outlined,
                  color: Theme.of(context).colorScheme.onSurface,
                  size: 32,
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            _buildPromotionCarousel(context),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Mais populares',
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
            const SizedBox(height: 16),
            _buildPopularProductsList(context),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                // TODO: Implementar ação do ícone home
              },
              icon: const Icon(Icons.home),
            ),
            IconButton(
              onPressed: () {
                // TODO: Implementar ação do ícone favoritos
              },
              icon: const Icon(Icons.favorite),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPromotionCarousel(BuildContext context) {
    // TODO: Implementar o carossel de imagens
    return Container();
  }

  Widget _buildPopularProductsList(BuildContext context) {
    // TODO: Implementar a lista de produtos mais populares
    return Container();
  }
}
