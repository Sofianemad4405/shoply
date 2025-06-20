import 'package:flutter/material.dart';

class SearchToggleField extends StatefulWidget {
  @override
  _SearchToggleFieldState createState() => _SearchToggleFieldState();
}

class _SearchToggleFieldState extends State<SearchToggleField> {
  bool showSearch = false;
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            child:
                showSearch
                    ? Expanded(
                      key: ValueKey('textfield'),
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          hintText: 'Search...',
                          border: OutlineInputBorder(),
                          isDense: true,
                          suffixIcon: IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () {
                              setState(() {
                                showSearch = false;
                                searchController.clear();
                              });
                            },
                          ),
                        ),
                        onSubmitted: (value) {
                          print('You searched: $value');
                          // navigate to results or filter list
                        },
                      ),
                    )
                    : IconButton(
                      key: ValueKey('icon'),
                      icon: Icon(Icons.search),
                      onPressed: () {
                        setState(() => showSearch = true);
                      },
                    ),
          ),
        ],
      ),
    );
  }
}
