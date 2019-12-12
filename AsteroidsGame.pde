// States
Spaceship player;
ArrayList<Star> starList = new ArrayList<Star>();
ArrayList<Asteroid> asteroidList = new ArrayList<Asteroid>();
ArrayList<Bullet> bulletList = new ArrayList<Bullet>();
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
public void mousePressed() {
  player.setShooting(true);
}
public void mouseReleased() {
  player.setShooting(false);
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
    particles.update();
  }
  // Draws all bullets
  for(Bullet bullets : bulletList) {
    bullets.update();
  }
  // Updates player
  player.update();
  // Draws all asteroids
  for(Asteroid asteroid : asteroidList) {
    asteroid.update();
  }
  // Detects collisions
  ArrayList<Asteroid> asteroidsToRemove = new ArrayList<Asteroid>();
  for(Asteroid asteroid : asteroidList) {
    if(dist((float)asteroid.getX(), (float)asteroid.getY(), (float)player.getX(), (float)player.getY()) <= asteroid.getCollisionDistance() + player.getCollisionDistance()) {
      backgroundColor = color(255, 0, 0);
      if(!asteroidsToRemove.contains(asteroid)) {
        asteroidsToRemove.add(asteroid);
      }
    }
  }
  // Detects for collision between bullets and asteroids and removes accordingly
  ArrayList<Bullet> bulletsToRemove = new ArrayList<Bullet>(); // A ;ist of all bullets that are going to be removed
  for(Bullet bullet : bulletList) {
    for(Asteroid asteroid : asteroidList) {
      if(dist((float)asteroid.getX(), (float)asteroid.getY(), (float)bullet.getX(), (float)bullet.getY()) <= asteroid.getCollisionDistance() + bullet.getCollisionDistance()) {
        if(!bulletsToRemove.contains(bullet)) {
          bulletsToRemove.add(bullet);
        }
        if(!asteroidsToRemove.contains(asteroid)) {
          asteroid.addHealth(-20);
          if(asteroid.getHealth() <= 0) {
            asteroidsToRemove.add(asteroid);
          }
        }
      }
    }
  }
  // Find particles to remove
  ArrayList<Particle> particlesToRemove = new ArrayList<Particle>();
  for(Particle particle : particleList) {
    if(particle.getVelocity() < 1) {
      particlesToRemove.add(particle);
    }
  }
  // Add asteroids off screen to be removed
  ArrayList<Asteroid> asteroidsOffScreen = new ArrayList<Asteroid>();
  for(Asteroid asteroid : asteroidList) {
    if(!asteroid.getSpawnValue()) { // Only run if the asteroid is done spawning, aka fully in the screen
      if(asteroid.getX() + asteroid.getCollisionDistance() <= 0 || asteroid.getX() - asteroid.getCollisionDistance() >= width) {
        asteroidsOffScreen.add(asteroid);
      }
      else if(asteroid.getY() + asteroid.getCollisionDistance() >= height || asteroid.getY() - asteroid.getCollisionDistance() <= 0) {
        asteroidsOffScreen.add(asteroid);
      }
    }
  }
  // Removes the objects to remove
  for(Asteroid asteroid : asteroidsToRemove) {
    spawnAsteroidParticles((float)asteroid.getX(), (float)asteroid.getY(), 50, 8, 0, 360, asteroid.getColor());
    asteroidList.remove(asteroid);
  }
  for(Bullet bullet : bulletsToRemove) { // Removes each terminated bullet from the bullet list
    spawnParticles((float)bullet.getX(), (float)bullet.getY(), 20, 5, 0, 360, color(255)); // Bullet collision particles
    bulletList.remove(bullet);
  }
  for(Particle particle : particlesToRemove) {
    particleList.remove(particle);
  }
  // Remove off screen asteroids
  for(Asteroid asteroid : asteroidsOffScreen) {
    asteroidList.remove(asteroid);
  }
  // Add new asteroids if there is less then the set amount
  if(asteroidList.size() < numOfAsteroids) {
    for(int i = 0; i < numOfAsteroids - asteroidList.size(); i++) {
      asteroidList.add(new Asteroid());
    }
  }
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
public void spawnAsteroidParticles(float posX, float posY, int numOfParticles, float speed, float angle, float angleVariation, int particleColor) { // Spawns particles
  for(int i = 0; i < numOfParticles; i++) {
    float velocity = (float)(speed * Math.random());
    float velocityAngle = (float)radians((float)(angle + (angleVariation * Math.random() - angleVariation/2)));
    Particle obj = new AsteroidParticle(posX, posY, velocity, velocityAngle, particleColor);
    particleList.add(obj);
  }
}
