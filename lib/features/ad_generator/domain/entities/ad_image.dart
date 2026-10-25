/// Domain entity representing a product image selected for ad generation.
class AdImage {
  final String path;
  final String? name;

  const AdImage({
    required this.path,
    this.name,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdImage &&
          runtimeType == other.runtimeType &&
          path == other.path;

  @override
  int get hashCode => path.hashCode;

  @override
  String toString() => 'AdImage(path: $path, name: $name)';
}
