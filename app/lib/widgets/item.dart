import 'package:flutter/material.dart';

enum ItemScope {
  university,
  personal,
  work,
}

enum ItemStatus {
  completed,
  inProgress,
  planned,
  cancelled,
}

enum ItemSuccess {
  successful,
  failure,
  moderateSuccess,
}

class Item extends StatelessWidget {
  const Item({
    super.key,
    this.links = const [],
    this.title,
    this.tags,
    this.description,
    this.images,
  });

  final List<String> links;
  final String? title;
  final List<String>? tags;
  final String? description;
  final List<String>? images;

  static const topRight = Alignment(.9, -.9);
  static const topLeft = Alignment(-.9, -.9);
  static const bottomRight = Alignment(.9, .9);
  static const bottomLeft = Alignment(-.9, .9);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Column(
            children: [
              Text(title ?? "Title"),
              Text(description ?? "Description"),
            ],
          ),
        )
      ],
    );
  }
}
