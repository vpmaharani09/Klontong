enum SourceImageEnum { camera, gallery }

extension SourceImageEnumExtension on SourceImageEnum {
  static SourceImageEnum? fromStringKey(String key) {
    if (key == SourceImageEnum.camera.key) {
      return SourceImageEnum.camera;
    } else if (key == SourceImageEnum.gallery.key) {
      return SourceImageEnum.gallery;
    } else {
      return null;
    }
  }

  String get keyFriendly {
    switch (this) {
      case SourceImageEnum.camera:
        return 'camera';
      case SourceImageEnum.gallery:
        return 'gallery';
    }
  }

  String get key {
    switch (this) {
      case SourceImageEnum.camera:
        return 'camera';
      case SourceImageEnum.gallery:
        return 'gallery';
    }
  }
}
