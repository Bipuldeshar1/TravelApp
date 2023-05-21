import 'package:flutter/material.dart';
import 'package:project_3/const/style.dart';

import 'package:project_3/widgets/components/Bottom_Section.dart';

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
                  const Text(
                    'LOgo',
                    style: TextStyle(fontSize: 15),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.notifications_active,
                    ),
                  ),
                ],
              ),
            ),
            const SliverToBoxAdapter(
              child: Text(
                'where do you! \n want  go?',
                style: TextStyle(fontSize: 50),
              ),
            ),
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
              child: LabelSection(text: 'recommened', style: heading1),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),
            SliverToBoxAdapter(
              child: TopSection(),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),
            SliverToBoxAdapter(
              child: LabelSection(text: 'Allposts', style: heading1),
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
