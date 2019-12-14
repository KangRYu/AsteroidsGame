// States
Spaceship player;
ArrayList<Star> starList = new ArrayList<Star>();
ArrayList<Asteroid> asteroidList = new ArrayList<Asteroid>();
ArrayList<Bullet> bulletList = new ArrayList<Bullet>();
ArrayList<Particle> particleList = new ArrayList<Particle>();
Button restartButton;
int originalBackgroundColor; // The original background color so that when hyperspacing the background can return to its original color
int backgroundColor; // The current background color
int score;
int highscore;
int combo; // Increases per asteroid destroyed without getting hit
int hyperspacesLeft; // The number of hyperspaces left
float scoreScale; // The scale of the score text, for lerping
// Properties
int numOfStars = 100;
int numOfAsteroids = 18;

public void keyPressed() {
  if(!player.getDead()) {
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
      if(hyperspacesLeft > 0) {
        player.hyperSpace();
        hyperspacesLeft--;
        backgroundColor = color(255);
        asteroidList.clear(); // Clear all asteroids when hyperspacing
      }
    }
  }
}
public void keyReleased() {
  if(!player.getDead()) {
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
}
public void mousePressed() {
  player.setShooting(true);
}
public void mouseReleased() {
  player.setShooting(false);
}
public void setup() {
  // Style settings
  size(700, 700);
  // Initializes values
  player = new Spaceship();
  originalBackgroundColor = color(30);
  backgroundColor = originalBackgroundColor;
  score = 0;
  highscore = 0;
  scoreScale = 1;
  combo = 1;
  hyperspacesLeft = 3;
  // Setup restart button
  restartButton = new Button(width/2, height/2, 250, 100, "Restart");
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
  // Draws all bullets
  for(Bullet bullets : bulletList) {
    bullets.update();
  }
  // Draws all asteroids
  for(Asteroid asteroid : asteroidList) {
    asteroid.update();
  }
  // Updates player
  player.update();
  // Draws all particles
  for(Particle particles : particleList) {
    particles.update();
  }
  // Draw score
  scoreScale = lerp(scoreScale, 1, 0.05); // Interpolate scale
  fill(255);
  textSize(30 * scoreScale);
  textAlign(RIGHT, CENTER);
  text("Score: " + score, width - 25, 37.5);
  // Draw combo counter
  fill(255);
  textSize(15);
  textAlign(RIGHT, CENTER);
  text("Combo: x" + combo, width - 30, 70);
  // Draw highscore
  fill(255);
  textSize(15);
  textAlign(RIGHT, CENTER);
  text("Highscore: " + highscore, width - 30, 92.5);
  // Draw hyperspace counter
  fill(255);
  textSize(15);
  textAlign(RIGHT, CENTER);
  text("Hyperspaces: " + hyperspacesLeft, width - 30, 115);
  // Draws game over screen if lost
  if(player.getDead()) {
    // Score
    fill(255);
    textSize(50);
    textAlign(CENTER, CENTER);
    text("Score: " + score, width/2, 200);
    // Highscore
    fill(255);
    textSize(30);
    textAlign(CENTER, CENTER);
    text("Highscore: " + highscore, width/2, 260);
    // Button
    restartButton.update();
    if(restartButton.pressed()) {
      reset();
    }
  }
  // Detects collisions etween asteroid and player
  ArrayList<Asteroid> asteroidsToRemove = new ArrayList<Asteroid>();
  if(!player.getDead()) { // Only runs if the player isn't dead
    for(Asteroid asteroid : asteroidList) {
      if(dist((float)asteroid.getX(), (float)asteroid.getY(), (float)player.getX(), (float)player.getY()) <= asteroid.getCollisionDistance() + player.getCollisionDistance()) {
        backgroundColor = color(255, 0, 0);
        player.addHealth(-10);
        combo = 1;
        if(!asteroidsToRemove.contains(asteroid)) {
          asteroidsToRemove.add(asteroid);
        }
      }
    }
  }
  // Detects for collision between bullets and asteroids and removes accordingly
  ArrayList<Bullet> bulletsToRemove = new ArrayList<Bullet>(); // A list of all bullets that are going to be removed
  for(Bullet bullet : bulletList) {
    for(Asteroid asteroid : asteroidList) {
      if(dist((float)asteroid.getX(), (float)asteroid.getY(), (float)bullet.getX(), (float)bullet.getY()) <= asteroid.getCollisionDistance() + bullet.getCollisionDistance()) {
        if(!bulletsToRemove.contains(bullet)) {
          bulletsToRemove.add(bullet);
        }
        if(!asteroidsToRemove.contains(asteroid)) {
          asteroid.addHealth(-20);
          if(asteroid.getHealth() <= 0) {
            spawnFloaterText((float)asteroid.getX(), (float)asteroid.getY(), -5, radians(90.0), color(255), "+" + str(combo * 10));
            addScore();
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
  ArrayList<Asteroid> asteroidsOffScreen = new ArrayList<Asteroid>(); // There needs to be a seperate array list for objects to be removed without particles
  for(Asteroid asteroid : asteroidList) {
    if(!asteroid.getSpawnValue()) { // Only run if the asteroid is done spawning, aka fully in the screen
      if(asteroid.getX() + asteroid.getCollisionDistance() <= 0 || asteroid.getX() - asteroid.getCollisionDistance() >= width) {
        asteroidsOffScreen.add(asteroid);
      }
      else if(asteroid.getY() - asteroid.getCollisionDistance() >= height || asteroid.getY() + asteroid.getCollisionDistance() <= 0) {
        asteroidsOffScreen.add(asteroid);
      }
    }
  }
  // Add bullets off screen to be removed
  ArrayList<Bullet> bulletsOffScreen = new ArrayList<Bullet>();
  for(Bullet bullet : bulletList) {
    if(bullet.getX() + bullet.getCollisionDistance() <= 0 || bullet.getX() - bullet.getCollisionDistance() >= width) {
      bulletsOffScreen.add(bullet);
    }
    else if(bullet.getY() - bullet.getCollisionDistance() >= height || bullet.getY() + bullet.getCollisionDistance() <= 0) {
      bulletsOffScreen.add(bullet);
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
  // Remove off screen bullets
  for(Bullet bullet : bulletsOffScreen) {
    bulletList.remove(bullet);
  }
  // Add new asteroids if there is less then the set amount
  if(asteroidList.size() < numOfAsteroids) {
    for(int i = 0; i < numOfAsteroids - asteroidList.size(); i++) {
      asteroidList.add(new Asteroid());
    }
  }
  // Set player to dead if health is 0 or lower
  if(player.getHealth() <= 0 && !player.getDead()) {
    spawnParticles((float)player.getX(), (float)player.getY(), 500, 100, 0, 360, player.getColor());
    player.setDead(true);
    if(score > highscore) {
      highscore = score;
    }
  }
}
public void addScore() {
  score += 10 * combo;
  combo++;
  scoreScale = 1.5;
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
public void spawnFloaterText(float posX, float posY, float speed, float angle, int particleColor, String argTxt) {
  Particle obj = new TextFloater(posX, posY, speed, angle, particleColor, argTxt);
  particleList.add(obj);
}
public void reset() { // Resets the game and all its values
  score = 0;
  player = new Spaceship();
  combo = 1;
  asteroidList.clear();
  bulletList.clear();
  particleList.clear();
  backgroundColor = originalBackgroundColor;
  scoreScale = 1;
  hyperspacesLeft = 3;
}
