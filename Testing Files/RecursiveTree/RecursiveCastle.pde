int maxDepth = 10; // max depth for recursion; controls how many iterations occur.
int currentDepth = 0; // Current depth of recursion, starts at 0 and increases over time.
TreeInfo[] trees = new TreeInfo[2]; // Array to hold information about two trees.
ArrayList<Integer> primes; // List of prime numbers used to determine tree angles.

void setup() {
  size(1200, 1000); // Set the size of the canvas for drawing.
  background(255); // White background.
  stroke(0); // Set the color of lines to black.

  // Generate a list of prime numbers to use for random angles in tree growth.
  primes = generatePrimes(20);

  // Initialize two trees with starting positions and random angles.
  trees[0] = new TreeInfo(width * 0.2, height, primes.get((int)random(primes.size())));
  trees[1] = new TreeInfo(width * 0.8, height, primes.get((int)random(primes.size())));

  frameRate(2); // Slow down the frame rate so growth is visible step-by-step.
}

void draw() {
  background(255); // Clear the canvas each frame.

  // Draw the two trees and their recursive branches.
  for (TreeInfo tree : trees) {
    pushMatrix(); // Save the current drawing position.
    translate(tree.x, tree.y); // Move to the tree's starting position.
    drawTree(100, 0, tree.primeAngle, currentDepth); // Start growing the tree.
    popMatrix(); // Restore the original position for the next tree.
  }

  // Display information about the trees (depth, angles, etc.).
  displayTreeInfo();

  // Draw the trapezoid base for the castle.
  drawFlippedTrapezoidBase(width / 2, height, 300, 60);

  // Draw the castle, with recursive growth up to the current depth.
  float trapezoidTop = height - 60; // The top of the trapezoid base.
  drawCastle(width / 2, trapezoidTop, 200, min(currentDepth, maxDepth)); // Adjust castle size based on depth.

  // Increment the growth depth for the next frame.
  if (currentDepth < maxDepth) {
    currentDepth++;
  } else {
    noLoop(); // Stop drawing once the maximum depth is reached.
  }
}

// Recursive function to draw a tree with branching.
void drawTree(float len, int depth, int angle, int limit) {
  if (depth >= limit || len < 5) return; // Stop recursion when depth is too large or branches are too small.

  // Draw the current branch as a line.
  line(0, 0, 0, -len);
  translate(0, -len); // Move to the end of the current branch for the next.

  // Recursively draw the right branch.
  pushMatrix(); // Save the current position and orientation.
  rotate(radians(angle)); // Rotate to the right by the specified angle.
  drawTree(len * 0.7, depth + 1, angle, limit); // Reduce branch length and increase depth.
  popMatrix(); // Restore the original position and orientation.

  // Recursively draw the left branch.
  pushMatrix();
  rotate(radians(-angle)); // Rotate to the left by the specified angle.
  drawTree(len * 0.7, depth + 1, angle, limit);
  popMatrix();

  // Add smaller branches to add complexity.
  if (depth % 2 == 0) { // Add side branches at even depths for variety.
    pushMatrix();
    rotate(radians(angle / 2)); // Smaller angle for side branches.
    drawTree(len * 0.5, depth + 1, angle, limit); // Smaller branches.
    popMatrix();

    pushMatrix();
    rotate(radians(-angle / 2));
    drawTree(len * 0.5, depth + 1, angle, limit);
    popMatrix();
  }
}

// Draw the base of the castle as an upside-down trapezoid.
void drawFlippedTrapezoidBase(float x, float y, float baseWidth, float baseHeight) {
  pushMatrix(); // Save the current drawing position.
  translate(x, y); // Move to the center of the trapezoid.
  noFill(); // Do not fill the shape, just draw its outline.
  beginShape(); // Start drawing a closed shape.
  vertex(-baseWidth, 0); // Top-left corner.
  vertex(baseWidth, 0); // Top-right corner.
  vertex(baseWidth * 0.7, -baseHeight); // Bottom-right corner.
  vertex(-baseWidth * 0.7, -baseHeight); // Bottom-left corner.
  endShape(CLOSE); // Close the shape.
  popMatrix(); // Restore the original drawing position.
}

