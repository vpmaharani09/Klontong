enum UnitDisplayEnum {
  kg,
  gr,
  ons,
  l,
  ml,
}

extension UnitDisplayEnumExtension on UnitDisplayEnum {
  bool get isKg => this == UnitDisplayEnum.kg;
  bool get isGr => this == UnitDisplayEnum.gr;
  bool get isOns => this == UnitDisplayEnum.ons;
  bool get isL => this == UnitDisplayEnum.l;
  bool get isMl => this == UnitDisplayEnum.ml;
}
