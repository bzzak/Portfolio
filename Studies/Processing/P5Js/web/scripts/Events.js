function mousePressed() 
{
  
    if( blurButton.isClicked(mouseX, mouseY)    ||
        restoreButton.isClicked(mouseX, mouseY) ||
        brightButton.isClicked(mouseX, mouseY)  ||
        filterButton.isClicked(mouseX, mouseY)  ||
        saveButton.isClicked(mouseX, mouseY))
    {
      messageContainer.saveToGraphic();
    }

    if(brushSwitch.isClicked(mouseX, mouseY))
    {
      messageContainer.saveToGraphic();
      textSwitch.deactivate();
    }
    else if(textSwitch.isClicked(mouseX, mouseY))
    {
      messageContainer.saveToGraphic();
      brushSwitch.deactivate();
    }

    let isColorSelected = colorSwitch.isClicked(mouseX, mouseY);
    fontSwitch.isClicked(mouseX, mouseY);
    imageSwitch.isClicked(mouseX, mouseY);

    paintMode = brushSwitch.isActive;
    textMode = textSwitch.isActive;

    brushColor = [colorSwitch.selectedColor[0],colorSwitch.selectedColor[1],colorSwitch.selectedColor[2]];
    currentFont = fontSwitch.data[fontSwitch.activeItem][0];


    if(mouseButton == CENTER || paintMode)
    {
        messageContainer.saveToGraphic();
        mouseStartX = 0;
        mouseStartY = 0;
        mouseEndX = 0;
        mouseEndY = 0;
    }
    else if(mouseX <= 0.85 * width &&  mouseY <=  0.8 * height && !paintMode && workingCopy != null && !isColorSelected)
    {
        messageContainer.saveToGraphic();
        mouseStartX = mouseX;
        mouseStartY = mouseY;
        mouseEndX = mouseX;
        mouseEndY = mouseY;
        //print(mouseStartX);
    }

    if(mouseX <= 0.85 * width &&  mouseY <=  0.8 * height && paintMode && workingCopy != null && !isColorSelected)
    {
      //print("Gonna draw a circle\n");
      let circle = new CircleElement(mouseX, mouseY, brushColor[0], brushColor[1], brushColor[2], brushSize);
      circle.draw();
    }
}

function mouseDragged()
{
  
  brushSlider.isClicked(mouseX, mouseY);
  textSlider.isClicked(mouseX, mouseY);

  brushSize = brushSlider.value;
  textFontSize = textSlider.value;


  if(mouseX <= 0.85 * width &&  mouseY <=  0.8 * height && !paintMode && workingCopy != null)
  {
    mouseEndX = mouseX;
    mouseEndY = mouseY;
  }
  else if(pmouseX <= 0.85 * width &&  pmouseY <=  0.8 * height && mouseX <= 0.85 * width &&  mouseY <=  0.8 * height && paintMode && workingCopy != null)
  {
    let line = new LineElement(pmouseX,  pmouseY, mouseX, mouseY, brushColor[0], brushColor[1], brushColor[2], brushSize);
    line.draw();
  }

}

function mouseReleased()
{
    let temp = 0;
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

function mouseWheel(event) {
  
  if(mouseX >= 0.85 * windowWidth)
  {
    scrollValue += event.delta;

    if(scrollValue <= minScrollValue) scrollValue = minScrollValue;
    else if(scrollValue >= maxScrollValue) scrollValue = maxScrollValue;

    imageSwitch.scroll = scrollValue;
  }
  
  return false;
}

function doubleClicked() {
  if(imageSwitch.isClicked(mouseX, mouseY))
  {
    const chosenPhoto = imageSwitch.data[imageSwitch.activeItem];
  
    oryginal = createGraphics(Math.ceil(0.85 * width - 3), Math.ceil(0.8 * height - 3));
    workingCopy = createGraphics(Math.ceil(0.85 * width - 3), Math.ceil(0.8 * height - 3));

    // oryginal = createImage(0.85 * width - 3, 0.8 * height - 3);
    // workingCopy = createImage(0.85 * width - 3, 0.8 * height - 3);

    oryginal.image(chosenPhoto, 0, 0, oryginal.width, oryginal.height);
    workingCopy.image(chosenPhoto, 0, 0, workingCopy.width, workingCopy.height);
    oryginal.loadPixels();
    workingCopy.loadPixels();

  }
}

function keyPressed()
{
  if(textMode && workingCopy != null)
  {
    //print("Key pressed detected!/n");
    //print(keyCode);

    //We check if it's even a letter
    if (keyCode >= 33) {
      //print("adding letter!\n");
      messageContainer.addElement(key, currentFont, textFontSize, brushColor[0], brushColor[1], brushColor[2]);
    }
    else if (keyCode == 32)
    {
      // Spacebar
      //print("adding space!\n");
      messageContainer.addElement(key, currentFont, textFontSize, brushColor[0], brushColor[1], brushColor[2]); 
    }
    else if (keyCode == 8)
    {
      //Backspace
      //print("Deleting!\n");
      messageContainer.deleteLastElement();
    }
  }
}
