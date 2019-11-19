class Spaceship extends Floater {
    private boolean forward, backward, left, right; // The direction of acceleration
    private boolean hyperspacing;
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
        // Sets all movement direction to false
        forward = backward = left = right = false;
        // Set hyperspacing
        hyperspacing = false;
    }
    public void move() {
        // Turn player to mouse angle
        turnTo(getMouseAngle());
        // Set movement based on player input
        if(forward || backward || right || left) {
            float angle = 0;
            if(forward) {
                angle = 180;
                player.accelerate(0.5);
            }
            if(backward) {
                angle = 0;
                player.accelerate(-0.5);
            }
            // Spawn particles
            for(int i = 0; i < 3; i++) { // Orange particles
                Particle obj = new Particle();
                obj.setX((float)player.getX());
                obj.setY((float)player.getY());
                obj.setColor(color(255, 133, 25));
                obj.setVelocity((float)(10 * Math.random()));
                obj.setVelocityAngle((float)radians((float)(getMouseAngle() - angle + (20 * Math.random() - 10))));
                particleList.add(obj);
            }
            for(int i = 0; i < 3; i++) { // Yellow particles
                Particle obj = new Particle();
                obj.setX((float)player.getX());
                obj.setY((float)player.getY());
                obj.setColor(color(255, 238, 107));
                obj.setVelocity((float)(10 * Math.random()));
                obj.setVelocityAngle((float)radians((float)(getMouseAngle() - angle + (20 * Math.random() - 10))));
                particleList.add(obj);
            }
            for(int i = 0; i < 3; i++) { // Red particles
                Particle obj = new Particle();
                obj.setX((float)player.getX());
                obj.setY((float)player.getY());
                obj.setColor(color(255, 75, 51));
                obj.setVelocity((float)(10 * Math.random()));
                obj.setVelocityAngle((float)radians((float)(getMouseAngle() - angle + (20 * Math.random() - 10))));
                particleList.add(obj);
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
        // Spawn particles at original position
        for(int i = 0; i < 50; i++) {
            Particle obj = new Particle();
            obj.setX((float)player.getX());
            obj.setY((float)player.getY());
            obj.setVelocity((float)(10 * Math.random()));
            obj.setVelocityAngle((float)(radians((float)Math.random() * 360)));
            particleList.add(obj);
        }
        hyperspacing = true; // Set hyperspacing to true
        // Picks random position
        myCenterX = width * Math.random();
        myCenterY = height * Math.random();
        // Kills any velocity
        myDirectionX = 0;
        myDirectionY = 0;
        // Spawn particles
        for(int i = 0; i < 50; i++) {
            Particle obj = new Particle();
            obj.setX((float)player.getX());
            obj.setY((float)player.getY());
            obj.setVelocity((float)(10 * Math.random()));
            obj.setVelocityAngle((float)(radians((float)Math.random() * 360)));
            particleList.add(obj);
        }
    }
}
