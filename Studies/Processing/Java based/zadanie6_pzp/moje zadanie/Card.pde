class Card{
  private int x = 0;
  private int y = 0;
  private int w;
  private int h;
  private PShape cardShape;
  private String path;
  
  Card(int w, int h, String path)
  {
    this.w = w;
    this.h = h;
    this.path = path;
    this.cardShape = loadShape(path);
  }
  
  public int getX(){
    return x;
  }
  
  public int getY(){
    return y;
  }
  
  public PShape getShape(){
    return cardShape;
  }
  
  public String getPath(){
    return path;
  }
  
  public void setX(int x){
    this.x = x;
  }
  
  public void setY(int y){
    this.y = y;
  }
  
  public void setWidth(int w){
    this.w = w;
  }
  
  public void setHeight(int h){
    this.h = h;
  }
  
  
  
  public void draw() {
    shape(cardShape,x,y,w,h);
  }
  
  public void isClicked(){
    if(mouseX >= x && mouseX <= x + w && mouseY >= y && mouseY <= y + h){
        //println("click");
        if(cardShape.getChild("tyl_karty").isVisible() == true){
          //println("click inside");
          reveal();
          visibleCards.add(this);
      }
    }
  }
  
  public void hide(){
    cardShape.getChild("przod_karty").setVisible(false);
    cardShape.getChild("tyl_karty").setVisible(true);
  }
  
  public void disable(){
    cardShape.getChild("przod_karty").setVisible(false);
    cardShape.getChild("tyl_karty").setVisible(false);
  }
  
  public void reveal(){
    cardShape.getChild("przod_karty").setVisible(true);
    cardShape.getChild("tyl_karty").setVisible(false);
  }
  
}
