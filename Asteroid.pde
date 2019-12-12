class Asteroid extends Floater {
    private float health;
    private boolean spawning;
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
        myDirectionX = 4 * Math.random() - 2;
        myDirectionY = 4 * Math.random() - 2;
        if(abs((float)myDirectionX) >= abs((float)myDirectionY)) {
            if(myDirectionX >= 0) {
                myCenterX = -2 * collisionDistance - 20 * Math.random();
            }
            else {
                myCenterX = width + 2 * collisionDistance + 20 * Math.random();
            }
            if(myDirectionY >= 0) {
                myCenterY = height / 2 * Math.random();
            }
            else {
                myCenterY = height / 2 + height / 2 * Math.random();
            }
        }
        else {
            if(myDirectionY >= 0) {
                myCenterY = -2 * collisionDistance - 20 * Math.random();
            }
            else {
                myCenterY = height + 2 * collisionDistance + 20 * Math.random();
            }
            if(myDirectionX >= 0) {
                myCenterX = width / 2 * Math.random();
            }
            else {
                myCenterX = width / 2 + width / 2 * Math.random();
            }
        }
        // Gives asteroid random rotation and rotation speed
        myPointDirection = 360 * Math.random();
        rotationSpeed = (float)(10 * Math.random() - 10);
        // Initialize health
        health = 100;
        // Initialize spawning variable
        spawning = true;
    }
    public void update() {
        move();
        show();
    }
    public void turn(float argRotation) { // Overwrites floater turn to use floats instead of integers
        myPointDirection += argRotation;
    }
    public void move() {
        turn(rotationSpeed);
        if(spawning) { // Disable screen wrap when the asteroid is just spawning, as it spawns outside the screen
            myCenterX += myDirectionX;
            myCenterY += myDirectionY;
            if(myCenterX + collisionDistance > 0 && myCenterX - collisionDistance < width && myCenterX >) {

            }
        }
        else {
            super.move();
        }
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
    public int getColor() {
        return myColor;
    }
    public float getVelocity() {
        return sqrt(pow((float)myDirectionX, 2) + pow((float)myDirectionY, 2));
    }
    public void addHealth(float input) {
        health += input;
    }
    public float getHealth() {
        return health;
    }
}