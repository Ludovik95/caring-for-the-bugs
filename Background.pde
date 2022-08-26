class Background {
  PGraphics canvas;
  PGraphics oldCanvas;
  color backgroundColor = color(200, 150, 0);
  Circle circle;

  // ArrayList<Circle> list = new ArrayList<Circle>();
  int backWidth;
  int backHeight;

  Background(int w, int h) {
    backWidth = w;
    backHeight = h;
    oldCanvas = createGraphics(w, h);
    canvas = createGraphics(w, h);
    oldCanvas.beginDraw();
    oldCanvas.background(backgroundColor);
    oldCanvas.endDraw();
    circle = new Circle();
    update();
  }

  // Draw the background
  void plot() {
    image(canvas.get(), backWidth/2, backHeight/2);
  }

  // Update the background, first drawing the older background and then the circle
  void update() {
    canvas.beginDraw();
    canvas.image(oldCanvas.get(), 0, 0);
    canvas.tint(circle.getColor());
    canvas.image(circle.getImage(), mouseX - circle.widthImage / 2, mouseY - circle.heightImage / 2);
    canvas.noTint();
    canvas.endDraw();
  }

  // Draw the circle on the background permanently
  void drawCircle() {
    oldCanvas.set(0, 0, canvas.get());
    update();
  }

  // Update circle parameters
  void updateCircle(String param, int x) {
    switch(param) {
    case "radius":
      circle.changeRadius(x);
      break;

    case "hue":
      circle.changeHue(x);
      break;

    case "alpha":
      circle.changeAlpha(x);
      break;

    default:
      println("invalid parameter");
      break;
    }
  }
}
