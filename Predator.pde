class Predator {
  //here there will be the main class for our organisms
  PGraphics predatorImage;
  PImage img;

  PVector position;
  PVector velocity;
  PVector acceleration;
  int diameter;
  color hue = color(255, 0, 255, 255);

  //stats
  float health;
  int MAX_HEALTH = 300;
  int age;
  int MAX_AGE = 30000;
  float fertility;
  int MAX_FERTILITY = 5;


  Predator(PVector ini_pos, PVector ini_vel) {
    age = 0;
    position = ini_pos.copy();
    velocity = ini_vel.copy();
    acceleration = new PVector(0, 0);
    fertility = 0;
    health = MAX_HEALTH;
    img = drawPredator();
    diameter = img.width;
  }

  // Draw the organism
  void plot() {
    noStroke();
    tint(hue);
    image(img, position.x, position.y);
    noTint();
  }

  PImage drawPredator() {
    predatorImage = createGraphics(80, 80);
    predatorImage.beginDraw();
    predatorImage.translate (40, 40);
    for (int  n=0; n<2; n++) {
      predatorImage.stroke (255, 255, 255, random(20, 80));
      for (int a=0; a<360; a+=1) {
        float x = 0;
        float xx = random (10, 20);
        predatorImage.pushMatrix();
        predatorImage.rotate(radians(a));
        predatorImage.strokeCap(CORNER);
        predatorImage.strokeWeight(1);
        predatorImage.line(x, 0, xx, 0);
        predatorImage.popMatrix();
      }
    }
    predatorImage.endDraw();
    return predatorImage;
  }

  // Update position, velocity, age... maybe based on the hue in the background
  void update(PImage background) {
    color pixel = background.get(int(position.x), int(position.y));
    seeColor(pixel);

    //deal with borders of canvas
    if (position.x - diameter / 2 < 0 || position.x + diameter / 2 > env.WIDTH) {
      velocity.x = -velocity.x;
    }
    if (position.y - diameter / 2 < 0 || position.y + diameter / 2 > env.HEIGHT) {
      velocity.y = -velocity.y;
    }
    velocity.add(acceleration);
    position.add(velocity);

    age += 1;

    float alpha = min((health / MAX_HEALTH), (1 - (age / MAX_AGE))) * 255;
    hue = color(hue(hue), saturation(hue), brightness(hue), alpha);
  }

  void seeColor(color pixel) {
    // PURPLE
    if (hue(pixel) > 178 & hue(pixel) <= 228 & brightness(pixel) > 0) {
      updateHealth(-1, brightness(pixel)/255);
    }
    // BLUE
    else if (hue(pixel) > 125 & hue(pixel) <= 178 & brightness(pixel) > 0) {
      updateHealth(-1, brightness(pixel)/255);
    }
    // GREEN
    else if (hue(pixel) > 55 & hue(pixel) <= 125 & brightness(pixel) > 0) {
      updateHealth(1, brightness(pixel)/255);
      updateFertility(0.01);
    }
    // YELLOW
    else if (hue(pixel) > 24 & hue(pixel) <= 55 & brightness(pixel) > 0) {
      updateHealth(-1, brightness(pixel)/255);
    }
    // RED
    else if (hue(pixel) > 0 & hue(pixel) <= 24 & brightness(pixel) > 0 || hue(pixel) > 228 & hue(pixel) <= 255 & brightness(pixel) > 0) {
      updateHealth(1, brightness(pixel)/255);
    }
  }

  void updateHealth(int delta, float multiplier) {
    health += delta * multiplier;
  }

  void updateFertility(float delta) {
    fertility += delta;
  }
}
