// States
Spaceship player;
ArrayList<Star> starList = new ArrayList<Star>();
ArrayList<Asteroid> asteroidList = new ArrayList<Asteroid>();
ArrayList<Particle> particleList = new ArrayList<Particle>();
int originalBackgroundColor; // The original background color so that when hyperspacing the background can return to its original color
int backgroundColor; // The current background color
// Properties
int numOfStars = 100;
int numOfAsteroids = 10;

public void keyPressed() {
  if(key == 'w' || keyCode == UP) {
    player.setForward(true);
  }
  if(key == 's' || keyCode == DOWN) {
    player.setBackward(true);
  }
  if(key == 'd' || keyCode == RIGHT) {
    player.setRight(true);
  }
  if(key == 'a' || keyCode == LEFT) {
    player.setLeft(true);
  }
  if(key == 'h') {
    player.hyperSpace();
    backgroundColor = color(255);
  }
}
public void keyReleased() {
  if(key == 'w' || keyCode == UP) {
    player.setForward(false);
  }
  if(key == 's' || keyCode == DOWN) {
    player.setBackward(false);
  }
  if(key == 'd' || keyCode == RIGHT) {
    player.setRight(false);
  }
  if(key == 'a' || keyCode == LEFT) {
    player.setLeft(false);
  }
}
public void setup() {
  // Style settings
  size(500, 500);
  rectMode(CENTER);
  // Initializes values
  player = new Spaceship();
  originalBackgroundColor = color(30);
  backgroundColor = originalBackgroundColor;
  // Instances stars
  for(int i = 0; i < numOfStars; i++) {
    starList.add(new Star());
  }
  // Instances initial asteroids
  for(int i = 0; i < numOfAsteroids; i++) {
    asteroidList.add(new Asteroid());
  }
}
public void draw() {
  // Lerp background color back to the original color, for hyperspacing
  fadeInBackground();
  // Draws a background
  background(backgroundColor);
  // Draws all stars
  for(Star stars : starList) {
    stars.show();
  }
  // Draws all particles
  for(Particle particles : particleList) {
    particles.move();
    particles.show();
  }
  // Updates player
  player.show();
  player.move();
  // Draws all asteroids
  for(Asteroid asteroid : asteroidList) {
    asteroid.move();
    asteroid.show();
  }
  // Detects for collision and remove asteroids accordingly
  ArrayList<Asteroid> keepedAsteroids = new ArrayList<Asteroid>();
  for(Asteroid asteroid : asteroidList) {
    if(dist((float)asteroid.getX(), (float)asteroid.getY(), (float)player.getX(), (float)player.getY()) <= asteroid.getCollisionDistance() + player.getCollisionDistance()) {
      backgroundColor = color(255, 0, 0);
    }
    else {
      keepedAsteroids.add(asteroid);
    }
  }
  asteroidList = keepedAsteroids;
  // Add new asteroids if there is less then the set amount
  if(asteroidList.size() < numOfAsteroids) {
    for(int i = 0; i < numOfAsteroids - asteroidList.size(); i++) {
      asteroidList.add(new Asteroid());
    }
  }
  // Remove non moving particles
  ArrayList<Particle> keepedParticles = new ArrayList<Particle>();
  for(Particle particles : particleList) {
    if(!(particles.getVelocity() < 1)) {
      keepedParticles.add(particles);
    }
  }
  particleList = keepedParticles;
}
public void fadeInBackground() { // Fades in the background
  int firstColor = backgroundColor;
  backgroundColor = lerpColor(backgroundColor, originalBackgroundColor, 0.05);
  if(firstColor == backgroundColor) {
    backgroundColor = originalBackgroundColor;
  }
}
public void spawnParticles(float posX, float posY, int numOfParticles, float speed, float angle, float angleVariation, int particleColor) { // Spawns particles
  for(int i = 0; i < numOfParticles; i++) {
    float velocity = (float)(speed * Math.random());
    float velocityAngle = (float)radians((float)(angle + (angleVariation * Math.random() - angleVariation/2)));
    Particle obj = new Particle(posX, posY, velocity, velocityAngle, particleColor);
    particleList.add(obj);
  }
}
