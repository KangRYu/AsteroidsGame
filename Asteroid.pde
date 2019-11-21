class Asteroid extends Floater {
    private float rotationSpeed; // In degrees
    private PShape myShape; // The shape of the asteroid
    public Asteroid() {
        // Makes the asteroid brown
        myColor = color(173, 137, 64);
        // Initializes the asteroid shape
        corners = 16;
        xCorners = new int[]{-20, -10, 0, 10, 20, 20, 20, 20, 20, 10, 0, -10, -20, -20, -20, -20};
        yCorners = new int[]{20, 20, 20, 20, 20, 10, 0, -10, -20, -20, -20, -20, -20, -10, 0, 10};
        // Randomizes the shape of the asteroid
        for(int i = 0; i < xCorners.length; i++) {
            xCorners[i] += (int)(11 * Math.random()) - 5;
        }
        for(int i = 0; i < yCorners.length; i++) {
            yCorners[i] += (int)(11 * Math.random()) - 5;
        }
        // Creates and stores the shape of the asteroid
        myShape = createShape();
        noStroke();
        myShape.beginShape();
        for(int i = 0; i < xCorners.length; i++) {
            myShape.vertex(xCorners[i], yCorners[i]);
        }
        myShape.endShape();
        myShape.setFill(myColor);
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
    public void show() {
        fill(myColor);   
        stroke(myColor);    
        //translate the (x,y) center of the ship to the correct position
        translate((float)myCenterX, (float)myCenterY);
        //convert degrees to radians for rotate()     
        float dRadians = (float)(myPointDirection*(Math.PI/180));
        //rotate so that the polygon will be drawn in the correct direction
        rotate(dRadians);
        //draw the polygon
        shape(myShape, 0, 0);
        //"unrotate" and "untranslate" in reverse order
        rotate(-1*dRadians);
        translate(-1*(float)myCenterX, -1*(float)myCenterY);
    }
    public double getX() {
        return myCenterX;
    }
    public double getY() {
        return myCenterY;
    }
}