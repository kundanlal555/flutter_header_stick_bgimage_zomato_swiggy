import 'package:flutter/material.dart';
// main.dart
import 'dart:ui';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "DMSans",
        useMaterial3: false,
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  double offset = 0;
  double imageHeight = 480;
  final double minAppBarHeight = kToolbarHeight; // collapsed
  final double maxAppBarHeight = 110; // expanded
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        offset = _scrollController.offset;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double appBarOpacity = (offset / 150).clamp(0, 1);
    print(appBarOpacity);
    return Scaffold(
      body: Stack(
        children: [
          // 🔥 BACKGROUND IMAGE THAT MOVES WITH SCROLL
          Transform.translate(
            offset: Offset(0, -offset),
            child: Container(
              height: imageHeight,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/banner.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          CustomScrollView(
            controller: _scrollController,
            physics: ClampingScrollPhysics(),
            slivers: [
              SliverAppBar(
                // 🔥 OPACITY FADE BACKGROUND
                backgroundColor: Colors.white.withOpacity(
                  appBarOpacity,
                ), // Fade effect
                elevation: 0,
                shadowColor: Colors.transparent,
                floating: true,
                pinned: true,
                snap: false,
                centerTitle: false,

                //expandedHeight:appBarOpacity? 100,
                title: Opacity(
                  opacity: 1 - appBarOpacity, // 🔥 OPPOSITE OPACITY
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '24x7-Quick',
                        style: TextStyle(color: Colors.white),
                      ),
                      const Text(
                        'Deliver in 30 min',
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                    ],
                  ),
                ),

                actions: [
                  Opacity(
                    opacity: 1 - appBarOpacity, // 🔥 OPPOSITE OPACITY
                    child: IconButton(
                      icon: const Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
                expandedHeight: lerpDouble(
                  maxAppBarHeight,
                  minAppBarHeight,
                  appBarOpacity,
                ),

                bottom: AppBar(
                  //toolbarHeight: 30,
                  backgroundColor: Colors.transparent,

                  shadowColor: Colors.transparent,
                  title: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),

                      border: Border.all(color: Colors.grey, width: 0.5),
                    ),
                    child: const Center(
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search for something',
                          prefixIcon: Icon(Icons.search),
                          suffixIcon: Icon(Icons.camera_alt),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: imageHeight - kToolbarHeight - 100),
              ),
              // SliverList with up to `maxItems` length — efficient builder
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  // Example item widget — customize as needed
                  return Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(child: Text('${index + 1}')),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Item #${index + 1}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'Description for this item goes here.',
                                style: TextStyle(fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }, childCount: 50),
              ),

              // optional tail padding
              SliverToBoxAdapter(child: SizedBox(height: 80)),
            ],
          ),
        ],
      ),
    );
  }
}
