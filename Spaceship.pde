class Spaceship extends Floater {   
    public Spaceship() {
        // Initalizes all the corners
        corners = 4;
        xCorners = new int[]{-12, -5, -12, 20};
        yCorners = new int[]{-12, 0, 12, 0};
        myColor = color(90, 255, 150);
        myCenterX = width/2;
        myCenterY = height/2;
        myDirectionX = 0;
        myDirectionY = 0;
        myPointDirection = 180;
    }
    public void turnTo(float argRotation) {
        myPointDirection = argRotation;
    }
    public double getX() {
        return myCenterX;
    }
    public double getY() {
        return myCenterY;
    }
    public void hyperSpace() { // Teleports the spaceship to a random position rotation
        myCenterX = width * Math.random();
        myCenterY = height * Math.random();
        myDirectionX = 0;
        myDirectionY = 0;
    }
}
