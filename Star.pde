class Star //note that this class does NOT extend Floater
{
  private float x;
  private float y;
  private int myColor;
  private float size;
  public Star() {
    x = (float)(width * Math.random());
    y = (float)(height * Math.random());
    myColor = color(240, 240, 240, (float)(255 * Math.random()));
    size = (float)(20 * Math.random());
  }
  public void show() {
    fill(myColor);
    noStroke();
    ellipse(x, y, size, size);
  }
}
