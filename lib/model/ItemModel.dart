class ItemModel {
  static List<Info> _itemInfoList = <Info>[]; // list to save the information

  static add(String n, String d) {
    _itemInfoList.add(Info(n, d));
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
  late String description;

  Info(String n, String d) {
    name = n;
    description = d;
  }

  @override
  String toString() {
    return "name: " + name + " | " + "description: " + description;
  }
}
