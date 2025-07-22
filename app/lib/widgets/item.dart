import 'package:flutter/material.dart';
import 'package:recase/recase.dart';

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
  unsuccessful,
  minorSuccess,
  moderateSuccess;

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

class Item extends StatelessWidget {
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

  final String techStack;

  final List<String> lessons;

  final (int, int?) year;

  final (int, int?)? month;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return ExpansionTile(
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
        if (description != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              description!,
              style: themeData.textTheme.bodyMedium,
            ),
          ),
        if (images != null && images!.isNotEmpty)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              height: 250,
              child: Row(
                children: [
                  for (final image in images ?? [])
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(
                        image,
                        fit: BoxFit.cover,
                      ),
                    ),
                ],
              ),
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
