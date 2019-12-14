class TextFloater extends Particle {
    private String txt;
    public TextFloater(float argX, float argY, float argVelocity, float argVelocityAngle, int argColor, String argTxt) {
        super(argX, argY, argVelocity, argVelocityAngle, argColor);
        txt = argTxt;
    }
    public void show() {
        fill(myColor);
        stroke(myColor);
        textAlign(CENTER, CENTER);
        textSize(40);
        text(txt, (float)myCenterX, (float)myCenterY);
    }
}