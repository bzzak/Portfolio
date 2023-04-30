class Player{
  private float x, y;
  private float respawnX, respawnY;
  private float vx = 0, vy = 0;
  private float vx_target = 0, vy_target = 0;
  private float vx_check = 0, vy_check = 0;
  
  private int w, h;
  private int originW, originH;
  private PShape head, shoe;
  private CircleCollider headCollider;
  private RectCollider shoeCollider;
  private boolean isShoeFliped;
  
  
  
  Player(float x, float y, int w, int h, String pathH, String pathS, boolean isShoeFliped)
  {
    this.x = x;
    this.y = y;
    this.respawnX = x;
    this.respawnY = y;
    this.w = w;
    this.h = h;
    this.originW = w;
    this.originH = h;
    this.head = loadShape(pathH);
    this.shoe = loadShape(pathS);
    this.isShoeFliped = isShoeFliped;
    if(isShoeFliped)
    {
      this.headCollider = new CircleCollider(x - w / 2, y + 0.8 * h / 2, 1.6 * h / 2, TriggerType.NONE);
      this.shoeCollider = new RectCollider(x - 0.75 * w,y + 0.67 * h, w * 0.9, 0.4 * h, TriggerType.NONE);
    }
    else
    {
      this.headCollider = new CircleCollider(x + w / 2, y + 0.8 * h / 2, 1.6 * h / 2, TriggerType.NONE);
      this.shoeCollider = new RectCollider(x - 0.15 * w,y + 0.67 * h, w * 0.9, 0.4 * h, TriggerType.NONE);
    }
  }
  
  //GETTERS
  
  public float get_x()
  {
    return x;
  }
  
  public float get_y()
  {
    return y;
  }
  
  public float get_respawnX()
  {
    return respawnX;
  }
  
  public float get_respawnY()
  {
    return respawnY;
  }
  
  public int get_w()
  {
    return w;
  }
  
  public int get_h()
  {
    return h;
  }
  
  
  public float get_vx()
  {
    return vx;
  }


  public float get_vy()
  {
    return vy;
  }


  public float get_vx_target()
  {
    return vx_target;
  }


  public float get_vy_target()
  {
    return vy_target;
  }


  public float get_vx_check()
  {
    return vx_check;
  }


  public float get_vy_check()
  {
    return vy_check;
  }
  
  public PShape getHead(){
    return head;
  }
  
  public PShape getShoe(){
    return shoe;
  }
  
  public boolean get_is_shoe_fliped(){
    return isShoeFliped;
  }
  
  //SETTERS
  
  public void set_x(float x)
  {
    this.x = x;
  }
  
  public void set_y(float y)
  {
    this.y = y;
  }
  
  public void set_w(int w)
  {
    this.w = w;
  }
  
  public void set_h(int h)
  {
    this.h = h;
  }
  
  public void set_vx(float new_vx)
  {
    vx = new_vx;
  }


  public void set_vy(float new_vy)
  {
    vy = new_vy;
  }


  public void set_vx_target(float new_vx_target)
  {
    vx_target = new_vx_target;
  }


  public void set_vy_target(float new_vy_target)
  {
    vy_target = new_vy_target;
  }

  public void set_vx_check(float new_vx_check)
  {
    vx_check = new_vx_check;
  }

  public void set_vy_check(float new_vy_check)
  {
    vy_check = new_vy_check;
  }
   
  public void set_is_shoe_fliped(boolean new_isShoeFliped){
    isShoeFliped = new_isShoeFliped;
  }
  
  //METHODS
  
  private final boolean get_is_vx_very_small(float smooth, float eps)
  {
    vx_check = vx_target * (1 - smooth) + vx_check * smooth;
    return vx_check <= eps && vx_check >= -eps;
  }


  private final boolean get_is_vy_very_small(float smooth, float eps)
  {
    vy_check = vy_target * (1 - smooth) + vy_check * smooth;
    return vy_check <= eps && vy_check >= -eps;
  }
  
  public void draw() 
  {
    if(isShoeFliped)
    {
      shape(head,x - w,y,w,0.8*h);
      pushMatrix();
      translate(x, y);
      scale(-1,1);
      shape(shoe,- 0.15 * w,0.67 * h, w * 0.9, 0.4 * h);
      popMatrix();
    }
    else  //<>//
    {
      shape(head,x,y,w,0.8*h);
      shape(shoe,x - 0.15 * w,y + 0.67 * h, w * 0.9, 0.4 * h);
    }
    
    //headCollider.show();
    //shoeCollider.show();
    
  }
  
  
  public void move(float smooth, float eps)
  {

    // X AXIS MOVEMENT
    
    if (get_is_vx_very_small(smooth, eps)) vx = 0;
    else vx = vx_check;

     
    x += vx * 30;
    

    // Y AXIS MOVEMENT
    
    if (get_is_vy_very_small(smooth, eps)) vy = 0;
    else vy = vy_check;
    
    y += vy * 30;
    
    updateColliders();
  }
  
  public void moveByVector(PVector move)
  {
    x += move.x;
    y += move.y;
    updateColliders();
  }
  
  private void updateColliders()
  {
    if(isShoeFliped)
    {
      headCollider.x = x - w / 2;
      headCollider.y = y + 0.8 * h / 2;
      shoeCollider.x = x - 0.75 * w;
      shoeCollider.y = y + 0.67 * h; 
    }
    else
    {
      headCollider.x = x + w / 2;
      headCollider.y = y + 0.8 * h / 2;
      shoeCollider.x = x - 0.15 * w;
      shoeCollider.y = y + 0.67 * h; 
    }
    
  }
  
  public void respawn()
  {
    x = respawnX;
    y = respawnY;
  }
  
  public void resizeToFirstSize()
  {
    w = originW;
    h = originH;
  }
  
  public void flip()
  {
    isShoeFliped = !isShoeFliped;
  }
  
}
