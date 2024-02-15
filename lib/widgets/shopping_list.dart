import 'package:flutter/material.dart';

import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/widgets/new_item.dart';

class ShoppingList extends StatefulWidget {
  const ShoppingList({super.key});
  @override
  State<StatefulWidget> createState() {
    return _ShoppingListState();
  }
}

class _ShoppingListState extends State<ShoppingList> {
  final List<GroceryItem> _groceryItem = [];
  void _addItem() async {
    final newItem = await Navigator.of(context).push(
      MaterialPageRoute(builder: (ctx) => const NewItem()),
    );
    if (newItem == null) {
      return;
    }
    setState(() {
      _groceryItem.add(newItem);
    });
  }

  void _removeItem(GroceryItem item) {
    setState(() {
      _groceryItem.remove(item);
    });
  }

  @override
  Widget build(context) {
    Widget content = const Center(child: Text('No items added yet.'));
    if (_groceryItem.isNotEmpty) {
      content = ListView.builder(
        itemCount: _groceryItem.length,
        itemBuilder: (ctx, index) => Dismissible(
          onDismissed: (direction) {
            _removeItem(
              _groceryItem[index],
            );
          },
          key: ValueKey(_groceryItem[index].id),
          child: ListTile(
            title: Text(
              _groceryItem[index].name,
            ),
            leading: Container(
              width: 24,
              height: 24,
              color: _groceryItem[index].category.color,
            ),
            trailing: Text(
              _groceryItem[index].quantity.toString(),
            ),
          ),
        ),
      );
    }
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Your groceries",
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Theme.of(context).colorScheme.primary),
          ),
          actions: [
            IconButton(
              onPressed: () {
                _addItem();
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: content);
  }
}
