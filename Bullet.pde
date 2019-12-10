class Bullet extends Floater {
  private float collisionDistance;
  public Bullet(Spaceship argShip) {
    myCenterX = argShip.getX();
    myCenterY = argShip.getY();
    myPointDirection = argShip.getPointDirection();
    // Calculates the speed based on the point direction
    myDirectionX = 30 * cos(radians((float)myPointDirection));
    myDirectionY = 30 * sin(radians((float)myPointDirection));
    myColor = color(255);
    // Calculate collision distance
    collisionDistance = 5;
  }
  public void update() {
    move();
    show();
  }
  public void show() {             
    fill(myColor);  
    stroke(myColor);    
    // Translate and rotate
    translate((float)myCenterX, (float)myCenterY);
    rotate(radians((float)myPointDirection));
    ellipse(0, 0, 10, 10);
    // Untranslate and unrotate
    rotate(-radians((float)myPointDirection));
    translate(-(float)myCenterX, -(float)myCenterY);
  }
  public double getX() {
    return myCenterX;
  }
  public double getY() {
    return myCenterY;
  }
  public float getCollisionDistance() {
    return collisionDistance;
  }
}