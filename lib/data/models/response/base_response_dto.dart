class BaseResponseDto<T> {
  String? message;
  bool status;
  T? data;

  BaseResponseDto({this.message, this.data, this.status = false});

  factory BaseResponseDto.fromJson(Map<String, dynamic> json,
      {T Function(Map<String, dynamic>)? fromJson}) {
    return BaseResponseDto(
      message: json['message'],
      status: json['status'] ?? true,
      data: json['data'] == null
          ? null
          : fromJson != null
              ? fromJson(json['data'])
              : json['data'],
    );
  }

  Map<String, dynamic> toJson({Map<String, dynamic> Function(T)? toJson}) {
    return {
      'message': message,
      'status': status,
      if (data != null) 'data': toJson != null ? toJson(data!) : data,
    };
  }
}
