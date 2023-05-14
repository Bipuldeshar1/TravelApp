import 'package:flutter/material.dart';
import 'package:project_3/const/style.dart';
import 'package:project_3/screens/Home/searchrender.dart';

class SearchSection extends StatefulWidget {
  const SearchSection({super.key});

  @override
  State<SearchSection> createState() => _SearchSectionState();
}

class _SearchSectionState extends State<SearchSection> {
  final SearchController=TextEditingController();
  @override
  Widget build(BuildContext context) {
      _handleSubmitted(String query) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>SearchDisplay(query: query) ),
    );
  }
    
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller:SearchController ,
            cursorColor: accent,
            style: p1,
            decoration: InputDecoration(
              prefixIcon: InkWell(onTap: () {
               _handleSubmitted(SearchController.text);
              },
              child: Icon(Icons.search, size: 22, color: text,),),
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
        SizedBox(
          width: small,height: 10,
        ),
        Container(
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(12),
          ),
          height: 50,
          width: 50,
          child: Icon(
            Icons.mic,
            color: white,
          ),
        ),
      ],
    );
  }
}