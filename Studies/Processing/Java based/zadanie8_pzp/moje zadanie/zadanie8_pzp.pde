//Pres LEFT and RIGHT to rotate
//Press 1 to turn on and off the ambient light
//Press 2 to turn on and off the point light
//Press 3 to turn on and off the directional light
//Press t to turn on and off texture/wireframe
//Press s to save current frame

PGraphics pg;
PImage img;
PShape shape;
float rotation = 0;

boolean isAmbientOn = true;
boolean isPointLightOn = true;
boolean isDirectionalLightOn = true;
boolean isTextureOn = true;

Wrapper wrapper;

void setup() {
  size(1000, 1000, P3D);
  noStroke();  
  shape = loadShape("objects/slenderman.obj");
  img = loadImage("textures/brick.jpg");
  
  wrapper = new Wrapper();
  //Add primitives
  for(int i = int(random(15, 35)); i > 0; i--)
  {
      wrapper.boxes.add(new Box(int(random(5,15))));
  }
  //Add complex objects
  for(int i = int(random(3, 10)); i > 0; i--)
  {
      wrapper.complexObjects.add(new ComplexObject());
  }
  //Add shapes from an object file
  for(int i = int(random(7, 15)); i > 0; i--)
  {
      wrapper.shapes.add(new Shape());
  }
  
  pg = createGraphics(width, height, P3D);
}

void draw() {
  pg.beginDraw();
  pg.background(125,125,125);
  pg.translate(width/2, height/2, 150);
  pg.rotateY(rotation);
  pg.lights();
  if(isAmbientOn)
  {
    pg.ambientLight(255, 0, 0);
  }
  if(isPointLightOn)
  {
    pg.pointLight(0, 0, 255, 0, 0, 0); 
  }
  if(isDirectionalLightOn)
  {
    pg.directionalLight(0, 255, 0, 0, -1, 0);
  }
  
  wrapper.drawPrimitives();
  wrapper.drawComplexObjects();
  wrapper.drawShapes();
  pg.endDraw();
  
  image(pg, 0, 0);
  
}
