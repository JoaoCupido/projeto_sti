import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:projeto_sti/search_results_screen.dart';

class SearchBar extends StatefulWidget implements PreferredSizeWidget {
  final String emailName;
  final String query;

  const SearchBar({Key? key, required this.emailName, required this.query}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState(emailName, query);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _SearchBarState extends State<SearchBar>
    with SingleTickerProviderStateMixin {
  String emailName;
  String query;
  _SearchBarState(this.emailName, this.query);

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
  void didChangeDependencies() {
    super.didChangeDependencies();
    searchValue = query;
  }

  @override
  Widget build(BuildContext context) {
    return EasySearchBar(
      putActionsOnRight: true,
      openOverlayOnSearch: true,
      title: query.isEmpty ? SvgPicture.asset(
        'assets/images/logo.svg',
        width: 20,
        height: 20,
      ) : Text(query),
      searchHintText: 'Pesquisar...',
      searchHintStyle: Theme.of(context).textTheme.bodyMedium,
      searchBackgroundColor: Theme.of(context).colorScheme.surface,
      backgroundColor: Theme.of(context).colorScheme.surface,
      foregroundColor: Theme.of(context).colorScheme.primary,
      searchCursorColor: Theme.of(context).colorScheme.primary,
      suggestionBackgroundColor: Theme.of(context).colorScheme.surface,
      iconTheme:
      IconThemeData(color: Theme.of(context).colorScheme.primary),
      searchBackIconTheme:
      IconThemeData(color: Theme.of(context).colorScheme.primary),
      searchClearIconTheme:
      IconThemeData(color: Theme.of(context).colorScheme.primary),
      onSearch: (value) {
        //Navigator.pushNamed(context, '/search');
      },
      onSuggestionTap: (value) {
        setState(() => searchValue = value);
        if (searchValue.isNotEmpty) {
          //Navigator.pushNamed(context, '/search');
          Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) =>
                      SearchResultsScreen(
                          args: {'query': value, 'emailName': emailName}
                      )
              )
          );
        }
      },
      suggestions: _suggestions,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: IconButton(
            onPressed: () {
              if (emailName.isEmpty) {
                Navigator.of(context).pushReplacementNamed('/login');
              } else {
                Navigator.of(context).pushNamed('/user-account');
              }
            },
            icon: Icon(
              Icons.account_circle,
              color: emailName.isEmpty
                  ? Theme.of(context).colorScheme.onBackground
                  : Theme.of(context).colorScheme.primary,
              //size: 36,
            ),
          ),
        ),
      ],
    );
  }
}
