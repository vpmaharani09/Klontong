class PaginateList<T> {
  final int itemMax;
  final int itemCount;
  final List<T> data;

  PaginateList({
    this.itemMax = 0,
    this.itemCount = 0,
    required this.data,
  });

  factory PaginateList.fromJson(Map<String, dynamic> json, List<T> data) {
    return PaginateList(
      itemMax: json['itemMax'],
      itemCount: json['itemCount'],
      data: data,
    );
  }
}
