import 'package:flutter/material.dart';

class MarketPricesScreen extends StatefulWidget {
  const MarketPricesScreen({Key? key}) : super(key: key);

  @override
  State<MarketPricesScreen> createState() => _MarketPricesScreenState();
}

class _MarketPricesScreenState extends State<MarketPricesScreen> {
  String selectedType = 'All Crops';

  final List<Map<String, dynamic>> crops = [
    {
      'name': 'Tomato',
      'market': 'Local Market',
      'price': '₹45/kg',
      'trend': '+12%',
      'trendIcon': Icons.arrow_upward,
      'icon': Icons.local_pizza,
      'cropType': 'Vegetables',
    },
    {
      'name': 'Potato',
      'market': 'Wholesale',
      'price': '₹28/kg',
      'trend': '-5%',
      'trendIcon': Icons.arrow_downward,
      'icon': Icons.eco,
      'cropType': 'Vegetables',
    },
    {
      'name': 'Wheat',
      'market': 'Government Rate',
      'price': '₹2,125/q',
      'trend': '0%',
      'trendIcon': Icons.horizontal_rule,
      'icon': Icons.grain,
      'cropType': 'Grains',
    },
    {
      'name': 'Carrot',
      'market': 'Local Market',
      'price': '₹35/kg',
      'trend': '+8%',
      'trendIcon': Icons.arrow_upward,
      'icon': Icons.local_florist,
      'cropType': 'Vegetables',
    },
    {
      'name': 'Corn',
      'market': 'Wholesale',
      'price': '₹1,850/q',
      'trend': '+3%',
      'trendIcon': Icons.arrow_upward,
      'icon': Icons.emoji_food_beverage,
      'cropType': 'Grains',
    },
    {
      'name': 'Apple',
      'market': 'Local Market',
      'price': '₹120/kg',
      'trend': '+5%',
      'trendIcon': Icons.arrow_upward,
      'icon': Icons.apple,
      'cropType': 'Fruits',
    },
  ];

  List<Map<String, dynamic>> get filteredCrops {
    if (selectedType == 'All Crops') return crops;
    return crops.where((crop) => crop['cropType'] == selectedType).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Market Prices',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 8),
        child: ListView(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  child: const Icon(Icons.mic, color: Colors.black),
                ),
                title: const Text('Ask about market prices'),
                subtitle: const Text('Tap to speak in your language'),
                onTap: () {},
              ),
            ),
            const SizedBox(height: 12),
            // UPDATED: Wrapped the Row of chips in a horizontally scrolling view
            // to prevent the pixel overflow error.
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _chip('All Crops', selected: selectedType == 'All Crops'),
                  _chip('Vegetables', selected: selectedType == 'Vegetables'),
                  _chip('Fruits', selected: selectedType == 'Fruits'),
                  _chip('Grains', selected: selectedType == 'Grains'),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Trending Up',
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '12',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Text('crops', style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: const [
                          Text(
                            'Best Price',
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '₹45/kg',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            'tomatoes',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Current Prices',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            ...filteredCrops.map(
              (crop) => Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 12,
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey[200],
                        child: Icon(
                          crop['icon'] as IconData,
                          color: Colors.orange,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              crop['name'] as String,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              crop['market'] as String,
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            crop['price'] as String,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                crop['trendIcon'] as IconData,
                                color:
                                    (crop['trend'].toString().startsWith('-'))
                                        ? Colors.red
                                        : Colors.green,
                                size: 16,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                crop['trend'] as String,
                                style: TextStyle(
                                  color:
                                      (crop['trend'].toString().startsWith('-'))
                                          ? Colors.red
                                          : Colors.green,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _chip(String label, {bool selected = false}) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        selectedColor: Colors.black,
        backgroundColor: Colors.grey[200],
        labelStyle: TextStyle(
          color: selected ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
        ),
        onSelected: (_) {
          setState(() {
            selectedType = label;
          });
        },
      ),
    );
  }
}
