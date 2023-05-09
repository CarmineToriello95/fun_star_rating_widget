import 'package:flutter/material.dart';
import 'fun_star_rating_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                _buildProductStatsSection(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 40.0,
                  ),
                  child: _buildProductDescription(),
                ),
              ],
            ),
            Positioned(
              top: 375,
              left: 20,
              child: _buildQuantityButton(),
            ),
          ],
        ),
      );

  Widget _buildQuantityButton() {
    const space = SizedBox(
      width: 8.0,
    );
    final removeIcon = IconButton(
      onPressed: () {},
      icon: const Icon(
        Icons.remove,
        color: Colors.white,
      ),
    );
    final addIcon = IconButton(
      onPressed: () {},
      icon: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
    return Container(
      decoration: BoxDecoration(
        color: Colors.orange.shade900,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          removeIcon,
          space,
          const Text(
            "2",
            style: TextStyle(color: Colors.white),
          ),
          space,
          addIcon
        ],
      ),
    );
  }

  Widget _buildProductStatsSection() => Stack(
        children: [
          Container(
            height: 400,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(
                  30,
                ),
              ),
            ),
          ),
          Positioned(
            top: 100,
            left: 20,
            child: _buildStatsWidget(),
          )
        ],
      );

  Widget _buildProductDescription() => Column(
        children: [
          _buildProductDescriptionHeader(),
          const SizedBox(
            height: 24.0,
          ),
          const SizedBox(
            height: 300,
            child: SingleChildScrollView(
              child: Text(
                "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.",
                style:
                    TextStyle(fontSize: 16.0, height: 1.5, color: Colors.grey),
              ),
            ),
          )
        ],
      );

  Widget _buildProductDescriptionHeader() => Row(
        children: [
          const Text(
            "Orange Juice",
            style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            width: 32.0,
          ),
          _buildRatingWidget(),
        ],
      );

  Widget _buildRatingWidget() => FunStarRatingWidget(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            5,
            (index) => const Icon(
              Icons.star,
              color: Colors.yellow,
            ),
          ),
        ),
      );

  Widget _buildStatsWidget() {
    const space = SizedBox(
      height: 32.0,
    );
    return Column(
      children: [
        _buildStats(
          title: "Carbohydrate",
          mainText: "10%",
          secondaryText: "20g",
        ),
        space,
        _buildStats(
          title: "Water",
          mainText: "2.20%",
        ),
        space,
        _buildStats(
          title: "Price",
          mainText: "9.50",
          secondaryText: "USD",
        ),
      ],
    );
  }

  Widget _buildStats({
    required String title,
    required String mainText,
    String? secondaryText,
  }) {
    final descr = Text(
      title,
      style: const TextStyle(color: Colors.grey),
    );
    final mT = Text(
      mainText,
      style: const TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
      ),
    );
    const space = SizedBox(
      width: 4.0,
    );
    final sT = Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Text(
        secondaryText ?? "",
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        descr,
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            mT,
            space,
            if (secondaryText != null) sT,
          ],
        )
      ],
    );
  }
}
