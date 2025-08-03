import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recase/recase.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';

enum ItemScope {
  personal,
  university,
  work,
}

enum ItemStatus {
  completed,
  inProgress,
  planned,
  cancelled;

  Color get color {
    switch (this) {
      case ItemStatus.completed:
        return Colors.green.shade100;
      case ItemStatus.inProgress:
        return Colors.blue.shade100;
      case ItemStatus.planned:
        return Colors.yellow.shade100;
      case ItemStatus.cancelled:
        return Colors.grey;
    }
  }
}

enum ItemSuccess {
  successful,
  moderateSuccess,
  minorSuccess,
  unsuccessful;

  Color get color {
    switch (this) {
      case ItemSuccess.successful:
        return Colors.green.shade300;
      case ItemSuccess.unsuccessful:
        return Colors.red.shade300;
      case ItemSuccess.moderateSuccess:
        return Colors.orange.shade300;
      case ItemSuccess.minorSuccess:
        return Colors.yellow.shade300;
    }
  }
}

final itemScrollProvider =
    Provider.family<CarouselSliderController, String>((ref, title) {
  return CarouselSliderController();
});

class Item extends ConsumerWidget {
  const Item({
    super.key,
    this.subtitle = "",
    this.tags,
    this.year = const (0, null),
    this.month,
    this.scope = ItemScope.personal,
    this.status = ItemStatus.completed,
    this.success = ItemSuccess.successful,
    this.positives = const [],
    this.negatives = const [],
    this.lessons = const [],
    this.description = "",
    this.title = "",
    this.images = const [],
    this.links = const [],
    this.imagesAreScreenshots = false,
    this.iconPath,
    this.techStack = "",
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    final item = Item(
      title: json['title'] as String? ?? "",
      subtitle: json['subtitle'] as String? ?? "",
      description: json['description'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.cast<String>(),
      images: (json['images'] as List<dynamic>?)?.cast<String>(),
      links: (json['links'] as List<dynamic>?)?.cast<String>() ?? [],
      imagesAreScreenshots: json['imagesAreScreenshots'] as bool? ?? false,
      year: (json['year'] as List<dynamic>?) != null
          ? (json['year'][0] as int, json['year'][1] as int?)
          : const (0, null),
      month: (json['month'] as List<dynamic>?) != null
          ? (json['month'][0] as int, json['month'][1] as int?)
          : null,
      scope: ItemScope.values.firstWhere(
        (e) => e.name == json['scope'],
        orElse: () => ItemScope.personal,
      ),
      status: ItemStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => ItemStatus.completed,
      ),
      success: ItemSuccess.values.firstWhere(
        (e) => e.name == json['success'],
        orElse: () => ItemSuccess.successful,
      ),
      positives: (json['positives'] as List<dynamic>?)?.cast<String>() ?? [],
      negatives: (json['negatives'] as List<dynamic>?)?.cast<String>() ?? [],
      iconPath: json['iconPath'] as String?,
      techStack: json['techStack'] as String? ?? "",
      lessons: (json['lessons'] as List<dynamic>?)?.cast<String>() ?? [],
    );
    return item;
  }

  final String? description;
  final String? iconPath;
  final List<String>? images;
  final List<String> links;
  final List<String> negatives;
  final List<String> positives;
  final ItemScope scope;
  final ItemStatus status;
  final String subtitle;
  final ItemSuccess success;
  final List<String>? tags;
  final String title;
  final bool imagesAreScreenshots;

  final String techStack;

  final List<String> lessons;

  final (int, int?) year;

  final (int, int?)? month;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeData = Theme.of(context);
    return ExpansionTile(
      key: ValueKey(title),
      leading: iconPath != null
          ? Image.asset(
              iconPath!,
              width: 64,
              height: 64,
            )
          : null,
      subtitle: Text(
        subtitle,
        style: themeData.textTheme.titleSmall,
        maxLines: 3,
      ),
      title: Row(
        children: [
          Expanded(
              child: Text(
            title,
            style: themeData.textTheme.titleMedium,
          )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                width: 150,
                color: status.color,
                child: Center(
                  child: Text(
                    status.name.titleCase,
                    style: themeData.textTheme.titleMedium
                        ?.copyWith(color: Colors.black87),
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                width: 150,
                color: success.color,
                child: Center(
                  child: Text(
                    success.name.titleCase,
                    style: themeData.textTheme.titleMedium
                        ?.copyWith(color: Colors.black87),
                  ),
                )),
          ),
        ],
      ),
      children: [
        if (techStack.isNotEmpty)
          Container(
            color: themeData.colorScheme.secondary,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SelectableText(
                    "Tech Stack",
                    style: themeData.textTheme.titleMedium
                        ?.copyWith(color: themeData.colorScheme.onPrimary),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SelectableText(
                    techStack,
                    style: themeData.textTheme.bodyMedium
                        ?.copyWith(color: themeData.colorScheme.onPrimary),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
          ),
        if (links.isNotEmpty)
          Container(
            color: themeData.colorScheme.surfaceContainerHighest,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SelectableText(
                    "Links",
                    style: themeData.textTheme.titleMedium
                        ?.copyWith(color: themeData.colorScheme.onSurface),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (final link in links)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: InkWell(
                            onTap: () async {
                              if (await canLaunchUrl(Uri.parse(link))) {
                                await launchUrl(Uri.parse(link));
                              }
                            },
                            child: Text(
                              link,
                              style: themeData.textTheme.bodyMedium?.copyWith(
                                color: themeData.colorScheme.primary,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        if (description != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SelectableText(
              description!,
              style: themeData.textTheme.bodyMedium,
            ),
          ),
        if (images != null && images!.isNotEmpty)
          SizedBox(
            height: 500,
            child: Stack(
              children: [
                Positioned.fill(
                  child: CarouselSlider(
                    options: CarouselOptions(
                      scrollDirection: Axis.horizontal,
                      enableInfiniteScroll: false,
                      height: 500,
                      viewportFraction: imagesAreScreenshots
                          ? 0.3
                          : 1, // Adjust viewport fraction based on screenshots
                    ),
                    carouselController: ref.watch(itemScrollProvider(title)),
                    items: [
                      for (final image in images ?? [])
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => Dialog(
                                  backgroundColor: Colors.transparent,
                                  child: InteractiveViewer(
                                    child: CachedNetworkImage(
                                      imageUrl: image,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: CachedNetworkImage(
                              imageUrl: image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                    ].animate().fadeIn(),
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                          onPressed: () {
                            final controller =
                                ref.read(itemScrollProvider(title));
                            controller.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut);
                          },
                          icon: const Icon(Icons.arrow_back_ios_new_rounded)),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                          onPressed: () {
                            final controller =
                                ref.read(itemScrollProvider(title));
                            controller.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut);
                          },
                          icon: const Icon(Icons.arrow_forward_ios_rounded)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        if (positives.isNotEmpty && negatives.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Positives",
                  style: themeData.textTheme.titleMedium,
                ),
                for (final positive in positives)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(positive),
                  ),
                const SizedBox(height: 16),
                Text(
                  "Challenges",
                  style: themeData.textTheme.titleMedium,
                ),
                for (final negative in negatives)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(negative),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}
