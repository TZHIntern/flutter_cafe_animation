class DessertItems {
  late String id;
  late String name;
  late String description;
  late String image;
  late String calories;
  late double price;

  DessertItems(
      {required this.id,
      required this.name,
      required this.description,
      required this.image,
      required this.calories,
      required this.price});

  static List<DessertItems> dessert = [
    DessertItems(
        id: '1',
        name: 'Newyork Cheese cake',
        description:
            'One of the creamiest cheesecakes you\'ll ever taste with a crumbly biscuit base.',
        image: 'assets/dessert/TREAT_0.png',
        calories: '2195 KJ',
        price: 6.34),
    DessertItems(
        id: '2',
        name: 'Strawberry Jam Filled Donut',
        description:
            'A traditional soft and tasy donut, iced with strawberry glaze and filled with strawberry jam.',
        image: 'assets/dessert/TREAT_1.png',
        calories: '1292 KJ',
        price: 4.23),
    DessertItems(
        id: '3',
        name: 'Chocolate Jam Filled Donut',
        description:
            'A traditional soft and tasy donut, iced with strawberry glaze and filled with chocolate jam.',
        image: 'assets/dessert/TREAT_2.png',
        calories: '1207 KJ',
        price: 3.23),
    DessertItems(
        id: '4',
        name: 'Galaxy Donut',
        description:
            'A traditional soft and delicious donut iced with either pink or blue galaxy style glaze.',
        image: 'assets/dessert/TREAT_3.png',
        calories: '1252 KJ',
        price: 5.38),
    DessertItems(
        id: '5',
        name: 'Chocolate Raspberyy Mudcake',
        description:
            'A dense and decadently rich flourless chocolate cake made completely from plant-based ingredients',
        image: 'assets/dessert/TREAT_4.png',
        calories: '2916 KJ',
        price: 6.69),
    DessertItems(
        id: '6',
        name: 'Donut Cookie',
        description:
            'One of the creamiest cheesecakes you\'ll ever taste with a crumbly biscuit base.',
        image: 'assets/dessert/TREAT_5.png',
        calories: '705 KJ',
        price: 3.13),
    DessertItems(
        id: '7',
        name: 'Chocolate Chip Cookie',
        description:
            'Baked to perfection by one of Melbourne’s best small-batch bakehouses with generous chunks of milk chocolate. So soft, so chewy, so snackable!',
        image: 'assets/dessert/TREAT_6.png',
        calories: '978 KJ',
        price: 5.13)
  ];
}
