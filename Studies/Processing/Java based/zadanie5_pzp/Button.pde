
 abstract class Button
{
  private int x, y, w, h;
  private PFont font;
  protected int highLightCounter = 0;
  
  Button(int x, int y, int w, int h, PFont font)
  {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.font = font;
  }
}

class BlurButton extends Button
{
 
  BlurButton(int x, int y, int w, int h, PFont font)
  {
   super(x, y, w, h, font); 
  }
  
  void draw()
  {
    if(highLightCounter > 0) fill(255, 0, 0);
    else fill(128, 255, 35);
    rect(super.x, super.y, super.w, super.h, 20);
    textFont(super.font);
    fill(0, 0, 0);
    text("Blur" ,super.x + 30, super.y + 35);
    if(highLightCounter > 0) highLightCounter--;
  }
  
  void isClicked(float mouseX, float mouseY)
  {
    if (mouseX >= super.x && mouseX <= super.x + super.w && mouseY >= super.y && mouseY <= super.y + super.h) 
    {
      highLightCounter = 5;
      blur();
    }
  }
}


class BrightButton extends Button
{
 
  BrightButton(int x, int y, int w, int h, PFont font)
  {
   super(x, y, w, h, font); 
  }
  
  void draw()
  {
    if(highLightCounter > 0) fill(255, 0, 0);
    else fill(128, 255, 35);
    rect(super.x, super.y, super.w, super.h, 20);
    textFont(super.font);
    fill(0, 0, 0);
    text("Brighten" ,super.x + 5, super.y + 35);
    if(highLightCounter > 0) highLightCounter--;
  }
  
  void isClicked(float mouseX, float mouseY)
  {
    if (mouseX >= super.x && mouseX <= super.x + super.w && mouseY >= super.y && mouseY <= super.y + super.h) 
    {
      highLightCounter = 5;
      bright();
    }
  }
}


class FilterButton extends Button
{
 
  FilterButton(int x, int y, int w, int h, PFont font)
  {
   super(x, y, w, h, font); 
  }
  
  void draw()
  {
    if(highLightCounter > 0) fill(255, 0, 0);
    else fill(128, 255, 35);
    rect(super.x, super.y, super.w, super.h, 20);
    textFont(super.font);
    fill(0, 0, 0);
    text("Gray" ,super.x + 20, super.y + 35);
    if(highLightCounter > 0) highLightCounter--;
  }
  
  void isClicked(float mouseX, float mouseY)
  {
    if (mouseX >= super.x && mouseX <= super.x + super.w && mouseY >= super.y && mouseY <= super.y + super.h) 
    {
      highLightCounter = 5;
      gray();
    }
  }
}


class RestoreButton extends Button
{
 
  RestoreButton(int x, int y, int w, int h, PFont font)
  {
   super(x, y, w, h, font); 
  }
  
  void draw()
  {
    if(highLightCounter > 0) fill(255, 0, 0);
    else fill(128, 255, 35);
    rect(super.x, super.y, super.w, super.h, 20);
    textFont(super.font);
    fill(0, 0, 0);
    text("Restore" ,super.x + 12, super.y + 35);
    if(highLightCounter > 0) highLightCounter--;
  }
  
  void isClicked(float mouseX, float mouseY)
  {
    if (mouseX >= super.x && mouseX <= super.x + super.w && mouseY >= super.y && mouseY <= super.y + super.h) 
    {
      highLightCounter = 5;
      restore();
    }
  }
}


class SaveButton extends Button
{
 
  SaveButton(int x, int y, int w, int h, PFont font)
  {
   super(x, y, w, h, font); 
  }
  
  void draw()
  {
    if(highLightCounter > 0) fill(255, 0, 0);
    else fill(128, 255, 35);
    rect(super.x, super.y, super.w, super.h, 20);
    textFont(super.font);
    fill(0, 0, 0);
    text("Save" ,super.x + 20, super.y + 35);
    if(highLightCounter > 0) highLightCounter--;
  }
  
  void isClicked(float mouseX, float mouseY)
  {
    if (mouseX >= super.x && mouseX <= super.x + super.w && mouseY >= super.y && mouseY <= super.y + super.h) 
    {
      highLightCounter = 5;
      selectFolder("Specify location for saving the file", "saveImage");
    }
  }
}
