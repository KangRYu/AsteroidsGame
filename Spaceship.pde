class Spaceship extends Floater {   
    public Spaceship() {
        // Initalizes all the corners
        corners = 3;
        xCorners = new int[]{-12, -12, 20};
        yCorners = new int[]{-12, 12, 0};
        myColor = color(255, 0, 0);
        myCenterX = width/2;
        myCenterY = height/2;
        myDirectionX = 0;
        myDirectionY = 0;
        myPointDirection = 180;
    }
    public void turnTo(float argRotation) {
        myPointDirection = lerp((float)myPointDirection, argRotation, 0.2);
    }
    public double getX() {
        return myCenterX;
    }
    public double getY() {
        return myCenterY;
    }
    public void hyperSpace() { // Teleports the spaceship to a random position rotation
        myPointDirection = 360 * Math.random();
        myCenterX = width * Math.random();
        myCenterY = height * Math.random();
        myDirectionX = 0;
        myDirectionY = 0;
    }
}
