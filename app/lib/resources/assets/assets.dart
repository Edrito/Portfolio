typedef FileDataClass = ({String path, (double, double)? size});

class IconsAssetsIcons {
  ///nzane.png
  static const FileDataClass nzane = (
    path: "assets/icons/nzane.png",
    size: (1200.0, 1200.0),
  );

  ///runefire.png
  static const FileDataClass runefire = (
    path: "assets/icons/runefire.png",
    size: (256.0, 256.0),
  );

  ///whispers.png
  static const FileDataClass whispers = (
    path: "assets/icons/whispers.png",
    size: (512.0, 512.0),
  );
  static List<String> allFiles = [
    nzane.path,
    runefire.path,
    whispers.path,
  ];
}

class ItemsAssetsItems {
  ///items.json
  static const FileDataClass items = (
    path: "assets/items/items.json",
    size: null,
  );
  static List<String> allFiles = [
    items.path,
  ];
}
