void keyPressed()
{
  if (keyCode == LEFT) 
  {
     rotation -= 0.5; 
  }
  else if(keyCode == RIGHT)
  {
    rotation += 0.5; 
  }
  
  else if(key == ',')
  {
     isAmbientOn = !isAmbientOn; 
  }
  else if(key == '.')
  {
     isPointLightOn = !isPointLightOn; 
  }
  else if(key == '/')
  {
    isDirectionalLightOn = !isDirectionalLightOn; 
  }
  
  else if(key == 't')
  {
     isTextureOn = !isTextureOn; 
  }
  
  else if(key == 's')
  {
     pg.save("frame.png"); 
  }
}
