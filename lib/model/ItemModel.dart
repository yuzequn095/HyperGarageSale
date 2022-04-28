/*
 * The item model.
 * Item name, Item price, Item Description
 * Return a List to store information above
 */
class ItemModel {
  static final List<Info> _itemInfoList =
      <Info>[]; // list to save the information

  static add(String name, String price, String description) {
    _itemInfoList.add(Info(name, price, description));
    // test code
    print("List Count: " + _itemInfoList.length.toString());
  }

  static Future<List<Info>> readAll() async {
    final _tempItemInfoList = await _itemInfoList;
    return _tempItemInfoList;
  }
}

class Info {
  late String name;
  late String price;
  late String description;

  Info(String itemName, String itemPrice, String itemDescription) {
    name = itemName;
    price = itemPrice;
    description = itemDescription;
  }

  @override
  String toString() {
    return "name: " +
        name +
        " | " +
        "price" +
        price +
        "|" +
        "description: " +
        description;
  }
}
