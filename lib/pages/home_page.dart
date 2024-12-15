import 'package:flutter/material.dart';
import 'package:practice_6/components/item_note.dart';
import 'package:practice_6/model/collector.dart';
import 'package:practice_6/pages/basket_page.dart';
import 'package:practice_6/model/cart_item.dart';



final List<Collector> collector = [
  Collector(
      0,
      "Fiery Soul of the Slayer",
      "Коллектор сет для Lina, включающий пламенный стиль и уникальные эффекты частиц.",
      "https://static.wikia.nocookie.net/dota2_gamepedia/images/7/77/Cosmetic_icon_Fiery_Soul_of_the_Slayer.png/revision/latest?cb=20140217134009",
      '2500',
      '12345678'),
  Collector(
      1,
      "Manifold Paradox",
      "Коллектор сет для Phantom Assassin, предоставляющий уникальную анимацию критических ударов.",
      "https://static.wikia.nocookie.net/dota2_gamepedia/images/0/0c/Cosmetic_icon_Manifold_Paradox.png/revision/latest?cb=20141121044212",
      '3000',
      '87654321'),
  Collector(
      2,
      "Legacy of the Fallen Legion",
      "Сет для Legion Commander с особым оформлением арены дуэли.",
      "https://static.wikia.nocookie.net/dota2_gamepedia/images/f/f0/Cosmetic_icon_Legacy_of_the_Fallen_Legion.png/revision/latest?cb=20160713012035",
      '2200',
      '23456789'),
  Collector(
      3,
      "The International 2021 Collector's Cache",
      "Коллектор набор, содержащий уникальные сеты для разных героев.",
      "https://static.wikia.nocookie.net/dota2_gamepedia/images/2/22/Cosmetic_icon_Nemestice_Collector%27s_Cache_2021.png/revision/latest?cb=20210723223822",
      '3500',
      '98765432'),
  Collector(
      4,
      "The Magus Cypher",
      "Эпический сет для Invoker с уникальными визуальными эффектами заклинаний.",
      "https://static.wikia.nocookie.net/dota2_gamepedia/images/a/a9/Cosmetic_icon_The_Magus_Cypher.png/revision/latest?cb=20181221173723",
      '4000',
      '34567890'),
  Collector(
      5,
      "Bladeform Legacy",
      "Сет для Juggernaut с изменённой моделью героя и эффектами способностей.",
      "https://static.wikia.nocookie.net/dota2_gamepedia/images/5/5c/Cosmetic_icon_Bladeform_Legacy.png/revision/latest?cb=20180127175847",
      '4500',
      '09876543'),
  Collector(
      6,
      "Benevolent Companion",
      "Коллектор сет для Keeper of the Light с милым ездовым животным.",
      "https://static.wikia.nocookie.net/dota2_gamepedia/images/c/c4/Cosmetic_icon_Benevolent_Companion.png/revision/latest?cb=20170518210948",
      '2000',
      '45678901'),
];

class HomePage extends StatefulWidget {
  final Function(Collector) onFavouriteToggle;
  final List<Collector> favouriteCollector;

  const HomePage({super.key, required this.onFavouriteToggle, required this.favouriteCollector});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<CartItem> cart = [];

  void addToCart(Collector collector) {
    setState(() {
      final cartItemIndex = cart.indexWhere((item) => item.collector.id == collector.id);

      if (cartItemIndex != -1) {
        cart[cartItemIndex].quantity++;
      } else {
        cart.add(CartItem(collector: collector, quantity: 1));
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${collector.title} добавлен в корзину'),)
    );
  }
  Future<void> _addNewNoteDialog(BuildContext context) async {
    String title = '';
    String description = '';
    String imageUrl = '';
    String cost = '';
    String article = '';

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Добавить новый сет'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Название'),
                onChanged: (value) {
                  title = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Описание'),
                onChanged: (value) {
                  description = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Картинка'),
                onChanged: (value){
                  imageUrl = value;
                }
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Цена'),
                onChanged: (value) {
                  cost = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Артикул'),
                onChanged: (value) {
                  article = value;
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Отмена'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Добавить'),
              onPressed: () {
                if (title.isNotEmpty && description.isNotEmpty && cost.isNotEmpty && article.isNotEmpty) {
                  setState(() {
                    collector.add(
                      Collector(
                        collector.length,
                        title,
                        description,
                        imageUrl,
                        cost,
                        article,
                      ),
                    );
                  });
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Коллектор Сеты'),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BasketPage(cart: cart)),
                  );
                },
              ),
              if (cart.isNotEmpty)
                Positioned(
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${cart.fold<int>(0, (previousValue, item) => previousValue + item.quantity)}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child:
        collector.isNotEmpty
        ?GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: collector.length,
          itemBuilder: (BuildContext context, int index) {
            final Collector collectorItem = collector[index];
            final isFavourite = widget.favouriteCollector.contains(collectorItem);
            final DismissDirection dismissDirection =
            index % 2 == 0 ? DismissDirection.endToStart : DismissDirection.startToEnd;
            return Dismissible(
              key: Key(collectorItem.id.toString()),
              direction: dismissDirection,
              onDismissed: (direction) {
              },
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: 40,
                      ),
                      onPressed: () {
                        setState(() {
                          collector.removeAt(index);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${collectorItem.title} был удален')),
                        );
                      },
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
              ),
              child: ItemNote(
                collector: collectorItem,
                isFavourite: isFavourite,
                  onFavouriteToggle: () => widget.onFavouriteToggle(collectorItem),
                onAddToCart: () => addToCart(collectorItem),
              ),
            );
          },
        )
          : const Center(child: Text('Нет доступных сетов')),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          child: FloatingActionButton(
            onPressed: () {
              _addNewNoteDialog(context);
            },
            child: const Icon(
              Icons.add,
              size: 40.0,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}