import 'package:equatable/equatable.dart';

enum ViewState { initial, loading, error, hasData, noData, lazyLoading }

extension ViewStateExtension on ViewState {
  bool get isLoading => this == ViewState.loading;

  bool get isInitial => this == ViewState.initial;

  bool get isError => this == ViewState.error;

  bool get isHasData => this == ViewState.hasData;

  bool get isNoData => this == ViewState.noData;

  bool get isLazyLoading => this == ViewState.lazyLoading;
}

class ViewData<T> extends Equatable {
  final ViewState status;
  final T? data;
  final String message;

  const ViewData._({
    required this.status,
    this.data,
    this.message = '',
  });

  factory ViewData.loaded({T? data}) {
    return ViewData._(status: ViewState.hasData, data: data);
  }

  factory ViewData.loading({String? message}) {
    return ViewData._(status: ViewState.loading, message: message ?? '');
  }

  factory ViewData.lazyLoading({T? data}) {
    return ViewData._(status: ViewState.lazyLoading, data: data);
  }

  factory ViewData.error({
    required String message,
    T? currentData,
  }) {
    return ViewData._(
      status: ViewState.error,
      message: message,
      data: currentData,
    );
  }

  factory ViewData.initial() => const ViewData._(status: ViewState.initial);

  factory ViewData.noData({required String message}) {
    return ViewData._(status: ViewState.noData, message: message);
  }

  @override
  List<Object?> get props => [
        status,
        data,
        message,
      ];
}
