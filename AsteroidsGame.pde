Spaceship player;

void keyPressed() {
  if(key == 'w') {
    System.out.println(true);
    player.accelerate(0.5);
  }
}
public void setup() {
  size(500, 500);
  player = new Spaceship();
}
public void draw() {
  background(200);
  // Makes player angle equal to the angle to the mouse
  player.turnTo(getMouseAngle() - 90);
  // Updates player
  player.show();
  player.move();
}
public float getMouseAngle() { // Returns the angle of the mouse relative to the player in degrees
  double x = mouseX - player.getX();
  double y = mouseY - player.getY();
  return (float)(Math.toDegrees(Math.atan2(y, x)));
}

