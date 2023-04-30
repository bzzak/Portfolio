abstract class Object
{
 private int x, y, z, rX, rY, rZ;
 
 public Object()
 {
  x = int(random(-500, 500)); 
  y = int(random(-500, 500)); 
  z = int(random(-500, 500)); 
  rX = int(random(0,7));
  rY = int(random(0,7));
  rZ = int(random(0,7));
  
 }
}

class Box extends Object
{
  private int a;
  
  public Box(int givenA)
  {
     super(); 
     a = givenA;
  }
  
  public void draw()
  {
    pg.pushMatrix();
      pg.fill(255, 255, 255);
      pg.translate(super.x, super.y, super.z);
      pg.rotateX(super.rX);
      pg.rotateY(super.rY);
      pg.rotateZ(super.rZ);
      pg.lightSpecular(125, 255, 125);
      pg.box(a);
    pg.popMatrix();
  }
}

class Shape extends Object
{ 
  public Shape()
  {
     super(); 
  }
  
  public void draw()
  {
    pg.pushMatrix();
      pg.fill(225, 225, 0);
      pg.translate(super.x, super.y, super.z);
      pg.rotateX(super.rX);
      pg.rotateY(super.rY);
      pg.rotateZ(super.rZ);
      pg.scale(10);
      pg.shape(shape);
    pg.popMatrix();
  }
}

class ComplexObject extends Object
{
  private int r;
  
  public ComplexObject()
  {
     super(); 
  }
  
  public void draw()
  {
    pg.pushMatrix();
      pg.fill(255,255,255);
      pg.translate(super.x, super.y, super.z);
      pg.rotateX(super.rX);
      pg.rotateY(super.rY);
      pg.rotateZ(super.rZ);
      
      if(!isTextureOn)
        pg.stroke(0, 0, 255);
        
      pg.beginShape(TRIANGLES);
        if(isTextureOn)
        {
          pg.texture(img);
          pg.textureMode(NORMAL);
        }

        pg.vertex( -100, -100, 100, .5, 0);
        pg.vertex( 100, -100, 100, 0, 1);
        pg.vertex( 0, 100, 0, 1, 1);
        
        pg.vertex( -100, -100, 100, .5, 0);
        pg.vertex( 0, -100, -100, 0, 1);
        pg.vertex( 0, 100, 0, 1, 1);
        
        pg.vertex(  100, -100, 100, .5, 0);
        pg.vertex(  0, 100, -100, 0, 1);
        pg.vertex(  0,  100,  0, 1, .5);
        
        pg.vertex(  -100, -100, 100, .5, 1);
        pg.vertex(  100, -100, 100, 0, 1);
        pg.vertex(  0,  100,  -100, 1, 1);

      pg.endShape();
      pg.noStroke();
    pg.popMatrix();
  }
}
