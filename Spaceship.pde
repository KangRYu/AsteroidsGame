class Spaceship extends Floater {
    private boolean forward, backward, left, right; // The direction of acceleration
    private float acceleration; // Magnitude of acceleration
    private boolean hyperspacing;
    public Spaceship() {
        // Initalizes all the corners
        corners = 4;
        xCorners = new int[]{-12, -5, -12, 20};
        yCorners = new int[]{-12, 0, 12, 0};
        myColor = color(90, 255, 150);
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
    }
    public void accelerate(float amount, float angleOffset) { // Modified acceleration for custom angles
        float rads = radians((float)(myPointDirection + angleOffset));
        myDirectionX += amount * Math.cos(rads);
        myDirectionY += amount * Math.sin(rads);
    }
    public void move() {
        // Turn player to mouse angle
        turnTo(getMouseAngle());
        // Set movement based on player input
        if(forward || backward || right || left) {
            if(forward) {
                player.accelerate(acceleration);
                // Spawn particles
                drawParticles(1, 10, 180, 20, color(255, 133, 25));
                drawParticles(1, 10, 180, 20, color(255, 238, 107));
                drawParticles(1, 10, 180, 20, color(255, 75, 51));
            }
            if(right) {
                player.accelerate(acceleration/2, 90);
                // Spawn particles
                drawParticles(1, 5, 90, 10, color(255, 133, 25));
                drawParticles(1, 5, 90, 10, color(255, 238, 107));
                drawParticles(1, 5, 90, 10, color(255, 75, 51));
            }
            if(left) {
                player.accelerate(acceleration/2, -90);
                // Spawn particles
                drawParticles(1, 5, -90, 10, color(255, 133, 25));
                drawParticles(1, 5, -90, 10, color(255, 238, 107));
                drawParticles(1, 5, -90, 10, color(255, 75, 51));
            }
            if(backward) { // Brakes
                player.myDirectionX *= 0.95;
                player.myDirectionY *= 0.95;
            }
        }
        super.move(); // Calls floater class
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
    public void hyperSpace() { // Teleports the spaceship to a random position rotation
        hyperspacing = true; // Set hyperspacing to true
        // Picks random position
        myCenterX = width * Math.random();
        myCenterY = height * Math.random();
        // Kills any velocity
        myDirectionX = 0;
        myDirectionY = 0;
        // Spawn particles
        drawParticles(50, 10, 0, 360, color(255));
    }
    private void drawParticles(int numOfParticles, float speed, float angle, float angleVariation, int particleColor) { // Draws particles
        for(int i = 0; i < numOfParticles; i++) { // Red particles
            Particle obj = new Particle();
            obj.setX((float)player.getX());
            obj.setY((float)player.getY());
            obj.setColor(particleColor);
            obj.setVelocity((float)(speed * Math.random()));
            obj.setVelocityAngle((float)radians((float)(getMouseAngle() - angle + (angleVariation * Math.random() - angleVariation/2))));
            particleList.add(obj);
        }
    }
}