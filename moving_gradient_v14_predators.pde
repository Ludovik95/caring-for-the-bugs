Environment env;
String stats;
PImage intro;
PImage title;
boolean start = false;
int timer;

void setup() {
  size(1000, 800);
  imageMode(CENTER);
  colorMode(HSB, 255);
  env = new Environment(width, height-20);
  title = loadImage("Title.png");
  intro = loadImage("Intro.png");
  drawTitle();
}

void draw() {
  if (!start) {
    if (timer < 100) {
      timer += 1;
      println(timer);
    } else if (timer == 100) {
      drawIntro();
    }
    return;
  }
  env.update();
  drawStats();
  println(frameRate);
}

void drawStats() {
  fill(0);
  rect(0, height-20, width, 20);
  fill(255);
  textSize(16);
  stats = "Food: " + env.foodList.size() + "   Organisms: " + env.beings.size() + "   Predators: " + env.predators.size();
  text(stats, 20, height-5);
}

void drawTitle() {
  background(0);
  image(title, width/2, height/2, height, height);
}

void drawIntro() {
  background(0);
  image(intro, width/2, height/2, height, height);
}

void mouseClicked() {
  env.drawCircle();
  println("pressed");
}

void keyPressed() {
  switch(key) {

  case 'q':
  case 'Q':
    env.updateCircle("radius", -5);
    break;

  case 'w':
  case 'W':
    env.updateCircle("radius", 5);
    break;

  case 'a':
  case 'A':
    env.updateCircle("hue", -3);
    break;

  case 's':
  case 'S':
    env.updateCircle("hue", 3);
    break;

  case 'z':
  case 'Z':
    env.updateCircle("alpha", -5);

    break;

  case 'x':
  case 'X':
    env.updateCircle("alpha", 5);
    break;

  case ' ':
    start = true;
    break;

    /*
  case 'e':
     case 'E':
     env.bg.circle.setHue(color(0, 0, 0, 255));
     */
  default:
    break;
  }
}
