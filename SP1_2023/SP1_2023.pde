
int cellSize = 20;
Snake s;
VectorPos food;

void setup() {
  size(450, 600);
  s = new Snake();
  frameRate(5);
  pickLocation();
  background(0);
}

void draw() {
  background(#FF950A);

  if (s.eat(food)) {
    pickLocation();
  }

  s.update();
  s.show();

  if (s.checkCollisionWithTail()) {
    s.total = 0;
    s.tail.clear();
  }

  fill(#257432); // grøn farve for maden
  rect(food.x, food.y, cellSize, cellSize);
}

void pickLocation() {
  int cols = floor(width / cellSize);
  int rows = floor(height / cellSize);
  food = new VectorPos(cellSize * floor(random(cols)), cellSize * floor(random(rows)));
}

void keyPressed() {
  if (keyCode == UP && s.yspeed == 0) {
    s.setDirection(0, -1);
  } else if (keyCode == DOWN && s.yspeed == 0) {
    s.setDirection(0, 1);
  } else if (keyCode == RIGHT && s.xspeed == 0) {
    s.setDirection(1, 0);
  } else if (keyCode == LEFT && s.xspeed == 0) {
    s.setDirection(-1, 0);
  }
}

class Snake {
  float x = 0;
  float y = 0;
  float xspeed = 1;
  float yspeed = 0;
  ArrayList<VectorPos> tail = new ArrayList();
  int total = 0;

  boolean eat(VectorPos pos) {
    float d = dist(x, y, pos.x, pos.y);
    if (d < 1) {
      total++;
      return true;
    } else {
      return false;
    }
  }

  boolean checkCollisionWithTail() {
    for (VectorPos v : tail) {
      float d = dist(x, y, v.x, v.y);
      if (d < 1) {
        return true;
      }
    }
    return false;
  }

  void update() {
    if (total == tail.size()) {
      for (int i = 0; i < tail.size() - 1; i++) {
        tail.set(i, tail.get(i + 1));
      }
    }
    if (total > 0) {
      tail.add(new VectorPos(x, y));
      if(total > tail.size()) {
        tail.remove(0);
      }
    }

    x = x + xspeed * cellSize;
    y = y + yspeed * cellSize;
    x = constrain(x, 0, width - cellSize);
    y = constrain(y, 0, height - cellSize);
  }

void show() {
    fill(#FF0A27); //Slangens farve er rød
    for (int i = 0; i < tail.size(); i++) {
      rect(tail.get(i).x, tail.get(i).y, cellSize, cellSize);
    }
    rect(x, y, cellSize, cellSize);
  }

  void setDirection(float x, float y) {
    xspeed = x;
    yspeed = y;
  }
}

class VectorPos {
  float x, y;

  VectorPos(float x, float y) {
    this.x = x;
    this.y = y;
  }
}
