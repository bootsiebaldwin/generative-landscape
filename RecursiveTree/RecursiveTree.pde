int maxDepth = 10; // This is the base case
ArrayList<Integer> primes; // Data structure to store list of prime numbers
TreeInfo[] trees = new TreeInfo[2]; // Trees that will appear with info
int currentDepth = 0; // How big the tree will grow, I put it at zero for the "Stump"

void setup() {
  size(600, 600); 
  background(255); // this will change
  stroke(0);
  
  // Starting prime numbers that'll be generated
  primes = generatePrimes(20); 
  
  // Creating two trees with random primes for which way the branches will grow( at an angle);
  trees[0] = new TreeInfo(width * 0.25, height, primes.get((int)random(primes.size())));
  trees[1] = new TreeInfo(width * 0.75, height, primes.get((int)random(primes.size())));
  
  frameRate(2); // Slow down frame rate to make growth more visible
}

void draw() {
  background(255);
  
  // In the loop, going over each tree in the array and calls the function(recursively) 
  for (TreeInfo tree : trees) {
    pushMatrix(); // Saves position
    translate(tree.x, tree.y);
    drawTree(50, 0, tree.primeAngle, currentDepth); // Initial branch length set smaller
    popMatrix(); // Restores position
  }
  
  // Display information for each tree (position, prime angle, its depth, and max depth (which is the base case)
  displayTreeInfo();
  
  // Increase depth after each frame until max depth is reached
  if (currentDepth < maxDepth) {
    currentDepth++; 
  } else {
    noLoop(); // Stop updating once max depth is reached
  }
}

void drawTree(float len, int depth, int angle, int limit) { // recursive function that draws each branch of the tree
  if (depth >= limit) return; // Stop drawing branches if current depth limit is reached

  // Draw the main branch (stump grows with each depth)
  line(0, 0, 0, -len);
  translate(0, -len); // Moves branch to a new position
  
  // Right branch`
  pushMatrix();
  rotate(radians(angle)); // Angle influenced by prime number
  drawTree(len * 0.6, depth + 1, angle, limit); // Shorten branch
  popMatrix();
  
  // Left branch
  pushMatrix();
  rotate(radians(-angle)); // Angle influenced by prime number
  drawTree(len * 0.6, depth + 1, angle, limit);
  popMatrix();
  
  // Return to previous position to draw next branch
  translate(0, len);
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

void displayTreeInfo() {
  fill(0);
  textSize(12);
  int yOffset = 15;
  for (int i = 0; i < trees.length; i++) {
    TreeInfo tree = trees[i];
    text("Tree " + (i + 1) + ": Position (" + (int)tree.x + ", " + (int)tree.y + 
         "), Prime Angle: " + tree.primeAngle + "°, Current Depth: " + currentDepth + 
         ", Base Case: " + maxDepth, 10, yOffset);
    yOffset += 15;
  }
}

// Helper class to store tree properties
class TreeInfo {
  float x, y;
  int primeAngle;
  TreeInfo(float x, float y, int primeAngle) {
    this.x = x;
    this.y = y;
    this.primeAngle = primeAngle;
  }
}



 
