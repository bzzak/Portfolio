//Button Class
class Button
{
  private int x, y, w, h;
  private PFont font;
  private String fontname;
  
  
  Button(int x, int y, int w, int h, PFont font, String givenFontname)
  {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.font = font;
    this.fontname = givenFontname;
  }
  
  void draw()
  {
    fill(125, 75, 125);
    rect(this.x, this.y, this.w, this.h);
    textFont(this.font);
    fill(0, 0, 0);
    text(fontname ,this.x + 30, this.y + 35);
  }
  
  void isClicked(float mouseX, float mouseY)
  {
    if (mouseX >= this.x && mouseX <= this.x + this.w && mouseY >= this.y && mouseY <= this.h + this.y) {
      currentFont = this.font;
    }
  }  
}
