class Wrapper
{
  public ArrayList<Box> boxes;
  public ArrayList<Shape> shapes;
  public ArrayList<ComplexObject> complexObjects;
  
  public Wrapper()
  {
    boxes = new ArrayList<Box>();
    complexObjects = new ArrayList<ComplexObject>();
    shapes = new ArrayList<Shape>();
  }
  
  public void drawPrimitives()
  {
    for(var box : boxes)
    {
      box.draw(); 
    }
  }
  
  public void drawShapes()
  {
    for(var shape : shapes)
    {
      shape.draw(); 
    }
  }
  
  public void drawComplexObjects()
  {
    for(var complexObject : complexObjects)
    {
      complexObject.draw(); 
    }
  }
}
