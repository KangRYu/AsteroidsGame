class Bullet extends Floater {
  public Bullet(double argX, double argY, double argSpeed, double argAngle) {
      // Initializes values
      myCenterX = argX;
      myCenterY = argY;
      myPointDirection = argAngle;
      myDirectionX = argSpeed * cos(radians((float)argAngle));
      myDirectionY = argSpeed * sin(radians((float)argAngle));
      myColor = color(255);
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
}