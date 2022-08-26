class Environment {

  int WIDTH;
  int HEIGHT;
  Background bg;

  ArrayList<Organism> beings;
  ArrayList<Food> foodList;
  ArrayList<Predator> predators;
  float offspring = 0;
  color pixel;

  int INIT_BEINGS = 10;
  int INIT_PREDATORS = 2;
  int MAX_FOOD = 100;
  int MAX_ORGANISMS = 100;
  int MAX_PREDATORS = 10;

  int frameTimer = 0;
  int frameLimit = 30;

  Environment(int w, int h) {
    WIDTH = w;
    HEIGHT = h;
    bg = new Background(w, h);

    beings = new ArrayList<Organism>();
    foodList = new ArrayList<Food>();
    predators = new ArrayList<Predator>();
    createOrganism(INIT_BEINGS);
    createPredators(INIT_PREDATORS);
  }

  void update() {
    bg.update();
    bg.plot();

    PImage image = bg.oldCanvas.get();

    image.loadPixels();


    // search for yellow areas

    frameTimer += 1;
    if (frameTimer == frameLimit){
      frameTimer = 0;
    for (int i = 0, y = 0, x; y < HEIGHT; ++y) {
      for (x = 0; x < WIDTH; ++x, ++i) {
        pixel = image.pixels[i];
        if (hue(pixel) > 24 & hue(pixel) <= 55 & brightness(pixel) > 0) {
          if (random(1) < (0.0000005 * brightness(pixel))) {
            PVector source = new PVector(x, y);
            createFood(source);
          }
        }
      }
    }
    }
    


    if (foodList.size() < MAX_FOOD) {
      offspring += 0.1;
      if (offspring > 4) {
        offspring = 0;
        createFood();
      }
    }

    // Update organisms
    // Spans the whole array
    for (int i = 0; i < beings.size(); ++i) {
      Organism being = beings.get(i);
      being.update(image);

      for (int j = 0; j < foodList.size(); ++j) {
        if (dist(being.position.x, being.position.y, foodList.get(j).position.x, foodList.get(j).position.y) < being.diameter / 2) {
          being.updateHealth(1, 1);
          being.updateFertility(1);
          foodList.remove(j);
        }
      }
      
      being.updateHealth(-1, 0.01);
      
      being.plot();

      if (beings.size() < MAX_ORGANISMS) {
        if (being.fertility >= being.MAX_FERTILITY & being.health > being.MAX_HEALTH / 2) {
          createOrganism(4, being.position);
          being.fertility = 0;
        }
      }

      // Death

      if (being.age > being.MAX_AGE || being.health <= 0) {
        beings.remove(i);
      }
    }

    //Same for predators
    for (int i = 0; i < predators.size(); ++i) {
      Predator predator = predators.get(i);
      predator.update(image);

      Organism being;
      for (int j = 0; j < beings.size(); ++j) {
        being = beings.get(j);
        if (dist(predator.position.x, predator.position.y, being.position.x, being.position.y) < (predator.diameter + being.diameter) / 2) {
          predator.updateHealth(1, 1);
          predator.updateFertility(1);
          beings.remove(j);
        }
      }
      
      predator.updateHealth(-1, 0.01);
      
      predator.plot();

      if (predators.size() < MAX_PREDATORS) {
        if (predator.fertility >= predator.MAX_FERTILITY & predator.health > predator.MAX_HEALTH / 2) {
          createPredators(4, predator.position);
          predator.fertility = 0;
        }
      }

      // Death

      if (predator.age > predator.MAX_AGE || predator.health <= 0) {
        predators.remove(i);
      }
    }

    for (int i = 0; i < foodList.size(); ++i) {
      foodList.get(i).update();
      foodList.get(i).plot();
    }
  }

  void drawCircle() {
    bg.drawCircle();
  }

  void updateCircle(String param, int x) {
    bg.updateCircle(param, x);
  }

  void createOrganism(int numberOrganisms) {
    for (int i=0; i < numberOrganisms; i++) {
      PVector ini_vel = new PVector(random(-2, 2), random(-2, 2));
      PVector ini_pos = new PVector(int(random(10, WIDTH - 10)), int(random(10, HEIGHT - 10)));
      beings.add(new Organism(ini_pos, ini_vel));
    }
  }

  void createOrganism(int numberOrganisms, PVector source) {
    for (int i=0; i < numberOrganisms; i++) {
      PVector ini_vel = new PVector(random(-2, 2), random(-2, 2));
      beings.add(new Organism(source, ini_vel));
    }
  }

  void createFood() {
    PVector ini_pos = new PVector(int(random(0, WIDTH)), int(random(0, HEIGHT)));
    foodList.add(new Food(ini_pos));
  }

  void createFood(PVector source) {
    PVector ini_pos = source;
    foodList.add(new Food(ini_pos));
  }

  void createPredators(int numberPredators) {
    for (int i=0; i < numberPredators; i++) {
      PVector ini_vel = new PVector(random(-1, 1), random(-1, 1));
      PVector ini_pos = new PVector(int(random(50, WIDTH - 50)), int(random(50, HEIGHT - 50)));
      predators.add(new Predator(ini_pos, ini_vel));
    }
  }

  void createPredators(int numberPredators, PVector source) {
    for (int i=0; i < numberPredators; i++) {
      PVector ini_vel = new PVector(random(-1, 1), random(-1, 1));
      predators.add(new Predator(source, ini_vel));
    }
  }
}
