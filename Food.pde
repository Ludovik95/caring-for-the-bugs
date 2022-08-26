class Food {
  int diameter = 3;
  PVector position;

  Food(PVector ini_pos) {
    position = ini_pos.copy();
  }

  void plot() {
    fill(255, 0, 255);
    circle(position.x, position.y, diameter);
  }

  void update() {
    //movement
    position.x += random(-1, 1);
    position.y += random(-1, 1);
    //deal with borders of canvas
    if (position.x - diameter < 0) {
      position.x++;
    } else if (position.x + diameter > env.WIDTH) {
      position.x--;
    }
    if (position.y - diameter < 0) {
      position.y++;
    } else if (position.y + diameter > env.HEIGHT) {
      position.y--;
    }
  }
}
