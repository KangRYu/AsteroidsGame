class Spaceship extends Floater {
    private boolean forward, backward, left, right; // The direction of acceleration
    private boolean shooting;
    private float collisionDistance; // The distance until the spaceship collides with another object
    private float maxSpeed;
    private float acceleration; // Magnitude of acceleration
    private boolean hyperspacing;
    public Spaceship() {
        // Initalizes all the corners
        corners = 10;
        xCorners = new int[]{-16, -12, 0, 16, 0, -3, 0, 16, 0, -12};
        yCorners = new int[]{0, 12, 16, 8, 10, 0, -10, -8, -16, -12};
        myColor = color(90, 255, 150);
        // Initialize the collision distance
        collisionDistance = 0;
        for(int i = 0; i < corners; i++) {
            float distance = dist(0, 0, xCorners[i], yCorners[i]);
            if(distance > collisionDistance) {
                collisionDistance = distance;
            }
        }
        // Initialize spaceship position into center
        myCenterX = width/2;
        myCenterY = height/2;
        // Initialize speed and point direction
        myDirectionX = 0;
        myDirectionY = 0;
        myPointDirection = 180;
        // Sets all movement direction to false
        forward = backward = left = right = false;
        // Set hyperspacing
        hyperspacing = false;
        // Set acceleration
        acceleration = 0.15;
        // Set max speed
        maxSpeed = 15;
    }
    public void accelerate(float amount, float angle) { // Modified acceleration for custom angles
        float rads = radians(angle);
        myDirectionX += amount * Math.cos(rads);
        myDirectionY += amount * Math.sin(rads);
        // Cap speed
        float speed = sqrt(pow((float)myDirectionX, 2) + pow((float)myDirectionY, 2));
        if(speed > maxSpeed) {
            float directionAngle = atan2((float)myDirectionY, (float)myDirectionX); // The angle of movement
            myDirectionX = maxSpeed * Math.cos(directionAngle);
            myDirectionY = maxSpeed * Math.sin(directionAngle);
        }
    }
    public void update() { // Calls all the necesary functions for an update
        move();
        shoot();
        show();
    }
    public void move() {
        // Turn player to mouse angle
        turnTo(getMouseAngle());
        // Set movement based on player input
        if(forward || backward || right || left) {
            if(forward && right) { // Combination inputs
                player.accelerate(acceleration, 315);
                spawnFumes(135);
            }
            else if(forward && left) {
                player.accelerate(acceleration, 225);
                spawnFumes(45);
            }
            else if(backward && right) {
                player.accelerate(acceleration, 45);
                spawnFumes(225);
            }
            else if(backward && left) {
                player.accelerate(acceleration, 135);
                spawnFumes(315);
            }
            else { // Single inputs
                if(forward) {
                    player.accelerate(acceleration, 270);
                    spawnFumes(90);
                }
                if(backward) { // Brakes
                    player.accelerate(acceleration, 90);
                    spawnFumes(270);
                }
                if(right) {
                    player.accelerate(acceleration, 0);
                    spawnFumes(180);
                }
                if(left) {
                    player.accelerate(acceleration, 180);
                    spawnFumes(0);
                }
            }
        }
        super.move(); // Calls floater class
    }
    public void shoot() {
        if(shooting) {
            Bullet obj = new Bullet(myCenterX, myCenterY, 30, myPointDirection);
            bulletList.add(obj);
        }
    }
    public float getMouseAngle() { // Returns the angle of the mouse relative to the player in degrees
        double x = mouseX - player.getX();
        double y = mouseY - player.getY();
        return (float)(degrees((float)(Math.atan2(y, x))));
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
    public void setForward(boolean input) {
        forward = input;
    }
    public void setBackward(boolean input) {
        backward = input;
    }
    public void setRight(boolean input) {
        right = input;
    }
    public void setLeft(boolean input) {
        left = input;
    }
    public boolean getHyperspace() {
        return hyperspacing;
    }
    public void setHyperspace(boolean input) {
        hyperspacing = input;
    }
    public float getCollisionDistance() {
        return collisionDistance;
    }
    public void hyperSpace() { // Teleports the spaceship to a random position rotation
        hyperspacing = true; // Set hyperspacing to true
        // Picks random position
        myCenterX = width * Math.random();
        myCenterY = height * Math.random();
        // Kills any velocity
        myDirectionX = 0;
        myDirectionY = 0;
        // Spawn particles
        spawnParticles((float)myCenterX, (float)myCenterY, 50, 10, 0, 360, color(255));
    }
    private void spawnFumes(float angle) { // Spawns fumes for a rocket
        // Initialized spawn origin of particles
        float positionX = (float)myCenterX;
        float positionY = (float)myCenterY;
        // Calculate the direction the spaceship is pointing
        float pointAngle = atan2(mouseY - positionY, mouseX - positionX);
        // Move the particles spawn origin backward, based on the direction the spaceship is pointing
        positionY -= 10 * sin((float)pointAngle);
        // Spawn particles
        spawnParticles(positionX, positionY, 1, 5, angle, 20, color(255, 133, 25));
        spawnParticles(positionX, positionY, 1, 5, angle, 20, color(255, 238, 107));
        spawnParticles(positionX, positionY, 1, 5, angle, 20, color(255, 75, 51));
    }
    public void setShooting(boolean argBool) {
        shooting = argBool;
    }
}