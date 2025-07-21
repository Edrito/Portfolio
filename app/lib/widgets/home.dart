import 'package:app/widgets/item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:app/widgets/item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:visibility_detector/visibility_detector.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isPortrait = size.width < size.height;
    return Scaffold(
        backgroundColor: Colors.blueGrey.shade900,
        body: SingleChildScrollView(
          child: StaggeredGrid.count(
            crossAxisCount: isPortrait ? 1 : 2,
            children: [
              for (int i = 0; i < 10; i++)
                Builder(builder: (context) {
                  AnimationController? tempController;
                  return VisibilityDetector(
                    key: Key('item-$i'),
                    onVisibilityChanged: (visibilityInfo) {
                      if (visibilityInfo.visibleFraction > 0.3) {
                        tempController?.forward();
                      }
                    },
                    child: SizedBox(
                      height: (i == 0 ? 125 + 250 : 250) * 3,
                      child: Item(
                        title: 'Item $i',
                        tags: const ['tag1', 'tag2', 'tag3'],
                      ),
                    )
                        .animate(
                          onInit: (controller) =>
                              tempController = controller..reset(),
                          onPlay: (controller) => controller.reset(),
                        )
                        .moveY()
                        .fadeIn(),
                  );
                }),
            ],
          ),
        ));
  }
}
