class Particle extends Floater{
    protected float size;
    protected boolean customShape;
    public Particle(float argX, float argY, float argVelocity, float argVelocityAngle, int argColor) { // Optional constructor
        size = (float)(10 * Math.random());
        myCenterX = argX;
        myCenterY = argY;
        myDirectionX = argVelocity * cos(argVelocityAngle);
        myDirectionY = argVelocity * sin(argVelocityAngle);
        myColor = argColor;
        customShape = false;
    }
    public void update() {
        move();
        show();
    }
    public void move() {
        super.move();
        // Damps velocity
        myDirectionX *= 0.95;
        myDirectionY *= 0.95;
    }
    public void show() {
        if(customShape) {
            super.show();
        }
        else { // Draws a circle if there is no custom shape
            fill(myColor);
            stroke(myColor);
            ellipse((float)myCenterX, (float)myCenterY, size, size);
        }
    }
    public float getVelocity() {
        return sqrt(pow((float)myDirectionX, 2) + pow((float)myDirectionY, 2));
    }
}