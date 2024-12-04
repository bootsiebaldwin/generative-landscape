int sizeX = 1080;
int sizeY = 720;

int maxDepth = 10; // This is the base case
ArrayList<Integer> primes; // Data structure to store list of prime numbers
TreeInfo[] trees = new TreeInfo[2]; // Trees that will appear with info
int currentDepth = 0; // How big the tree will grow, I put it at zero for the "Stump"

void settings() {
  size(sizeX, sizeY);
}

void setup() {
  stroke(0);
  frameRate(1);

  // Starting prime numbers that'll be generated
  primes = generatePrimes(20);

  // Creating two trees with random primes for which way the branches will grow (at an angle);
  trees[0] = new TreeInfo(width * 0.25, height, primes.get((int)random(primes.size())));
  trees[1] = new TreeInfo(width * 0.75, height, primes.get((int)random(primes.size())));
}

void draw() {
  background(255);

  // Draw recursive tree structures
  for (TreeInfo tree : trees) {
    pushMatrix();
    translate(tree.x, tree.y);
    drawTree(75, 0, tree.primeAngle + 3, currentDepth); // Increased initial branch length and width of stump
    popMatrix();
  }

  // Increase depth after each frame until max depth is reached
  if (currentDepth < maxDepth) {
    currentDepth++;
  } else {
    noLoop();
  }
}

void drawTree(float len, int depth, int angle, int limit) {
  if (depth >= limit) return;

  pushStyle();  // Save current style settings
  if (depth < 6) {
    stroke(155, 105, 60); 
    strokeWeight(7 - depth); 
  } else {
    stroke(0, 100, 0); 
    strokeWeight(6); 
  }

  line(0, 0, 0, -len);
  translate(0, -len);

  pushMatrix();
  rotate(radians(angle));
  drawTree(len * 0.6, depth + 1, angle, limit);
  popMatrix();

  pushMatrix();
  rotate(radians(-angle));
  drawTree(len * 0.6, depth + 1, angle, limit);
  popMatrix();

  translate(0, len);
  popStyle();  // Restore previous style settings
}

ArrayList<Integer> generatePrimes(int limit) {
  ArrayList<Integer> primeList = new ArrayList<Integer>();
  int count = 2;
  while (primeList.size() < limit) {
    if (isPrime(count)) primeList.add(count);
    count++;
  }
  return primeList;
}

boolean isPrime(int n) {
  if (n < 2) return false;
  for (int i = 2; i * i <= n; i++) {
    if (n % i == 0) return false;
  }
  return true;
}

class TreeInfo {
  float x, y;
  int primeAngle;
  TreeInfo(float x, float y, int primeAngle) {
    this.x = x;
    this.y = y;
    this.primeAngle = primeAngle;
  }
}
