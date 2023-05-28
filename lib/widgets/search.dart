import 'package:flutter/material.dart';
import 'package:project_3/const/style.dart';
import 'package:project_3/screens/Home/searchrender.dart';

class SearchSection extends StatefulWidget {
  const SearchSection({super.key});

  @override
  State<SearchSection> createState() => _SearchSectionState();
}

class _SearchSectionState extends State<SearchSection> {
  final SearchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    _handleSubmitted(String query) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SearchDisplay(query: query)),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3), // Shadow color
              spreadRadius: 2, // Shadow spread radius
              blurRadius: 5, // Shadow blur radius
              offset: Offset(0, 3), // Shadow offset
            )
          ],
        ),
        child: TextField(
          controller: SearchController,
          cursorColor: accent,
          style: p1,
          decoration: InputDecoration(
            suffixIcon: InkWell(
              onTap: () {
                _handleSubmitted(SearchController.text);
              },
              child: Icon(
                Icons.search,
                size: 22,
                color: text,
              ),
            ),
            prefixIcon: InkWell(
              onTap: () {},
              child: Icon(
                Icons.mic,
                size: 22,
                color: text,
              ),
            ),
            hintText: 'search places',
            hintStyle: p1,
            fillColor: white,
            filled: true,
            contentPadding: EdgeInsets.symmetric(vertical: small),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}
