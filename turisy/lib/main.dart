import 'package:flutter/material.dart';
import 'package:turisy/model/mountain.dart';
import 'package:turisy/util/colors.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final MountainService mountainService = MountainService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: MyColors.primaryColor,
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.grey.shade400,
                            width: 2,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2),
                          child: ClipOval(
                            child: Image.network(
                              'https://randomuser.me/api/portraits/women/44.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Icon(
                        Icons.notifications_outlined,
                        color: MyColors.blackCoral,
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: 1.0,
                      ),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Where to next",
                        hintStyle: TextStyle(color: Colors.grey.shade500),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(8),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: FutureBuilder<List<Mountain>>(
                    future: mountainService.fetchMounts(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Center(
                          child: Text("An error has occurred."),
                        );
                      }

                      if (snapshot.hasData) {
                        return MountainPager(mounts: snapshot.data!);
                      }

                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            "https://images.pexels.com/photos/147411/italy-mountains-dawn-daybreak-147411.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Mount Yamnuska"),
                          const SizedBox(height: 4),
                          Text("Landscapes"),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: MyColors.indianRed,
                                size: 16,
                              ),
                              Text("4.4"),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: MyColors.blackCoral,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.home, color: MyColors.indianRed),
                      Icon(Icons.location_pin, color: MyColors.primaryColor),
                      Icon(Icons.calendar_month, color: MyColors.primaryColor),
                      Icon(Icons.person, color: MyColors.primaryColor),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MountainPager extends StatefulWidget {
  const MountainPager({super.key, required this.mounts});

  final List<Mountain> mounts;

  @override
  State<MountainPager> createState() => _MountainPagerState();
}

class _MountainPagerState extends State<MountainPager> {
  final PageController _controller = PageController(viewportFraction: 0.9);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _controller,
      itemCount: widget.mounts.length,
      padEnds: false,
      itemBuilder: (context, index) {
        final mountain = widget.mounts[index];

        return Padding(
          padding: const EdgeInsets.only(right: 12),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(mountain.imageUrl, fit: BoxFit.cover),
                Positioned(
                  left: 16,
                  bottom: 16,
                  child: Text(
                    mountain.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
