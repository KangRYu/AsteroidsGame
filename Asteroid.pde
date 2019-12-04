class Asteroid extends Floater {
    private float rotationSpeed; // In degrees
    private float collisionDistance; // The distance where an object would collide with this asteroid
    public Asteroid() {
        // Makes the asteroid brown
        myColor = color(173, 137, 64);
        // Initializes the asteroid shape
        corners = 16;
        xCorners = new int[]{-20, -10, 0, 10, 20, 20, 20, 20, 20, 10, 0, -10, -20, -20, -20, -20};
        yCorners = new int[]{20, 20, 20, 20, 20, 10, 0, -10, -20, -20, -20, -20, -20, -10, 0, 10};
        // Randomizes asteroid shape
        for(int i = 1; i <= 3; i++) {
            yCorners[i] += (int)(10 * Math.random());
        }
        for(int i = 5; i <= 7; i++) {
            xCorners[i] += (int)(10 * Math.random());
        }
        for(int i = 9; i <= 11; i++) {
            yCorners[i] -= (int)(10 * Math.random());
        }
        for(int i = 13; i <= 15; i++) {
            xCorners[i] -= (int)(10 * Math.random());
        }
        // Calculates collision distance
        collisionDistance = 0;
        for(int i = 0; i < corners; i++) {
            float distance = dist(0, 0, xCorners[i], yCorners[i]);
            if(distance > collisionDistance) {
                collisionDistance = distance;
            }
        }
        // Gives asteroid random position and speed
        myCenterX = width * Math.random();
        myCenterY = height * Math.random();
        myDirectionX = 7 * Math.random() - 3;
        myDirectionY = 7 * Math.random() - 3;
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