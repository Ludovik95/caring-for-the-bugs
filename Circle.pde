class Circle {
  int MAX_RADIUS = 400;
  int MIN_RADIUS = 10;
  int MAX_ALPHA = 180;
  PImage CIRCLE_IMAGE = loadImage("blurredCircle.png");

  int radius = 100;
  int widthImage = radius * 2 * (1600 / 1200);
  int heightImage = radius * 2 * (1600 / 1200);
  color _color = color(random(0, 255), 255, 255, MAX_ALPHA);
  PImage image;

  Circle() {
    setRadius(radius);
  }

  color getColor() {
    return _color;
  }

  PImage getImage() {
    return image.get();
  }

  void setColor(color newColor) {
    _color = newColor;
  }

  void setRadius(int newRadius) {
    radius = newRadius;
    widthImage = radius * 2 * (1600 / 1200);
    heightImage = radius * 2 * (1600 / 1200);
    // This takes a lot of time, maybe can be optimized?
    image = CIRCLE_IMAGE.get();
    image.resize(widthImage, heightImage);
  }

  void changeHue(int delta) {
    if (hue(_color) + delta < 255 & hue(_color) + delta > 0) {
      setColor(color(hue(_color) + delta, 255, 255, alpha(_color)));
    }
  }

  void changeAlpha(int delta) {
    if (alpha(_color) + delta < MAX_ALPHA & alpha(_color) + delta > 0) {
      setColor(color(hue(_color), 255, 255, alpha(_color) + delta));
    }
  }

  void changeRadius(int delta) {
    if (radius + delta < MAX_RADIUS & radius + delta > MIN_RADIUS) {
      radius += delta;
      setRadius(radius);
    }
  }
}
