extension OnList on List {
  get(int index) {
    return index < length ? this[index] : null;
  }
}