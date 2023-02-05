import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  const SearchBar(
      {super.key, required this.onSearch, required this.onItemFound});

  final Function onSearch;
  final void Function(List<dynamic> list) onItemFound;

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            border: Border.all(color: Colors.grey)),
        child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
            child: Row(mainAxisSize: MainAxisSize.max, children: [
              const Padding(
                padding: EdgeInsetsDirectional.fromSTEB(4, 0, 4, 0),
                child: Icon(
                  Icons.search_rounded,
                  color: Color(0xFF95A1AC),
                  size: 24,
                ),
              ),
              Expanded(
                  child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                      child: TextFormField(
                          onChanged: (value) async {
                            var items = await widget.onSearch(value);
                            widget.onItemFound(items);
                          },
                          controller: textController,
                          obscureText: false,
                          decoration: const InputDecoration(
                              labelText: 'Search product here...',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  topRight: Radius.circular(4.0),
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ))))))
            ])));
  }
}
