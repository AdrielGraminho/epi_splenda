class Item {
  final int idItem;
  final String description;
  final int durability;
  final int? idExit;

  Item(
      {required this.idItem,
      required this.description,
      required this.durability,
      this.idExit});
}
