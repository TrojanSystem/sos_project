import 'package:flutter/material.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      margin: const EdgeInsets.fromLTRB(8, 0, 20, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'What are you looking for?',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            validator: (value) {
              if (value == null) {
                return 'Can\'t be empty';
              } else {
                return null;
              }
            },
            onSaved: (value) {},
            decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.search_outlined,
                size: 35,
              ),
              hintText: 'Search your dream house?',
              filled: true,
              fillColor: Colors.grey[200],
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
