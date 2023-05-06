import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchBar extends StatefulWidget implements PreferredSizeWidget {
  final String emailName;

  const SearchBar({Key? key, required this.emailName}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState(emailName);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _SearchBarState extends State<SearchBar>
    with SingleTickerProviderStateMixin {
  String emailName;
  _SearchBarState(this.emailName);

  String searchValue = '';
  final List<String> _suggestions = [
    'Afghanistan',
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
  Widget build(BuildContext context) {
    return EasySearchBar(
      putActionsOnRight: true,
      openOverlayOnSearch: true,
      title: SvgPicture.asset(
        'assets/images/logo.svg',
        width: 20,
        height: 20,
      ),
      searchHintText: 'Pesquisar...',
      searchHintStyle: Theme.of(context).textTheme.bodyMedium,
      searchBackgroundColor: Theme.of(context).colorScheme.surface,
      backgroundColor: Theme.of(context).colorScheme.surface,
      foregroundColor: Theme.of(context).colorScheme.primary,
      searchCursorColor: Theme.of(context).colorScheme.primary,
      suggestionBackgroundColor: Theme.of(context).colorScheme.surface,
      iconTheme: IconThemeData(color: Theme.of(context).colorScheme.primary),
      searchBackIconTheme: IconThemeData(color: Theme.of(context).colorScheme.primary),
      searchClearIconTheme: IconThemeData(color: Theme.of(context).colorScheme.primary),
      onSearch: (value) => setState(() => searchValue = value),
      suggestions: _suggestions,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: IconButton(
            onPressed: () {
              // TODO: Implementar ação de conta do usuário
              if(emailName.isEmpty) {
                Navigator.of(context).pushReplacementNamed('/login');
              }
              else {
                Navigator.of(context).pushReplacementNamed('/login');
              }
            },
            icon: Icon(
              Icons.account_circle,
              color: emailName.isEmpty ? Theme.of(context).colorScheme.onBackground : Theme.of(context).colorScheme.primary,
              //size: 36,
            ),
          ),
        ),
      ],
    );
  }
}
