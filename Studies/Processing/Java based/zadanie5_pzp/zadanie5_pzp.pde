 String fontname1 = "SimpleMelody";

 int fontSize = 32;
 
 PFont font1;
 
 PImage oryginal, workingCopy;
 
 int mouseStartX = 0;
 int mouseStartY = 0;
 int mouseEndX = 0;
 int mouseEndY = 0;
 
 int oryginalR[];
 int oryginalG[];
 int oryginalB[];
 
 
 BlurButton blurButton;
 RestoreButton restoreButton;
 BrightButton brightButton;
 FilterButton filterButton;
 SaveButton saveButton;
 
 int saveIteration = 1;
 
 
 
 
void setup()
{
  size(900, 990);
  
  font1 = createFont(fontname1 + ".ttf", 30);
  textFont(font1);
  
  blurButton = new BlurButton(100, 910, 100, 50, font1);
  restoreButton = new RestoreButton(250, 910, 100, 50, font1);
  brightButton = new BrightButton(400, 910, 100, 50, font1);
  filterButton = new FilterButton(550, 910, 100, 50, font1);
  saveButton = new SaveButton(700, 910, 100, 50, font1);
  selectInput("Select a file to process:", "fileSelected");
}

void fileSelected(File selection)
{
  oryginal = loadImage(selection.getAbsolutePath());
  workingCopy = loadImage(selection.getAbsolutePath());
  oryginal.resize(900, 900);
  workingCopy.resize(900, 900);
}

void draw()
{
  background(255, 255, 255);
  
  strokeWeight(1);
  line(0, 0.9 * height, width, 0.9 * height);
  
  noStroke();
  fill(0,60,255);
  rect(0, 0.9 * height, width,  0.1 * height);
  
  stroke(0,0,0);
  strokeWeight(1);
  
  blurButton.draw();
  restoreButton.draw();
  brightButton.draw();
  filterButton.draw();
  saveButton.draw();
  
  if(workingCopy != null)
  {
    image(workingCopy, 0, 0, width, height * 0.9);
  }
  
  
  
  noFill();
  rect(mouseStartX, mouseStartY, mouseEndX - mouseStartX, mouseEndY - mouseStartY);
}
 
 
