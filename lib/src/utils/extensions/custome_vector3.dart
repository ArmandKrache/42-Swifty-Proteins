import 'package:three_dart/three_dart.dart' as three;

extension Vector3Extensions on three.Vector3 {
  /// Sets this vector's components from [other].
  void setFrom(three.Vector3 other) {
    set(other.x, other.y, other.z);
  }
}