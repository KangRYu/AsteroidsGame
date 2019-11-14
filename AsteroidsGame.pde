// States
Spaceship player;
ArrayList<Star> starList = new ArrayList<Star>();
ArrayList<Particle> particleList = new ArrayList<Particle>();
int backgroundColor;
boolean hyperSpacing = false;
// Properties
int numOfStars = 100;

void keyPressed() {
  if(key == 'w') {
    player.accelerate(0.5);
    // Spawn particles
    for(int i = 0; i < 3; i++) { // Orange particles
      Particle obj = new Particle();
      obj.setX((float)player.getX());
      obj.setY((float)player.getY());
      obj.setColor(color(255, 133, 25));
      obj.setVelocity((float)(10 * Math.random()));
      obj.setVelocityAngle((float)Math.toRadians(getMouseAngle() - 180 + (20 * Math.random() - 10)));
      particleList.add(obj);
    }
    for(int i = 0; i < 3; i++) { // Yellow particles
      Particle obj = new Particle();
      obj.setX((float)player.getX());
      obj.setY((float)player.getY());
      obj.setColor(color(255, 238, 107));
      obj.setVelocity((float)(10 * Math.random()));
      obj.setVelocityAngle((float)Math.toRadians(getMouseAngle() - 180 + (20 * Math.random() - 10)));
      particleList.add(obj);
    }
    for(int i = 0; i < 3; i++) { // Red particles
      Particle obj = new Particle();
      obj.setX((float)player.getX());
      obj.setY((float)player.getY());
      obj.setColor(color(255, 75, 51));
      obj.setVelocity((float)(10 * Math.random()));
      obj.setVelocityAngle((float)Math.toRadians(getMouseAngle() - 180 + (20 * Math.random() - 10)));
      particleList.add(obj);
    }
  }
  if(key == 'h') {
    // Spawn particles at original position
    for(int i = 0; i < 50; i++) {
      Particle obj = new Particle();
      obj.setX((float)player.getX());
      obj.setY((float)player.getY());
      obj.setVelocity((float)(10 * Math.random()));
      obj.setVelocityAngle((float)(Math.toRadians(Math.random() * 360)));
      particleList.add(obj);
    }
    player.hyperSpace();
    backgroundColor = color(255);
    hyperSpacing = true;
    // Spawn particles
    for(int i = 0; i < 50; i++) {
      Particle obj = new Particle();
      obj.setX((float)player.getX());
      obj.setY((float)player.getY());
      obj.setVelocity((float)(10 * Math.random()));
      obj.setVelocityAngle((float)(Math.toRadians(Math.random() * 360)));
      particleList.add(obj);
    }
  }
}
public void setup() {
  // Style settings
  size(500, 500);
  rectMode(CENTER);
  // Initializes values
  player = new Spaceship();
  backgroundColor = color(30);
  // Instances stars
  for(int i = 0; i < numOfStars; i++) {
    starList.add(new Star());
  }
}
public void draw() {
  // Lerp background color if hyperspacing
  if(hyperSpacing) {
    fadeInBackground();
  }
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
  // Makes player angle equal to the angle to the mouse
  player.turnTo(getMouseAngle());
  // Updates player
  player.show();
  player.move();
}
public float getMouseAngle() { // Returns the angle of the mouse relative to the player in degrees
  double x = mouseX - player.getX();
  double y = mouseY - player.getY();
  return (float)(Math.toDegrees(Math.atan2(y, x)));
}
public void fadeInBackground() { // Fades in the background
  backgroundColor = lerpColor(backgroundColor, color(30), 0.05);
}

