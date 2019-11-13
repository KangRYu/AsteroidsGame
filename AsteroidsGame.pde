Spaceship player;

void keyPressed() {
  if(keyCode == LEFT) {
    player.turn(1);
  }
  if(keyCode == RIGHT) {
    player.turn(-1);
  }
}
public void setup() {
  size(500, 500);
  player = new Spaceship();
}
public void draw() {
  background(200);
  player.show();
  player.move();
}

