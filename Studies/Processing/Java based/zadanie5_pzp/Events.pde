void mousePressed() 
{
  if(mouseY <=  0.9 * height)
  {
    mouseStartX = mouseX;
    mouseStartY = mouseY;
    mouseEndX = mouseX;
    mouseEndY = mouseY;
    print(mouseStartX);
  }
  
  blurButton.isClicked(mouseX, mouseY);
  restoreButton.isClicked(mouseX, mouseY);
  brightButton.isClicked(mouseX, mouseY);
  filterButton.isClicked(mouseX, mouseY);
  saveButton.isClicked(mouseX, mouseY);

}

void mouseDragged()
{
  if(mouseY <=  0.9 * height)
  {
    mouseEndX = mouseX;
    mouseEndY = mouseY;
  }
}

void mouseReleased()
{
    int temp = 0;
    if(mouseEndX < mouseStartX)
    {
      temp = mouseEndX;
      mouseEndX = mouseStartX;
      mouseStartX = temp;
    }
    
    if(mouseEndY < mouseStartY)
    {
      temp = mouseEndY;
      mouseEndY = mouseStartY;
      mouseStartY = temp;
    } 
}

void saveImage(File selection)
{
    workingCopy.save(selection.getAbsolutePath() + "\\file("+saveIteration+").jpg");
    saveIteration++;
}
