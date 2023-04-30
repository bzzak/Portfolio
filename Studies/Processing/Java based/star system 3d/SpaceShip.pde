import java.util.LinkedList;

class SpaceShip{
    private LinkedList<Object[]> axisTransList = new LinkedList<Object[]>();
    private PVector coord;
    private PVector lookAt;
    private PVector lookFrom;
    private Float angle = Float.valueOf(0);
    private float rotSpeed;
    private float runSpeed;
    private PShape ship;
    private boolean rotateXForward, rotateYForward, rotateZForward;
    private boolean rotateXBackward, rotateYBackward, rotateZBackward;
    private boolean run, stop;
    private float move = 0;
    int rx = 0, ry = 0, rz = 0, s = 0;
    // Test guide lines
    //private PShape lineXShip = createShape(LINE, 0, 0, 0, 10000, 0, 0);
    //private PShape lineYShip = createShape(LINE, 0, 0, 0, 0, 10000, 0);
    //private PShape lineZShip = createShape(LINE, 0, 0, 0, 0, 0, 10000);
    
    public SpaceShip(float distance, String objPath, float rSpeed, float rnSpeed){
      this.ship = loadShape(objPath);
      this.lookAt = new PVector(0,0,0);
      this.lookFrom = new PVector(0,0,0);
      this.coord = PVector.random3D();
      this.coord.mult(distance);
      this.rotSpeed = rSpeed;
      this.runSpeed = rnSpeed;
      //Test Guide Lines Color
      //stroke(2);
      //lineXShip.setFill(color(255,0,0));
      //lineXShip.setStroke(color(255,0,0));
      //lineYShip.setFill(color(0,255,0));
      //lineYShip.setStroke(color(0,255,0));
      //lineZShip.setFill(color(0,0,255));
      //lineZShip.setStroke(color(0,0,255));
      noStroke();
    }
    
    public float getVectorX(){
      return coord.x; 
    }
    
    public float getVectorY(){
      return coord.y; 
    }
    
    public float getVectorZ(){
      return coord.z; 
    }
    public float getVectorXLookAt(){
      return lookAt.x; 
    }
    
    public float getVectorYLookAt(){
      return lookAt.y; 
    }
    
    public float getVectorZLookAt(){
      return lookAt.z; 
    }
    
    public float getVectorXLookFrom(){
      return lookFrom.x; 
    }
    
    public float getVectorYLookFrom(){
      return lookFrom.y; 
    }
    
    public float getVectorZLookFrom(){
      return lookFrom.z; 
    }
    
    public void display() {
          controller();
  
          pushMatrix();
          translate(coord.x, coord.y, coord.z);
          
          for(Object[] t : axisTransList){
          if(t[0] == Character.valueOf('x')) {
            angle = (Float) t[1];
            rotateX(angle.floatValue());
            //println("X:  ",rotSpeedX);
          } else if(t[0] == Character.valueOf('y')) {
            angle = (Float) t[1];
            rotateY(angle.floatValue());
            //println("Y:  ",rotSpeedY);
          } else if(t[0] == Character.valueOf('z')) {
            angle = (Float) t[1];
            rotateZ(angle.floatValue());
            //println("Z:  ",rotSpeedZ);
          } 
        }
        
        translate(0, 0, move);
        //shape(lineXShip);
        //shape(lineYShip);
        //shape(lineZShip);
        scale(17.0);
        shape(ship);
        coord.x = modelX(0,0,0);
        coord.y = modelY(0,0,0);
        coord.z = modelZ(0,0,0);
        lookFrom.x = modelX(0,-5,-25);
        lookFrom.y = modelY(0,-5,-25);
        lookFrom.z = modelZ(0,-5,-25);
        lookAt.x = modelX(0,0,75);
        lookAt.y = modelY(0,0,75);
        lookAt.z = modelZ(0,0,75);
        popMatrix();
        camera(this.getVectorXLookFrom(), this.getVectorYLookFrom(), this.getVectorZLookFrom(), this.getVectorXLookAt(), this.getVectorYLookAt(), this.getVectorZLookAt(),0,1,0);
    }
    
    public void pressKey(char sign) {
        switch (sign) {
            case 'D': {
                println("d true");
                rotateYForward = true;
                break;
            }
            case 'A': {
                println("a true");
                rotateYBackward = true;
                break;
            }
            case 'S': {
                println("s true");
                rotateXForward = true;
                break;
            }
            case 'W': {
                println("w true");
                rotateXBackward = true;
                break;
            }
            case 'E': {
                println("e true");
                rotateZForward = true;
                break;
            }
            case 'Q': {
                println("q true");
                rotateZBackward = true;
                break;
            }
            case ' ': {
                println("space true");
                run = true;
                break;
            }
            case 'M': {
                println("shift true");
                stop = true;
                break;
            }
        }
      
    }

    public void releaseKey(char sign) {
      println("transList:");
      for(Object[] trans: axisTransList){
        println("axis: ", trans[0].toString(), "  Value: ", trans[1].toString());
      }
        switch (sign) {
            case 'D': {
                println("d false");
                rotateYForward = false;
                break;
            }
            case 'A': {
                println("a false");
                rotateYBackward = false;
                break;
            }
            case 'S': {
                println("s false");
                rotateXForward = false;
                break;
            }
            case 'W': {
                println("w false");
                rotateXBackward = false;
                break;
            }
            case 'E': {
                println("e false");
                rotateZForward = false;
                break;
            }
            case 'Q': {
                println("q false");
                rotateZBackward = false;
                break;
            }
            case ' ': {
                println("space false");
                run = false;
                break;
            }
            case 'M': {
                println("shift false");
                stop = false;
                break;
            }
        }
    }
    
    private void controller() {
        if (rotateXForward && rotateXBackward) {
        }
        else if (rotateXForward) {
          matrixManipulation('x', true);
        }
        else if (rotateXBackward) {
          matrixManipulation('x', false);
        }
        else {
        }
        if (rotateYForward && rotateYBackward) {
        }
        else if (rotateYForward) { //<>//
          matrixManipulation('y', false);
        } 
        else if (rotateYBackward) {
          matrixManipulation('y', true);
        }
        else {
        }
        if (rotateZForward && rotateZBackward) {
        }
        else if (rotateZForward) {
          matrixManipulation('z', true);
        } 
        else if (rotateZBackward) {
          matrixManipulation('z', false);
        }
        else {
        }
        
        
        
        if (run && stop) {
          move = 0;
        }
        else if (run) {
          move = runSpeed;
        } 
        else if (stop) {
          move = -runSpeed;
        }
        else {
          move = 0;
        }
    }
    
    private void matrixManipulation(char axis, boolean sign){
      Object[] transPart = new Object[2];
      float speedDirection = 1;
      if(!sign) speedDirection = -1;
      if(!axisTransList.isEmpty() && axisTransList.getLast()[0] == Character.valueOf(axis)) {
        transPart[0] = Character.valueOf(axis);
        transPart[1] = Float.sum((Float)axisTransList.getLast()[1], speedDirection * rotSpeed);
        axisTransList.set(axisTransList.size()-1,transPart);
       // println("replaced");
     
      } else {
        transPart[0] = Character.valueOf(axis);
        transPart[1] = Float.valueOf(speedDirection * rotSpeed);
        axisTransList.add(transPart);
       // println("added");
      println("transList:");
      for(Object[] trans: axisTransList){
        println("axis: ", trans[0].toString(), "  Value: ", trans[1].toString());
      }
      }
    }
  
  
}
