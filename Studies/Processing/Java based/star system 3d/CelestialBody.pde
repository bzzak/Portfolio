// Class representing a celestial body in the space like planet or star

class CelestialBody{
  //  Properties
   PShape shape;
   float shapeScale;
   int distance;
   float currentAngle;
   float currentRotateAngle;
   float orbitAngle;
   float orbitSpeed;
   float rotateSpeed;
   boolean specialLight = false;
   boolean specularOn = false;
   CelestialBody[] satelites = null;
   
   PVector v = new PVector(1,0,0);
   
   
   
   //  Constructors
   CelestialBody(PShape s, int d, float oA, float oS, float rS){
       shape = s;
       distance = d;
       orbitAngle = oA;
       orbitSpeed = oS;
       rotateSpeed = rS;
       v.mult(distance);
       if(distance != 0){
       currentAngle = random(TWO_PI);
       } else currentAngle = 0;
       currentRotateAngle = 0;
       shapeScale = 1;
   }
   
   CelestialBody(PShape s, float scale, int d, float oA, float oS, float rS){
       this(s, d, oA, oS, rS);
       shapeScale = scale;
   }
   
   CelestialBody(PShape s, int d, float oA, float oS, float rS, CelestialBody[] sat){
       this(s, d, oA, oS, rS);
       satelites = sat;
   }
   
   CelestialBody(PShape s, float scale, int d, float oA, float oS, float rS, CelestialBody[] sat){
       this(s, d, oA, oS, rS);
       satelites = sat;
       shapeScale = scale;
   }
   
   CelestialBody(PShape s, float scale, int d, float oA, float oS, float rS, boolean specLight, boolean speculOn){
       this(s, d, oA, oS, rS);
       shapeScale = scale;
       specialLight = specLight;
       specularOn = speculOn;
   }
   
   CelestialBody(PShape s, int d, float oA, float oS, float rS, boolean specLight, boolean speculOn, CelestialBody[] sat){
       this(s, d, oA, oS, rS);
       satelites = sat;
       specialLight = specLight;
       specularOn = speculOn;
   }
   
   CelestialBody(PShape s, float scale, int d, float oA, float oS, float rS, boolean specLight, boolean speculOn, CelestialBody[] sat){
       this(s, d, oA, oS, rS);
       satelites = sat;
       shapeScale = scale;
       specialLight = specLight;
       specularOn = speculOn;
   }
   
   //  Methods
   
   void orbit(){
     currentAngle += orbitSpeed;
    if (satelites != null) {
      for (int i = 0; i < satelites.length; i++) {
        satelites[i].orbit();
      }
    }
   }
   
   void selfRotate(){
     currentRotateAngle += rotateSpeed;
    if (satelites != null) {
      for (int i = 0; i < satelites.length; i++) {
        satelites[i].selfRotate();
      }
    }
   }
  
  void show(){
    pushMatrix();
    noStroke();
    rotateX(orbitAngle);
    rotateY(currentAngle);
    translate(v.x, v.y, v.z);
    rotateY(currentRotateAngle);
    scale(shapeScale);
    if(distance == 0){
      emissive(255,255,255);
      //ambientLight(255,255,255);
    } else if(specularOn){
      //shininess(25);//size of specular (bigger value -> greater specular)
      //specular(255, 0, 0);
    } 
    shape(shape);
    if(distance == 0){
      lightSpecular(255,0,0);//color of specular light
      pointLight(255, 255, 255, 0, 0, 0);
      emissive(0,0,0);
    } else if(specialLight){
      translate(75, 0, 0);
      spotLight(255, 255, 255, 0, 0, 0, 170, 0, 0, PI/2, 50);
    }
    if(specularOn){
      //shininess(100000);//size of specular (bigger value -> lesser specular)
      //specular(0, 0, 0);
    }
    
    popMatrix();
    pushMatrix();
    noStroke();
    rotateX(orbitAngle);
    rotateY(currentAngle);
    translate(v.x, v.y, v.z);
    if (satelites != null) {
      for (int i = 0; i < satelites.length; i++) {
        satelites[i].show();
      }
    }
    popMatrix();
  }
  
}
