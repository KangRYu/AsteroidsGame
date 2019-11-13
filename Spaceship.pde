class Spaceship extends Floater {   
    public Spaceship() {
        // Initalizes all the corners
        corners = 3;
        xCorners = new int[]{-12, 12, 0};
        yCorners = new int[]{-12, -12, 20};
        myColor = color(255, 0, 0);
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
}
