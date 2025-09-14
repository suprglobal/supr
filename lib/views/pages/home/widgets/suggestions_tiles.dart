import 'package:flutter/material.dart';
 import 'package:superapp/views/pages/home/widgets/item_grid_suggestions.dart';

class SuggestionTile extends StatelessWidget {
  final List<Map<String, String>> suggestionsItems;

  const SuggestionTile({super.key, required this.suggestionsItems});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: suggestionsItems.length,
        padding: EdgeInsets.symmetric(horizontal:  10, vertical:10),
        separatorBuilder: (context, index) => SizedBox(width: 15),
        itemBuilder: (context, index) {

          return ItemGridTileLargeImage(
            imagePath: suggestionsItems[index]['imagePath']!,
            title: suggestionsItems[index]['title']!,
            onTap: () {
              print('Tapped on item ${suggestionsItems[index]['title']}');
            },
          );
        },
      ),
    );
  }
}
