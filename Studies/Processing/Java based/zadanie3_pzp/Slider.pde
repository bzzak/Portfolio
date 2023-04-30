class Slider extends Button
{
  
  Slider(int x, int y, int w, int h, PFont font, String givenFontname)
  {
    super(x, y, w, h, font, givenFontname);
  }

  void draw()
  {
    fill(125, 125, 125);
    rect(275, super.y, 500, super.h);
    fill(255, 0, 0);
    rect(super.x, super.y, super.w, super.h);
    
    textFont(super.font);
    text(fontSize, 780, 795);
    
    fill(255, 255, 255);
  }
  
  void isClicked(float mouseX, float mouseY)
  {
    if (mouseX >= super.x && mouseX <= super.x + super.w && mouseY >= super.y && mouseY <= super.h + super.y) 
    {
      if(int(mouseX) - 25 < super.x && super.x >= 275)
      {
        super.x = int(mouseX) - 25;
        this.draw();
        fontSize = round((mouseX - 100) / 20) + 20;
      }
      
      else if(int(mouseX) - 25 > super.x && super.x <= 725)
      {
        super.x = int(mouseX) - 25;
        this.draw();
        fontSize = round((mouseX - 100) / 20) + 20;
      }

    }
  }
}
