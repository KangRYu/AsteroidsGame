class Bullet extends Floater {
    public Bullet(double argX, double argY, double argSpeed, double argAngle) {
        // Initializes values
        myCenterX = argX;
        myCenterY = argY;
        myPointDirection = argAngle;
        myDirectionX = argSpeed * cos(radians(argAngle));
        myDirectionY = argSpeed * sin(radians(argAngle));
    }
    public void show () {             
    fill(myColor);  
    stroke(myColor);    
    // Translate and rotate
    translate((float)myCenterX, (float)myCenterY);
    rotate(radians(myPointDirection));
    ellipse(0, 0, 10, 10);
    // Untranslate and unrotate
    rotate(-radians(myPointDirection));
    translate(-myCenterX, -myCenterY);
  }   
}