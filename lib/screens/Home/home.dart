import 'package:flutter/material.dart';
import 'package:project_3/const/style.dart';
import 'package:project_3/screens/Home/nnotification.dart';
import 'package:project_3/screens/Home/seeAll.dart';

import 'package:project_3/widgets/components/Bottom_Section.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

import 'package:project_3/widgets/components/Top_Section.dart';
import 'package:project_3/widgets/search.dart';

import '../../widgets/components/Label_Section.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 10,
              ),
            ),
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.flutter_dash,
                    size: 40,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NotificationScreen()));
                    },
                    icon: Icon(
                      Icons.notifications_active_rounded,
                    ),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
                child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3), // Shadow color
                    spreadRadius: 2, // Shadow spread radius
                    blurRadius: 5, // Shadow blur radius
                    offset: Offset(0, 3), // Shadow offset
                  )
                ],
              ),
              width: double.infinity,
              height: 200,
              child: ImageSlideshow(
                autoPlayInterval: 2000,
                isLoop: true,
                children: [
                  Image.asset(
                    'lib/assets/1.jpg',
                    fit: BoxFit.fill,
                  ),
                  Image.asset(
                    'lib/assets/2.jpg',
                    fit: BoxFit.fill,
                  ),
                  Image.asset(
                    'lib/assets/3.jpg',
                    fit: BoxFit.fill,
                  ),
                ],
              ),
            )),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 10,
              ),
            ),
            SliverToBoxAdapter(
              child: SearchSection(),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),
            SliverToBoxAdapter(
              child: LabelSection(
                text: 'recommened',
                style: heading1,
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),
            SliverToBoxAdapter(
              child: TopSection(),
            ),
            SliverToBoxAdapter(
              child: LabelSection(
                text: 'Allposts',
                style: heading1,
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),
            SliverToBoxAdapter(
              child: BottomSection(),
            )
          ],
        ),
      ),
    );
  }
}
