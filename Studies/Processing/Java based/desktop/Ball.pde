class Ball {
  private float x, y;
  private float radius;
  private PShape ball;
  public CircleCollider collider;
  
  Ball(String ballPath, float x, float y, float radius){
    this.ball = loadShape(ballPath);
    this.x = x;
    this.y = y;
    this.radius = radius;
    this.collider = new CircleCollider(x + radius, y + radius, radius * 2, TriggerType.NONE);
  }
  
  //GETTERS
  
  public CircleCollider get_collider()
  {
    return collider;
  }
  
  
  //SETTERS
  
  
  //METHODS
  
  public void move(float deltaX, float deltaY)
  {

    // X AXIS MOVEMENT
    
    x += deltaX;
 
    // Y AXIS MOVEMENT
    
    y += deltaY;
    
    updateCollider();
  }
  
  public void draw(){
    shape(ball, x, y, radius * 2, radius * 2);
    //collider.show();
  }
  
  public void moveByVector(PVector move)
  {
    x += move.x;
    y += move.y;
    updateCollider();
  }
  
  public void updateCollider()
  {
    collider.x = x + radius;
    collider.y = y + radius;
  }
  
  public void respawn()
  {
    x = SCREEN_WIDTH / 2 - radius;
    y = SCREEN_HEIGHT / 2 - radius;
  }
  
}
