class Particle {
    private float x, y;
    private float velocity;
    private float velocityAngle; // In radians
    private float size;
    private int myColor;
    public Particle() { // No arguement constructor
        size = (float)(10 * Math.random());
        myColor = color(255);
        velocity = 0;
        velocityAngle = 0;
    }
    public Particle(float argX, float argY, float argVelocity, float argVelocityAngle, int argColor) { // Optional constructor
        size = (float)(10 * Math.random());
        x = argX;
        y = argY;
        velocity = argVelocity;
        velocityAngle = argVelocityAngle;
        myColor = argColor;
    }
    public void update() {
        move();
        show();
    }
    public void move() {
        x += velocity * Math.cos(velocityAngle);
        y += velocity * Math.sin(velocityAngle);
        velocity *= 0.95;
    }
    public void show() {
        fill(myColor);
        stroke(myColor);
        ellipse(x, y, size, size);
    }
    public float getX() {
        return x;
    }
    public void setX(float argX) {
        x = argX;
    }
    public float getY() {
        return y;
    }
    public void setY(float argY) {
        y = argY;
    }
    public float getVelocity() {
        return velocity;
    }
    public void setVelocity(float argVelocity) {
        velocity = argVelocity;
    }
    public void setVelocityAngle(float argVelocityAngle) {
        velocityAngle = argVelocityAngle;
    }
    public void setColor(int argColor) {
        myColor = argColor;
    }
}