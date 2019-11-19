// States
Spaceship player;
ArrayList<Star> starList = new ArrayList<Star>();
ArrayList<Particle> particleList = new ArrayList<Particle>();
int originalBackgroundColor; // The original background color so that when hyperspacing the background can return to its original color
int backgroundColor;
// Properties
int numOfStars = 100;

void keyPressed() {
  if(key == 'w') {
    player.setForward(true);
  }
  if(key == 's') {
    player.setBackward(true);
  }
  if(key == 'd') {
    player.setRight(true);
  }
  if(key == 'a') {
    player.setLeft(true);
  }
  if(key == 'h') {
    player.hyperSpace();
    backgroundColor = color(255);
  }
}
void keyReleased() {
  if(key == 'w') {
    player.setForward(false);
  }
  if(key == 's') {
    player.setBackward(false);
  }
  if(key == 'd') {
    player.setRight(false);
  }
  if(key == 'a') {
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
  // Remove non moving particles
  ArrayList<Particle> keepedParticles = new ArrayList<Particle>();
  for(Particle particles : particleList) {
    if(!(particles.getVelocity() < 1)) {
      keepedParticles.add(particles);
    }
  }
  particleList = keepedParticles;
  // Updates player
  player.show();
  player.move();
}
public void fadeInBackground() { // Fades in the background
  backgroundColor = lerpColor(backgroundColor, originalBackgroundColor, 0.05);
}