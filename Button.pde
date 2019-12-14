class Button {
    private float x, y; // Position
    private float w, h; // Dimensions
    private String txt; // The text displayed
    private boolean pressed, hovered;
    public Button(float argX, float argY, float argW, float argH, String argTxt) {
        x = argX;
        y = argY;
        w = argW;
        h = argH;
        txt = argTxt;
        pressed = false;
        hovered = false;
    }
    public void update() {
        show();
        detect();
    }
    public void detect() { // Detect for mouse input
        if(mouseX <= x + w/2 && mouseX >= x - w/2 && mouseY <= y + h/2 && mouseY >= y - h/2) {
            hovered = true;
            if(mousePressed) {
                pressed = true;
            }
            else {
                pressed = false;
            }
        }
        else {
            hovered = false;
            pressed = false;
        }
    }
    public void show() {
        if(pressed) {
            fill(180);
        }
        else if(hovered) {
            fill(210);
        }
        else {
            fill(255);
        }
        rectMode(CENTER);
        noStroke();
        rect(x, y, w, h, 5);
        textAlign(CENTER, CENTER);
        fill(0);
        textSize(35);
        text(txt, x, y);
        rectMode(CORNER); // Undo rect mode
    }
    public boolean isPressed() {
        return pressed;
    }
}