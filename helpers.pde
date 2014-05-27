class Point {
  float x, y;

  Point(float a, float b) {
    x = a;
    y = b;
  }
}

class Size {
  float width, height;

  Size(float w, float h) {
    width = w;
    height = h;
  }
}

class Rect {
  Point point;
  Size size;

  Rect(x, y, width, height) {
    point = new Point(x, y);
    size = new Size(width, height);
  }

  boolean containsPoint(Point p) {
    return (p.x >= point.x && p.x <= point.x + size.width) &&
      (p.y >= point.y && p.y <= point.y + size.height);
  }
}
