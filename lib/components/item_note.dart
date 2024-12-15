import 'package:flutter/material.dart';
import 'package:practice_6/model/collector.dart';
import 'package:practice_6/pages/catalog_page.dart';

class ItemNote extends StatelessWidget {
  final Collector collector;
  final bool isFavourite;
  final VoidCallback onFavouriteToggle;
  final VoidCallback onAddToCart;
  const ItemNote(
      {super.key, required this.collector, required this.isFavourite, required this.onFavouriteToggle, required this.onAddToCart});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CatalogPage(collector: collector),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(collector.imageUrl),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.4,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: Colors.black.withOpacity(0.5),
                    ),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          collector.title,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: "OpenSans",
                          ),
                        ),
                        Text(
                          '${collector.cost} руб.',
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 0.5,
                    right: 4,
                    child: IconButton(
                      icon: Icon(
                        isFavourite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.red,
                      ),
                      onPressed: onFavouriteToggle,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: onAddToCart,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurpleAccent,
                foregroundColor: Colors.white,
              ),
              child: const Text('Добавить в корзину'),
            ),
          ],
        ),
      ),
    );
  }
}