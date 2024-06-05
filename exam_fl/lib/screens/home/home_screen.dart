import 'package:exam_fl/models/PlaceModel.dart';
import 'package:exam_fl/service/place_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  List catNames = [
    'Hotels',
    'Flights',
    'All',
  ];

  List<Color> catColors = [
    Color(0xFFFC7F7F),
    Color(0xFFCB84FB),
    Color(0xFF78E667),
  ];

  List<Icon> catIcons = [
    const Icon(
      Icons.villa,
      color: Colors.white,
      size: 30,
    ),
    const Icon(Icons.flight_takeoff, color: Colors.white, size: 30),
    const Icon(Icons.assessment, color: Colors.white, size: 30),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      top: 15, right: 15, bottom: 10, left: 15),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF8B66E7),
                        Color(0xFF6558CE),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 3, bottom: 15),
                        child: Text(
                          "Hi Son SM!",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 3, bottom: 15, top: 20),
                        child: Text(
                          "Where are you going next?",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                            wordSpacing: 2,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        height: 50,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 150,
                  left: 20,
                  right: 20,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 55,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search your destination",
                        hintStyle:
                            TextStyle(color: Colors.black.withOpacity(0.5)),
                        prefixIcon: const Icon(
                          Icons.search,
                          size: 25,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50, left: 15, right: 15),
              child: Column(
                children: [
                  GridView.builder(
                    itemCount: catNames.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1.1,
                    ),
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            width: 120,
                            height: 70,
                            decoration: BoxDecoration(
                                color: catColors[index],
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: catIcons[index],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            catNames[index],
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black.withOpacity(0.7)),
                          )
                        ],
                      );
                    },
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Popular destination",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                    ],
                  ),
                  const SizedBox(height: 10),
                  _buildContent(context),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: CustomBottomAppBar(
          onChanged: (selectedMenu) {},
        ));
  }

  Widget _buildContent(BuildContext context) {
    return FutureBuilder<List<PlaceModel>>(
      future: PlaceService.fetchPlace(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<PlaceModel> places = snapshot.data!;
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemCount: places.length,
            itemBuilder: (context, index) {
              final PlaceModel place = places[index];
              return InkWell(
                onTap: () {},
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF5F3FF),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          place.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 25,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                place.name,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, bottom: 20),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 20),
                                color: Colors.white.withOpacity(0.6),
                                child:  Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                      size: 15,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      "${place.star.toString()}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class CustomBottomAppBar extends StatefulWidget {
  CustomBottomAppBar({this.onChanged});

  final Function(BottomBarEnum)? onChanged;

  @override
  _CustomBottomAppBarState createState() => _CustomBottomAppBarState();
}

class _CustomBottomAppBarState extends State<CustomBottomAppBar> {
  BottomBarEnum selectedMenu = BottomBarEnum.Home;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      child: SizedBox(
        height: kBottomNavigationBarHeight +
            MediaQuery.of(context).viewInsets.bottom,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            bottomMenuList.length,
            (index) {
              final BottomMenuModel menuItem = bottomMenuList[index];
              final bool isSelected = selectedMenu == menuItem.type;
              return InkWell(
                onTap: () {
                  setState(() {
                    selectedMenu = menuItem.type;
                  });
                  widget.onChanged?.call(menuItem.type);
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : null,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Opacity(
                        opacity: isSelected ? 1.0 : 0.6,
                        child: Icon(
                          menuItem.icon,
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                      ),
                      if (isSelected)
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Text(
                            menuItem.title ?? "",
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

enum BottomBarEnum {
  Home,
  Search,
  JD,
  Profile,
}

class BottomMenuModel {
  BottomMenuModel({
    required this.icon,
    required this.title,
    required this.type,
  });

  IconData icon;
  String? title;
  BottomBarEnum type;
}

final List<BottomMenuModel> bottomMenuList = [
  BottomMenuModel(
    icon: Icons.home,
    title: "Home",
    type: BottomBarEnum.Home,
  ),
  BottomMenuModel(
    icon: Icons.video_library,
    title: "Search",
    type: BottomBarEnum.Search,
  ),
  BottomMenuModel(
    icon: Icons.home_repair_service_sharp,
    title: "JD",
    type: BottomBarEnum.JD,
  ),
  BottomMenuModel(
    icon: Icons.person,
    title: "Profile",
    type: BottomBarEnum.Profile,
  )
];
