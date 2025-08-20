mixin Mappable<T> {
  Map<String, dynamic> toJson(T value);

  T fromJson(Map<String, dynamic> json);
}