// Recursive function to draw the castle and its towers.
void drawCastle(float x, float y, float width, int depth) {
  if (depth == 0) return; // Stop recursion when depth is 0.

  float height = 50; // Set a small height for each section.
  float scaledWidth = width * 0.8; // Slightly reduce the width for each level.

  // Draw the main section of the castle (rectangle).
  rect(x - scaledWidth / 2, y - height, scaledWidth, height);

  // Add a triangle roof with a flag only at the first depth level.
  if (depth == 1) drawTriangleRoof(x, y - height, scaledWidth, height * 0.5);

  // Draw smaller towers (left and right) connected to the main castle.
  float sideWidth = scaledWidth * 0.5;
  float sideHeight = height * 1.2;

  if (depth == 1) { // Add flags to the side towers at the first level only.
    drawSideTower(x - scaledWidth / 2 - sideWidth / 2, y, sideWidth, sideHeight, true); // Left tower.
    drawSideTower(x + scaledWidth / 2 + sideWidth / 2, y, sideWidth, sideHeight, true); // Right tower.
  } else {
    drawSideTower(x - scaledWidth / 2 - sideWidth / 2, y, sideWidth, sideHeight, false); // Left tower.
    drawSideTower(x + scaledWidth / 2 + sideWidth / 2, y, sideWidth, sideHeight, false); // Right tower.
  }

  // Recursively build the next level of the castle above the current section.
  drawCastle(x, y - height, scaledWidth, depth - 1);
}

// Draw a triangular roof for the castle with a flag.
void drawTriangleRoof(float x, float y, float width, float height) {
  triangle(x - width / 2, y, x, y - height, x + width / 2, y); // Draw the triangle.

  // Add a flag to the top of the roof.
  line(x, y - height, x, y - height - 20); // Draw the flagpole.
  line(x, y - height - 20, x + 10, y - height - 10); // Draw the flag.
}

// Draw a rectangular side tower for the castle.
void drawSideTower(float x, float y, float width, float height, boolean hasFlag) {
  rect(x - width / 2, y - height, width, height); // Draw the rectangle.

  // Add a triangle roof with a flag only if the `hasFlag` parameter is true.
  if (hasFlag) drawTriangleRoof(x, y - height, width, height * 0.5);
}

// Display information about each tree's position, angle, and depth.
void displayTreeInfo() {
  fill(0); // Black text color.
  textSize(12); // Small text size.
  int yOffset = 15; // Vertical spacing for each line of text.
  for (int i = 0; i < trees.length; i++) {
    TreeInfo tree = trees[i]; // Get the current tree's information.
    text(
      "Tree " + (i + 1) + ": Position (" + (int)tree.x + ", " + (int)tree.y + 
      "), Prime Angle: " + tree.primeAngle + "°, Current Depth: " + currentDepth + 
      ", Max Depth: " + maxDepth, 
      10, yOffset); // Display tree information.
    yOffset += 15; // Move to the next line.
  }
}

// Generate a list of prime numbers up to the specified limit.
ArrayList<Integer> generatePrimes(int limit) {
  ArrayList<Integer> primeList = new ArrayList<Integer>(); // List to store prime numbers.
  int count = 2; // Start checking for primes from 2.
  while (primeList.size() < limit) {
    if (isPrime(count)) primeList.add(count); // Add prime numbers to the list.
    count++;
  }
  return primeList; // Return the list of primes.
}

// Check if a number is prime.
boolean isPrime(int n) {
  if (n < 2) return false; // Numbers less than 2 are not prime.
  for (int i = 2; i * i <= n; i++) {
    if (n % i == 0) return false; // If divisible by `i`, it's not prime.
  }
  return true; // Otherwise, it's prime.
}

// Helper class to store tree information.
class TreeInfo {
  float x, y; // Starting position of the tree.
  int primeAngle; // Angle for branching, based on a prime number.

  TreeInfo(float x, float y, int primeAngle) {
    this.x = x; // Set the tree's X position.
    this.y = y; // Set the tree's Y position.
    this.primeAngle = primeAngle; // Set the branching angle.
  }
}
