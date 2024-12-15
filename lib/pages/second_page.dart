import 'package:flutter/material.dart';
import 'package:practice_6/components/item_note.dart';
import 'package:practice_6/model/collector.dart';


class SecondPage extends StatelessWidget {
  final List<Collector> favouriteCollector;
  final Function(Collector) onFavouriteToggle;
  final Function(Collector) onAddToCart;

  const SecondPage(
      {super.key,
      required this.favouriteCollector,
      required this.onFavouriteToggle,
      required this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Избранное'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: favouriteCollector.isNotEmpty
            ? GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: favouriteCollector.length,
                itemBuilder: (BuildContext context, int index) {
                  final collector = favouriteCollector[index];
                  return ItemNote(
                    collector: collector,
                    isFavourite: true,
                    onFavouriteToggle: () {
                      onFavouriteToggle(collector);
                    },
                    onAddToCart:() {
                      onAddToCart(collector);
                    },
                  );
                },
              )
            : const Center(
                child: Text('Нет избранных сетов'),
              ),
      ),
    );
  }
}
