enum TriggerType
{
  POINTP1, POINTP2, BALLRESPAWN, NONE;
}


abstract class Collider {
  public float x, y;
  public boolean isTrigger;
  public TriggerType triggerType;
  
  Collider(float x, float y, TriggerType triggerType){
    this.x = x;
    this.y = y;
    this.triggerType = triggerType;
    if(triggerType == TriggerType.NONE)this.isTrigger = false;
    else this.isTrigger = true;
  }
  
  protected abstract void show();

}

class RectCollider extends Collider{
  public float w, h;
  
  RectCollider(float x, float y, float w, float h, TriggerType triggerType) {
    super(x, y, triggerType);
    this.w = w;
    this.h = h;
  }
  
  @Override
  public  void show(){
    noFill();
    strokeWeight(3);
    stroke(0,255,0);
    rect(x, y, w, h);
  }
  
}

class CircleCollider extends Collider{
  public float d;
  
  CircleCollider(float x, float y, float d, TriggerType triggerType) {
    super(x, y, triggerType);
    this.d = d;
  }
  
  
  @Override
  public void show(){
    noFill();
    strokeWeight(3);
    stroke(0,255,0);
    circle(x, y, d);
  }
}
