class Asteroid extends Floater {
    private float rotationSpeed; // In degrees
    public Asteroid() {
        // Initializes the asteroid shape
        corners = 10;
        xCorners = new int[]{20, 8, -2, -10, -19, -22, -11, -3, 7, 15};
        yCorners = new int[]{0, 11, 20, 11, -2, -10, -16, -20, -14, -4};
        myColor = color(173, 137, 64);
        // Gives asteroid random position and speed
        myCenterX = width * Math.random();
        myCenterY = height * Math.random();
        myDirectionX = 10 * Math.random();
        myDirectionY = 10 * Math.random();
        // Gives asteroid random rotation and rotation speed
        myPointDirection = 360 * Math.random();
        rotationSpeed = (float)(10 * Math.random() - 10);
    }
    public Asteroid(double argX, double argY) {// Constructor for specifiying position
        // Set asteroid position
        myCenterX = argX;
        myCenterY = argY;
        // Gives random speed
        myDirectionX = 10 * Math.random();
        myDirectionY = 10 * Math.random();
        // Gives asteroid random rotation and rotation speed
        myPointDirection = 360 * Math.random();
        rotationSpeed = (float)(10 * Math.random() - 10);
    }
    public void turn(float argRotation) { // Overwrites floater turn to use floats instead of integers
        myPointDirection += argRotation;
    }
    public void move() {
        turn(rotationSpeed);
        super.move();
    }
}