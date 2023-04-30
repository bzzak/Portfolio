void mousePressed() 
{
  button1.isClicked(mouseX, mouseY);
  button2.isClicked(mouseX, mouseY);
}


void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  if(scrollValue + e * 10 >= 0)
  {
    scrollValue += e * 10;
  }
}


void mouseDragged()
{
  slider.isClicked(mouseX, mouseY);
}


void keyPressed()
{
  //We check if it's even a letter
  if (key >= 48 && key <= 122 || key == 46 || key == 39) {
    container.write(fontSize, key, currentFont);
  }
  
  //Space bar
  if (key == 32){
    container.write(fontSize, ' ', currentFont); 
  }
  
  //Backspace
  if (key == 8)
  {
    container.deleteLastLetter();
  }
}
