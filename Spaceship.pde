class Spaceship extends Floater {   
    public Spaceship() {
        // Initalizes all the corners
        corners = 3;
        xCorners = new int[]{-3, 3, 0};
        yCorners = new int[]{-3, -3, 6};
        myColor = color(255, 0, 0);
        myCenterX = width/2;
        myCenterY = height/2;
        myDirectionX = 3;
        myDirectionY = 0;
        myPointDirection = 180;
    }
}
