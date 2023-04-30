public abstract class Button
{
  protected float x, y, w, h;
  protected PFont font;
  
  Button(float x, float y, float w, float h, PFont font)
  {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.font = font;
  }
  
  public void draw()
  {
    
  }
}

public class MenuButton extends Button
{
  private String content;
  private float fontSize;
  private boolean highLight = false;
  private int menuOption;
  
  MenuButton(float x, float y, float w, float h, PFont font, float fontSize, String content, int menuOption)
  {
    super(x, y, w, h, font);
    this.content = content;
    this.fontSize = fontSize;
    this.menuOption = menuOption;
  }
  
  public int getMenuOption()
  {
    return menuOption;
  }
  
  public boolean isHighlighted()
  {
    return highLight;
  }
  
  public void setHighLight(boolean isHighlighted)
  {
    highLight = isHighlighted;
  }
  
  public void draw()
  {
    pushMatrix();
    if(this.highLight) fill(194, 12, 199);
    else fill(60);
    stroke(119, 11, 122);
    strokeWeight(5);
    rect(x, y, w, h, 20);
    if(this.highLight) fill(175);
    else fill(200);
    textFont(font);
    textSize(fontSize);
    textAlign(CENTER, CENTER);
    text(content, x + w / 2, y + h / 2);
    popMatrix();
  }

  public boolean isClicked(float mouseX, float mouseY)
  {
    if (mouseX >= this.x && mouseX <= this.x + this.w && mouseY >= this.y && mouseY <= this.y + this.h) 
    {
      this.highLight = true;
      return true;
    }

    return false;
  }

}


public class Group extends Button
{
  private String[][] data;
  private String groupName;
  
  Group(float x, float y, PFont font, String groupName, String[][] data)
  {
    super(x, y, 0.8 * width, 0.38 * height, font);
    this.groupName = groupName;
    this.data = data;
  }
  
  public void draw()
  {
    pushMatrix();
    fill(60);
    stroke(119, 11, 122);
    strokeWeight(5);
    rect(x, y + groupScroll, w, h, 20);
    textFont(font);
    fill(150);
    textSize(0.07 * width);
    textAlign(LEFT, TOP);
    text(groupName, x + 0.02 * width, y + 0.02 * width + groupScroll);
    textSize(0.045 * width);
    text("Druzyna                       RM  W  R  P  RB  Pkt", x + 0.02 * width, y + 0.12 * width + groupScroll);
    strokeWeight(3);
    stroke(150);
    line(x + 0.02 * width, y + 0.20 * width + groupScroll, x + w - 0.03 * width,y + 0.20 * width + groupScroll);
    text("1  ", x + 0.03 * width, y + 0.24 * width + groupScroll);
    image(flags[Integer.parseInt(data[0][1])], x + 0.07 * width, y + 0.235 * width + groupScroll, 0.06 * width, 0.06 * width);
    text(data[0][0], x + 0.15  * width, y + 0.235 * width + groupScroll);
    text(data[0][2], x + 0.42  * width, y + 0.235 * width + groupScroll);
    text(data[0][3], x + 0.485 * width, y + 0.235 * width + groupScroll);
    text(data[0][4], x + 0.555 * width, y + 0.235 * width + groupScroll);
    text(data[0][5], x + 0.593 * width, y + 0.235 * width + groupScroll);
    text(data[0][6], x + 0.655 * width, y + 0.235 * width + groupScroll);
    text(data[0][7], x + 0.715 * width, y + 0.235 * width + groupScroll);
    line(x + 0.02 * width, y + 0.32 * width + groupScroll, x + w - 0.03 * width,y + 0.32 * width + groupScroll);
    text("2  ", x + 0.03 * width, y + 0.36 * width + groupScroll);
    image(flags[Integer.parseInt(data[1][1])], x + 0.07 * width, y + 0.355 * width + groupScroll, 0.06 * width, 0.06 * width);
    text(data[1][0], x + 0.15 * width, y + 0.355 * width + groupScroll);
    text(data[1][2], x + 0.42 * width, y + 0.355 * width + groupScroll);
    text(data[1][3], x + 0.485 * width, y + 0.355 * width + groupScroll);
    text(data[1][4], x + 0.555 * width, y + 0.355 * width + groupScroll);
    text(data[1][5], x + 0.593 * width, y + 0.355 * width + groupScroll);
    text(data[1][6], x + 0.655 * width, y + 0.355 * width + groupScroll);
    text(data[1][7], x + 0.715 * width, y + 0.355 * width + groupScroll);
    line(x + 0.02 * width, y + 0.44 * width + groupScroll, x + w - 0.03 * width,y + 0.44 * width + groupScroll);
    text("3  ", x + 0.03 * width, y + 0.48 * width + groupScroll);
    image(flags[Integer.parseInt(data[2][1])], x + 0.07 * width, y + 0.475 * width + groupScroll, 0.06 * width, 0.06 * width);
    text(data[2][0], x + 0.15 * width, y + 0.475 * width + groupScroll);
    text(data[2][2], x + 0.42 * width, y + 0.475 * width + groupScroll);
    text(data[2][3], x + 0.485 * width, y + 0.475 * width + groupScroll);
    text(data[2][4], x + 0.555 * width, y + 0.475 * width + groupScroll);
    text(data[2][5], x + 0.593 * width, y + 0.475 * width + groupScroll);
    text(data[2][6], x + 0.655 * width, y + 0.475 * width + groupScroll);
    text(data[2][7], x + 0.715 * width, y + 0.475 * width + groupScroll);
    line(x + 0.02 * width, y + 0.56 * width + groupScroll, x + w - 0.03 * width,y + 0.56 * width + groupScroll);
    text("4  ", x + 0.03 * width, y + 0.60 * width + groupScroll);
    image(flags[Integer.parseInt(data[3][1])], x + 0.07 * width, y + 0.595 * width + groupScroll, 0.06 * width, 0.06 * width);
    text(data[3][0], x + 0.15 * width, y + 0.595 * width + groupScroll);
    text(data[3][2], x + 0.42 * width, y + 0.595 * width + groupScroll);
    text(data[3][3], x + 0.485 * width, y + 0.595 * width + groupScroll);
    text(data[3][4], x + 0.555 * width, y + 0.595 * width + groupScroll);
    text(data[3][5], x + 0.593 * width, y + 0.595 * width + groupScroll);
    text(data[3][6], x + 0.655 * width, y + 0.595 * width + groupScroll);
    text(data[3][7], x + 0.715 * width, y + 0.595 * width + groupScroll);
    
    popMatrix();
  
  }
}
