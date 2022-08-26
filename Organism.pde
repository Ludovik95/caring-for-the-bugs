class Organism {
  //here there will be the main class for our organisms
  PVector position;
  PVector velocity;
  PVector acceleration;
  int diameter;
  color hue = color(255, 0, 255, 255);
  
  //stats
  float health;
  int MAX_HEALTH = 200;
  int age;
  int MAX_AGE = 20000;
  float fertility;
  int MAX_FERTILITY = 10;
  

  Organism(PVector ini_pos, PVector ini_vel) {
    age = 0;
    position = ini_pos.copy();
    velocity = ini_vel.copy();
    acceleration = new PVector(0, 0);
    diameter = 10;
    fertility = 0;
    health = MAX_HEALTH;
  }

  // Draw the organism
  void plot() {
    noStroke();
    fill(hue);
    circle(position.x, position.y, diameter);
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
      updateHealth(1, brightness(pixel)/255);
    } 
    // GREEN
    else if (hue(pixel) > 55 & hue(pixel) <= 125 & brightness(pixel) > 0) {
      updateHealth(1, brightness(pixel)/255);
      updateFertility(0.01);
    }
    // YELLOW
    else if (hue(pixel) > 24 & hue(pixel) <= 55 & brightness(pixel) > 0) {
    
    }
    // RED
    else if (hue(pixel) > 0 & hue(pixel) <= 24 & brightness(pixel) > 0 || hue(pixel) > 228 & hue(pixel) <= 255 & brightness(pixel) > 0) {
      updateHealth(-1, brightness(pixel)/255);
    }
  }
  
  void updateHealth(int delta, float multiplier){
     health += delta * multiplier;
  }
  
  void updateFertility(float delta){
     fertility += delta;
  }
}
