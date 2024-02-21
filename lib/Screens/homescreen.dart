import 'package:flutter/material.dart';

import '../Api/apimodel.dart';
import '../Constants/constants.dart';
import 'imagescreen.dart';
import 'search.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final UnsplashService _unsplashService = UnsplashService();
  List<UnsplashImage> _images = [];

  late FocusNode _focusNode; // Initialize FocusNode
  late TextEditingController
      _textController; // Initialize TextEditingController

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode(); // Assign FocusNode
    _textController = TextEditingController(); // Assign TextEditingController
  }

  @override
  void dispose() {
    _focusNode.dispose(); // Dispose FocusNode
    _textController.dispose(); // Dispose TextEditingController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Text(
                  'Hello, User!',
                  style: TextStyle(
                    fontSize: 25,
                    color: text,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Search(
                          focusNode: _focusNode,
                          textController: _textController,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.09,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 4.5,
                          left: 3.0,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.06,
                            width: MediaQuery.of(context).size.width * 0.95,
                            decoration: BoxDecoration(
                              color: text,
                              borderRadius: BorderRadius.circular(25.0),
                              border: Border.all(
                                color: const Color.fromARGB(255, 0, 0, 0)!,
                                width: 3.0,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width * 0.95,
                          decoration: BoxDecoration(
                            color: primary,
                            borderRadius: BorderRadius.circular(25.0),
                            border: Border.all(
                              color: const Color.fromARGB(255, 0, 0, 0)!,
                              width: 3.0,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Text(
                                  'Search for images...',
                                  style: TextStyle(
                                    color: text2,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.search,
                                  color: text2,
                                ),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.03,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Text(
                  'Trending Images',
                  style: TextStyle(
                    fontSize: 18,
                    color: text,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              FutureBuilder(
                future: _unsplashService.fetchTrendingImages(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<UnsplashImage> images =
                        snapshot.data as List<UnsplashImage>;
                    return Container(
                      height: MediaQuery.of(context).size.height * 1,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // Set the number of columns
                            crossAxisSpacing:
                                8.0, // Set the spacing between columns
                            mainAxisSpacing:
                                8.0, // Set the spacing between rows
                          ),
                          itemCount: images.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ImageScreen(
                                        image: images[index],
                                      ),
                                    ),
                                  );
                                },
                                child: Stack(
                                  children: [
                                    Positioned(
                                      top: 4.5,
                                      left: 3.0,
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.25,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 0, 0, 0),
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.25,
                                      width: MediaQuery.of(context).size.width *
                                          0.46,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        border: Border.all(
                                          color: const Color.fromARGB(
                                              255, 0, 0, 0)!,
                                          width: 3.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              images[index].imageUrl),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ],
                                ));
                          },
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.03,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Text(
                  'Pin Images',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
