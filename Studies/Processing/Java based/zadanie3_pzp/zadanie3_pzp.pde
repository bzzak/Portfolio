String fontname1 = "SimpleMelody";
 String fontname2 = "Athena";
 String fontnameDefault = "MontereyFLF";

 String message = "";
 float fontSize = 32;
 
 Button button1;
 Button button2;
 Slider slider;
 
 PFont font1;
 PFont font2;
 PFont fontDefault;
 PFont currentFont;
 
 float scrollValue = 0;

 
 Container container = new Container();
 
void setup()
{
  font1 = createFont(fontname1 + ".ttf", 30);
  font2 = createFont(fontname2 + ".ttf", 30);
  fontDefault = createFont(fontnameDefault + ".ttf", 30);
  currentFont = font1;
  button1 = new Button(40, 710, 200, 50, font1, fontname1);
  button2 = new Button(40, 815, 200, 50, font2, fontname2);
  slider = new Slider(550, 775, 50, 25, fontDefault, "");
  size(900, 900);
  textFont(font1);
}

void draw()
{
  strokeWeight(3);
  background(255, 255, 255);
  pushMatrix();
  fill(0,0,0);
  text(message, 300, 300);
  popMatrix();
  pushMatrix();
    translate(0, -scrollValue);
    container.read();
  popMatrix();
  push();
    fill(124,255,124);
    rect(0, 0.75 * height, width, 0.75 * height);
    button2.draw();
    button1.draw();
    slider.draw();
  pop();
  
  pushMatrix();
  strokeWeight(6);
  line(0, 0.75 * height, width, 0.75 * height);
  popMatrix();
}
