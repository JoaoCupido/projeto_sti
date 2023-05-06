import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'classes/product.dart';
import 'classes/wishlist.dart';


class WishlistScreen extends StatefulWidget {
  final String emailName;

  const WishlistScreen({Key? key, required this.emailName}) : super(key: key);

  @override
  _WishlistScreenState createState() => _WishlistScreenState(emailName);
}

class _WishlistScreenState extends State<WishlistScreen>
    with SingleTickerProviderStateMixin {
  String emailName;
  _WishlistScreenState(this.emailName);

  TextEditingController _newWishlistNameController = TextEditingController();
  final List<Wishlist> _wishlistList = [myWishlist1, myWishlist2];

  late Wishlist _wishlistChosen;
  TextEditingController? _textEditingController;
  bool _showCopyLinkSection = false;

  @override
  void initState() {
    super.initState();
    _wishlistChosen = Wishlist(name: '', products: [], type: WishlistType.private);
    _textEditingController = TextEditingController(text: _wishlistChosen.name);
  }

  bool _validateNewWishlistName() {
    final wishlistName = _newWishlistNameController.text.trim();

    if (wishlistName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('O campo "Nome da lista" é obrigatório!'),
        backgroundColor: Theme.of(context).colorScheme.error,
      ));
      return false;
    }

    return true;
  }

  void _addNewWishlist(String name) {
    setState(() {
      _wishlistList.add(Wishlist(
        name: name,
        products: [],
        type: WishlistType.private,
      ));
    });
  }

  void _deleteWishlist(int index) {
    setState(() {
      _wishlistList.removeAt(index);
    });
  }

  void _deleteProduct(int index) {
    setState(() {
      _wishlistChosen.products.removeAt(index);
    });
  }

  @override
  void dispose() {
    _newWishlistNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (emailName.isEmpty) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 32.0),
              Text("As minhas listas",
                  style: Theme.of(context).textTheme.displaySmall,
                  textAlign: TextAlign.left),
              const SizedBox(height: 8.0),
              Text("0 listas",
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.left),
              SvgPicture.asset(
                'assets/images/271-Wishlist.svg',
                width: 300,
                height: 300,
              ),
              Text("Sem sessão iniciada",
                  style: Theme.of(context).textTheme.displaySmall,
                  textAlign: TextAlign.center),
              const SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                    "Adicione artigos favoritos e/ou que futuramente queira adquirir. De momento, só é possível criar, editar e partilhar as suas listas com sessão de conta iniciada.",
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center),
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/login');
                    },
                    child: const Text('Iniciar sessão'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
    if (_wishlistList.isEmpty) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 32.0),
              Text("As minhas listas",
                  style: Theme.of(context).textTheme.displaySmall,
                  textAlign: TextAlign.left),
              const SizedBox(height: 8.0),
              Text("0 listas",
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.left),
              SvgPicture.asset(
                'assets/images/271-Wishlist.svg',
                width: 300,
                height: 300,
              ),
              Text("Sem listas",
                  style: Theme.of(context).textTheme.displaySmall,
                  textAlign: TextAlign.center),
              const SizedBox(height: 16.0),
              Text(
                  "Adicine listas de artigos favoritos e/ou\nque futuramente queira adquirir.\nCrie listas e adicione artigos favoritos.",
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center),
              const SizedBox(height: 24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (context) => Center(
                          child: AlertDialog(
                            title: const Text('Criar nova lista de desejos'),
                            content: TextField(
                              controller: _newWishlistNameController,
                              decoration: InputDecoration(
                                labelText: 'Nome da lista',
                                labelStyle: Theme.of(context).textTheme.bodyMedium,
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
                              ),
                            ),
                            actions: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      if(_validateNewWishlistName()) {
                                        _addNewWishlist(_newWishlistNameController.text);
                                        Navigator.of(context).pop();
                                      }
                                    },
                                    child: const Text('Criar'),
                                  ),
                                  const SizedBox(width: 16.0),
                                  OutlinedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    style: OutlinedButton.styleFrom(
                                      side: BorderSide(
                                        color: Theme.of(context).colorScheme.primary,
                                      ),
                                      backgroundColor:
                                      Theme.of(context).colorScheme.surface,
                                    ),
                                    child: const Text('Cancelar'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    child: const Text('Adicionar lista'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
    if (_wishlistChosen.name.isNotEmpty) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 32.0),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextField(
                  controller: _textEditingController,
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    labelText: 'Nome da lista',
                    labelStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildWishlistTypeButton(
                    context,
                    WishlistType.private,
                    Icons.lock_outline,
                    'Privado',
                  ),
                  _buildWishlistTypeButton(
                    context,
                    WishlistType.shared,
                    Icons.people_alt_outlined,
                    'Partilhado',
                  ),
                  _buildWishlistTypeButton(
                    context,
                    WishlistType.public,
                    Icons.public_outlined,
                    'Público',
                  ),
                ],
              ),
              if (_showCopyLinkSection)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 32.0),
                  child: _showCopyLinkSection
                      ? Row(
                      children: [
                        const Text('Link: '),
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              Clipboard.setData(const ClipboardData(text: 'https://petsupply.com/1234'));
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Link copiado para a área de transferência!')),
                              );
                            },
                            child: const Text('https://petsupply.com/1234'),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Clipboard.setData(const ClipboardData(text: 'https://petsupply.com/1234'));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Link copiado para a área de transferência!')),
                            );
                          },
                          icon: const Icon(Icons.copy),
                        ),
                      ],
                  ) : const SizedBox(),
                ),
              const SizedBox(height: 24.0),
              Text(
                'Produtos (${_wishlistChosen.products.length} ${_wishlistChosen.products.length == 1 ? 'item' : 'itens'})',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8.0),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _wishlistChosen.products.length,
                itemBuilder: (BuildContext context, int index) {
                  final product = _wishlistChosen.products[index];
                  return Container(
                    color: Colors.white,
                    child: ListTile(
                      leading: Image.asset(product.imageUrl),
                      title: Text(product.title),
                      subtitle: Text(product.brand),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '€${product.price.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: product.discountPrice != null ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 4.0),
                          if (product.discountPrice != null) ...[
                            Text(
                              '€${product.discountPrice?.toStringAsFixed(2)}',
                              style: const TextStyle(
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            const SizedBox(width: 4),
                          ],
                          IconButton(
                            icon: const Icon(Icons.delete),
                            color: Colors.red,
                            onPressed: () {
                              setState(() {
                                showDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (context) => Center(
                                    child: AlertDialog(
                                      title: const Text('Remover produto'),
                                      content: const Text(
                                          'Tens mesmo a certeza que pretende remover o produto?'),
                                      actions: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {
                                                _deleteProduct(index);
                                                Navigator.of(context).pop();
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Theme.of(context).colorScheme.primary,
                                              ),
                                              child: const Text('Remover'),
                                            ),
                                            const SizedBox(width: 16.0),
                                            OutlinedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              style: OutlinedButton.styleFrom(
                                                side: BorderSide(
                                                  color: Theme.of(context).colorScheme.primary,
                                                ),
                                                backgroundColor:
                                                Theme.of(context).colorScheme.surface,
                                              ),
                                              child: const Text('Cancelar'),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      );
    }
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 32.0),
            Text(
              "As minhas listas",
              style: Theme.of(context).textTheme.displaySmall,
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 8.0),
            Text(
              "${_wishlistList.length} ${_wishlistList.length == 1 ? 'lista' : 'listas'}",
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: 250.0,
              child: DropdownButtonFormField(
                value: 'name_asc',
                decoration: InputDecoration(
                  labelText: 'Ordenar por',
                  labelStyle: Theme.of(context).textTheme.bodyMedium,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.outlineVariant,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.outlineVariant,
                    ),
                  ),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surface,
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'name_asc',
                    child: Text('Nome (A-Z)'),
                  ),
                  DropdownMenuItem(
                    value: 'name_desc',
                    child: Text('Nome (Z-A)'),
                  ),
                  DropdownMenuItem(
                    value: 'type_asc',
                    child: Text('Tipo (Público-Privado)'),
                  ),
                  DropdownMenuItem(
                    value: 'type_desc',
                    child: Text('Tipo (Privado-Público)'),
                  ),
                ],
                onChanged: (value) {
                  switch (value) {
                    case 'name_asc':
                      setState(() {
                        _wishlistList.sort((a, b) => a.name.compareTo(b.name));
                      });
                      break;
                    case 'name_desc':
                      setState(() {
                        _wishlistList.sort((a, b) => b.name.compareTo(a.name));
                      });
                      break;
                    case 'type_asc':
                      setState(() {
                        _wishlistList.sort((a, b) => a.type.name.compareTo(b.type.name));
                      });
                      break;
                    case 'type_desc':
                      setState(() {
                        _wishlistList.sort((a, b) => b.type.name.compareTo(a.type.name));
                      });
                      break;
                  }
                },
              ),
            ),
            const SizedBox(height: 16.0),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _wishlistList.length,
              itemBuilder: (context, index) {
                final wishlist = _wishlistList[index];
                return Card(
                  child: ListTile(
                    title: Text(wishlist.name),
                    subtitle:
                        Text('${wishlist.products.length} ${wishlist.products.length == 1 ? 'item' : 'itens'} - ${wishlist.type.name}'),
                    onTap: () {
                      setState(() {
                        _wishlistChosen = wishlist;
                        _textEditingController!.text = wishlist.name;
                      });
                    },
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (context) => Center(
                            child: AlertDialog(
                              title: const Text('Remover lista de desejos'),
                              content: const Text(
                                  'Tens mesmo a certeza que pretende remover a lista de desejos?'),
                              actions: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        _deleteWishlist(index);
                                        Navigator.of(context).pop();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Theme.of(context).colorScheme.primary,
                                      ),
                                      child: const Text('Remover'),
                                    ),
                                    const SizedBox(width: 16.0),
                                    OutlinedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      style: OutlinedButton.styleFrom(
                                        side: BorderSide(
                                          color: Theme.of(context).colorScheme.primary,
                                        ),
                                        backgroundColor:
                                        Theme.of(context).colorScheme.surface,
                                      ),
                                      child: const Text('Cancelar'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 32.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (context) => Center(
                          child: AlertDialog(
                            title: const Text('Criar nova lista de desejos'),
                            content: TextField(
                              controller: _newWishlistNameController,
                              decoration: InputDecoration(
                                labelText: 'Nome da lista',
                                labelStyle: Theme.of(context).textTheme.bodyMedium,
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
                              ),
                            ),
                            actions: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      if(_validateNewWishlistName()) {
                                        _addNewWishlist(_newWishlistNameController.text);
                                        Navigator.of(context).pop();
                                      }
                                    },
                                    child: const Text('Criar'),
                                  ),
                                  const SizedBox(width: 16.0),
                                  OutlinedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    style: OutlinedButton.styleFrom(
                                      side: BorderSide(
                                        color: Theme.of(context).colorScheme.primary,
                                      ),
                                      backgroundColor:
                                      Theme.of(context).colorScheme.surface,
                                    ),
                                    child: const Text('Cancelar'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.add,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWishlistTypeButton(BuildContext context, WishlistType type, IconData icon, String label) {
    final bool isSelected = _wishlistChosen.type == type;

    return ElevatedButton(
      onPressed: () {
        setState(() {
          _wishlistChosen = _wishlistChosen.copyWith(type: type);
          _showCopyLinkSection = (type == WishlistType.shared || type == WishlistType.public);
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.surface,
        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? Colors.white : Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }


}
