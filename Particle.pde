class Particle {
    private float x, y;
    private float rotation;
    private float velocity;
    private float velocityAngle; // In radians
    private float size;
    private int myColor;
    public Particle() {
        size = (float)(10 * Math.random());
        myColor = color(255);
    }
    public void move() {
        x += velocity * Math.cos(velocityAngle);
        y += velocity * Math.sin(velocityAngle);
        velocity *= 0.95;
    }
    public void show() {
        translate(x, y);
        rotate(rotation);
        rect(0, 0, size, size);
        rotate(-rotation);
        translate(-x, -y);
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