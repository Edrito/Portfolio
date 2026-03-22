import 'dart:convert';

import 'package:app/main.dart';
import 'package:app/resources/constants.dart';
import 'package:app/resources/home_state.dart';
import 'package:app/resources/item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:app/resources/item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:recase/recase.dart';
import 'package:riverpod/riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
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
          // toolbarHeight: 92,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                appTitle,
                textAlign: TextAlign.left,
              ),
              // Text(
              //   appDescription,
              //   textAlign: TextAlign.left,
              //   style: theme.textTheme.bodyMedium,
              // ),
              InkWell(
                onTap: () {
                  // Copy email to clipboard and show a snackbar
                  final scaffoldMessenger = ScaffoldMessenger.of(context);
                  Clipboard.setData(const ClipboardData(text: email));
                  scaffoldMessenger.showSnackBar(
                    const SnackBar(
                      content: Text('Email copied to clipboard'),
                      duration: Duration(seconds: 2),
                    ),
                  );

                  // Open default mail client with mailto link
                  final Uri mailUri = Uri(
                    scheme: 'mailto',
                    path: email,
                  );
                  launchUrl(mailUri);
                },
                child: Text(
                  email,
                  textAlign: TextAlign.left,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color:
                        Colors.blue, // Change color to indicate it's clickable
                    decoration: TextDecoration.underline, // Add underline
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Align(
          alignment: Alignment.topLeft,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 8,
              ),
              // Container(
              //   color: theme.colorScheme.onSurface.withAlpha(25),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.end,
              //     children: [
              //       // const Padding(
              //       //   padding: EdgeInsets.all(8.0),
              //       //   child: Row(
              //       //     mainAxisAlignment: MainAxisAlignment.end,
              //       //     children: [
              //       //       //Sort by
              //       //       // Padding(
              //       //       //   padding: const EdgeInsets.all(8.0),
              //       //       //   child: Text(
              //       //       //     "Sort by: ",
              //       //       //     style: theme.textTheme.titleMedium,
              //       //       //   ),
              //       //       // ),
              //       //       // DropdownMenu(
              //       //       //   enableSearch: false,
              //       //       //   enableFilter: false,
              //       //       //   dropdownMenuEntries: const [
              //       //       //     DropdownMenuEntry<String>(
              //       //       //       value: 'successState',
              //       //       //       label: 'Success',
              //       //       //     ),
              //       //       //     DropdownMenuEntry<String>(
              //       //       //       value: 'statusState',
              //       //       //       label: 'Status',
              //       //       //     ),
              //       //       //   ],
              //       //       //   initialSelection: ref.watch(homeState).sortBy,
              //       //       //   onSelected: (value) {
              //       //       //     ref.read(homeState.notifier).state =
              //       //       //         ref.read(homeState).copyWith(
              //       //       //               sortBy: value ?? "successState",
              //       //       //             );
              //       //       //   },
              //       //       // ),
              //       //       //Ascending/Descending
              //       //       // Padding(
              //       //       //   padding: const EdgeInsets.all(8.0),
              //       //       //   child: Text(
              //       //       //     "Order: ",
              //       //       //     style: theme.textTheme.titleMedium,
              //       //       //   ),
              //       //       // ),
              //       //       //Just do icons
              //       //       // IconButton(
              //       //       //   icon: Icon(
              //       //       //     ref.watch(homeState).isDescending
              //       //       //         ? Icons.arrow_downward
              //       //       //         : Icons.arrow_upward,
              //       //       //     color: theme.colorScheme.onSurface,
              //       //       //   ),
              //       //       //   onPressed: () {
              //       //       //     ref.read(homeState.notifier).state =
              //       //       //         ref.read(homeState).copyWith(
              //       //       //               isDescending:
              //       //       //                   !ref.read(homeState).isDescending,
              //       //       //             );
              //       //       //   },
              //       //       // ),
              //       //     ],
              //       //   ),
              //       // ),
              //       // const Spacer(),
              //       // Padding(
              //       //   padding: const EdgeInsets.all(8.0),
              //       //   child: Text(
              //       //     "Status:",
              //       //     style: theme.textTheme.titleMedium,
              //       //   ),
              //       // ),
              //       // const SizedBox(
              //       //   width: 100,
              //       // ),
              //       // Padding(
              //       //   padding: const EdgeInsets.all(8.0),
              //       //   child: Text(
              //       //     "Success:",
              //       //     style: theme.textTheme.titleMedium,
              //       //   ),
              //       // ),
              //       // const SizedBox(
              //       //   width: 140,
              //       // )
              //     ],
              //   ),
              // ),
              Expanded(
                child: FutureBuilder(
                    //Load  assets/items/items.json
                    future: DefaultAssetBundle.of(context)
                        .loadString('assets/items/items.json'),
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      final itemList = snapshot.data != null
                          ? (jsonDecode(snapshot.data ?? "")
                                  as Map<String, dynamic>)
                              .map(
                                (key, value) => MapEntry(
                                  key,
                                  Item.fromJson(value as Map<String, dynamic>),
                                ),
                              )
                              .values
                              .toList()
                          : <Item>[];

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              for (ItemScope scope in ItemScope.values)
                                Builder(builder: (context) {
                                  List<Widget> itemWidgets = itemList
                                      .where((item) => item.scope == scope)
                                      .toList();

                                  itemWidgets = itemWidgets
                                      .map((e) => Container(
                                            padding: const EdgeInsets.all(16),
                                            child: Container(
                                                decoration: BoxDecoration(
                                                  color: theme
                                                      .colorScheme.surface
                                                      .withAlpha(200),
                                                  border: Border.all(
                                                    color: theme
                                                        .colorScheme.onSurface
                                                        .withAlpha(100),
                                                    width: 1.35,
                                                  ),
                                                ),
                                                child: e),
                                          ))
                                      .toList();

                                  //Sort items based on HomeState

                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Container(
                                        color: theme.colorScheme.secondary
                                            .withAlpha(25),
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          scope.name.titleCase,
                                          style: theme.textTheme.headlineMedium,
                                        ),
                                      ),
                                      ListView(
                                          shrinkWrap: true,
                                          children: itemWidgets),
                                      const SizedBox(height: 24)
                                    ],
                                  );
                                }),
                            ],
                          ).animate().fadeIn().moveX(),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ));
  }
}
