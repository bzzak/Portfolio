float[][] blurMatrix = { { 1.0/9.0, 1.0/9.0, 1.0/9.0 } ,
                         { 1.0/9.0, 1.0/9.0, 1.0/9.0 } ,
                         { 1.0/9.0, 1.0/9.0, 1.0/9.0 }  };
                     
float[][] brightMatrix = { { 0, 0  , 0 } ,
                           { 0, 1.5, 0 } ,
                           { 0, 0  , 0 }  };

void blur()
{
  for (int y = mouseStartY + 5; y < mouseEndY + 5; y++) {   
    for (int x = mouseStartX; x < mouseEndX; x++) {  
      float sumRed = 0;   
      float sumGreen = 0;
      float sumBlue = 0;
      for (int ky = -1; ky <= 1; ky++) {
        for (int kx = -1; kx <= 1; kx++) {
          int pos = (y + ky)*workingCopy.width + (x + kx);
          sumRed += blurMatrix[ky+1][kx+1] * red(workingCopy.pixels[pos]);
          sumGreen += blurMatrix[ky+1][kx+1] * green(workingCopy.pixels[pos]);
          sumBlue += blurMatrix[ky+1][kx+1] * blue(workingCopy.pixels[pos]);
        }
      }
      workingCopy.pixels[y*workingCopy.width + x] = color(sumRed, sumGreen, sumBlue);
    }
  }
  workingCopy.updatePixels();
}


void bright()
{
  for (int y = mouseStartY + 5; y < mouseEndY + 5; y++) {   
    for (int x = mouseStartX; x < mouseEndX; x++) {  
      float sumRed = 0;   
      float sumGreen = 0;
      float sumBlue = 0;
      for (int ky = -1; ky <= 1; ky++) {
        for (int kx = -1; kx <= 1; kx++) {
          int pos = (y + ky)*workingCopy.width + (x + kx);
          sumRed += brightMatrix[ky+1][kx+1] * red(workingCopy.pixels[pos]);
          sumGreen += brightMatrix[ky+1][kx+1] * green(workingCopy.pixels[pos]);
          sumBlue += brightMatrix[ky+1][kx+1] * blue(workingCopy.pixels[pos]);
        }
      }
      workingCopy.pixels[y*workingCopy.width + x] = color(sumRed, sumGreen, sumBlue);
    }
  }
  workingCopy.updatePixels();
}


void gray()
{
  PImage imageCopy = workingCopy.copy();
  imageCopy.filter(GRAY); 
  for (int y = mouseStartY + 5; y < mouseEndY + 5; y++) {   
    for (int x = mouseStartX; x < mouseEndX; x++) {  
      workingCopy.pixels[y*workingCopy.width + x] = imageCopy.pixels[y*workingCopy.width + x];
    }
  }
  workingCopy.updatePixels();
}


void restore()
{
  for (int y = mouseStartY + 5; y < mouseEndY + 5; y++) {   
    for (int x = mouseStartX; x < mouseEndX; x++) {  
      workingCopy.pixels[y*workingCopy.width + x] = oryginal.pixels[y*oryginal.width + x];
    }
  }
  workingCopy.updatePixels();
}
