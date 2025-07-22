import 'dart:convert';

import 'package:app/main.dart';
import 'package:app/resources/constants.dart';
import 'package:app/resources/home_state.dart';
import 'package:app/widgets/item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:app/widgets/item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:recase/recase.dart';
import 'package:riverpod/riverpod.dart';
import 'package:visibility_detector/visibility_detector.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(homeState).isDarkMode;
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final isPortrait = size.width < size.height;
    return Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                appTitle,
                textAlign: TextAlign.left,
              ),
              Text(
                appDescription,
                textAlign: TextAlign.left,
                style: theme.textTheme.bodySmall,
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(
                isDarkMode ? Icons.light_mode : Icons.dark_mode,
                color: Colors.white,
              ),
              onPressed: () {
                ref.read(homeState.notifier).state =
                    ref.read(homeState).copyWith(
                          isDarkMode: !isDarkMode,
                        );
              },
            ),
          ],
        ),
        body: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 8,
                ),
                Container(
                  color: theme.colorScheme.onSurface.withAlpha(25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            //Sort by
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Sort by: ",
                                style: theme.textTheme.titleMedium,
                              ),
                            ),
                            DropdownMenu(
                              enableSearch: false,
                              enableFilter: false,
                              dropdownMenuEntries: const [
                                DropdownMenuEntry<String>(
                                  value: 'successState',
                                  label: 'Success',
                                ),
                                DropdownMenuEntry<String>(
                                  value: 'statusState',
                                  label: 'Status',
                                ),
                              ],
                              initialSelection: ref.watch(homeState).sortBy,
                              onSelected: (value) {
                                ref.read(homeState.notifier).state =
                                    ref.read(homeState).copyWith(
                                          sortBy: value ?? "successState",
                                        );
                              },
                            ),
                            //Ascending/Descending
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Order: ",
                                style: theme.textTheme.titleMedium,
                              ),
                            ),
                            //Just do icons
                            IconButton(
                              icon: Icon(
                                ref.watch(homeState).isDescending
                                    ? Icons.arrow_downward
                                    : Icons.arrow_upward,
                              ),
                              onPressed: () {
                                ref.read(homeState.notifier).state =
                                    ref.read(homeState).copyWith(
                                          isDescending:
                                              !ref.read(homeState).isDescending,
                                        );
                              },
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Status:",
                          style: theme.textTheme.titleMedium,
                        ),
                      ),
                      const SizedBox(
                        width: 100,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Success:",
                          style: theme.textTheme.titleMedium,
                        ),
                      ),
                      const SizedBox(
                        width: 140,
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: FutureBuilder(
                      //Load  assets/items/items.json
                      future: DefaultAssetBundle.of(context)
                          .loadString('assets/items/items.json'),
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        final itemList = snapshot.data != null
                            ? (jsonDecode(snapshot.data ?? "")
                                    as Map<String, dynamic>)
                                .map(
                                  (key, value) => MapEntry(
                                    key,
                                    Item.fromJson(
                                        value as Map<String, dynamic>),
                                  ),
                                )
                                .values
                                .toList()
                            : <Item>[];

                        return SingleChildScrollView(
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              for (ItemScope scope in ItemScope.values)
                                Builder(builder: (context) {
                                  final itemWidgets = itemList
                                      .where((item) => item.scope == scope)
                                      .toList();

                                  //Sort items based on HomeState
                                  itemWidgets.sort((a, b) {
                                    final homeStateClass = ref.watch(homeState);
                                    if (homeStateClass.sortBy ==
                                        "successState") {
                                      return homeStateClass.isDescending
                                          ? a.status.index
                                              .compareTo(b.status.index)
                                          : b.status.index
                                              .compareTo(a.status.index);
                                    } else if (homeStateClass.sortBy ==
                                        "statusState") {
                                      return homeStateClass.isDescending
                                          ? a.success.index
                                              .compareTo(b.success.index)
                                          : b.success.index
                                              .compareTo(a.success.index);
                                    }
                                    return 0;
                                  });
                                  return ExpansionTile(
                                    title: Text(scope.name.toUpperCase()),
                                    initiallyExpanded: true,
                                    children: [
                                      VisibilityDetector(
                                          key: Key(scope.name),
                                          onVisibilityChanged:
                                              (visibilityInfo) {
                                            if (visibilityInfo.visibleFraction >
                                                0.1) {
                                              print('${scope.name} is visible');
                                            }
                                          },
                                          child: ListView(
                                            shrinkWrap: true,
                                            children:
                                                itemWidgets.animate().fadeIn(),
                                          )),
                                    ],
                                  );
                                }),
                            ],
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ));
  }
}
