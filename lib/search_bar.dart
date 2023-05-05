import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar>
    with SingleTickerProviderStateMixin {
  String searchValue = '';
  final List<String> _suggestions = [
    'Afeganistan',
    'Albania',
    'Algeria',
    'Australia',
    'Brazil',
    'German',
    'Madagascar',
    'Mozambique',
    'Portugal',
    'Zambia'
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      alignment: Alignment.center,
      child: Row(children: [
        SizedBox(
            width: 40.0,
            height: 56.0,
            child: BackButton(
              color: Theme.of(context).colorScheme.primary,
              onPressed: () {
                Navigator.pop(context); // Volver atrás en la navegación
              },
            )),
        Expanded(
            flex: 1,
            child: Container(
                margin: const EdgeInsets.only(right: 10, left: 10),
                height: 56.0,
                child: EasySearchBar(
                    putActionsOnRight: true,
                    title: const Text(
                      '',
                      style: TextStyle(color: Colors.grey),
                    ),
                    searchBackgroundColor:
                        Theme.of(context).colorScheme.surface,
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    onSearch: (value) => setState(() => searchValue = value),
                    suggestions: _suggestions))),
        SizedBox(
          width: 40.0,
          height: 56.0,
          child: IconButton(
            color: Theme.of(context).colorScheme.primary,
            icon: const Icon(Icons.person_outline),
            onPressed: () {
              // Acción al hacer clic en el icono de configuración
            },
          ),
        ),
      ]),
    );
  }
}
