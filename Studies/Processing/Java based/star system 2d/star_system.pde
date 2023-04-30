
PImage bg;
float time = 0.f;

void setup(){
  size(1800,1000,P3D);
  bg = loadImage("img/galaxy_1800_1000.jpg");
}

void drawCircle(int steps)
{
  beginShape();
  for (int i = 0; i < steps; ++i)
    vertex(cos(TWO_PI * (float)i / float(steps)), sin(TWO_PI * (float)i / float(steps)));
  endShape();
}

void drawRotateCelestialBody(int size, int bcgColor, float anchorDist, float anchorAngle, float dist, float angle, float anchorRotSpeed, float rotSpeed, float selfRotSpeed){
  pushMatrix();
    rotate(anchorRotSpeed * time);
    translate(anchorDist * cos(TWO_PI * anchorAngle), anchorDist * sin(TWO_PI * anchorAngle));
    rotate(rotSpeed * time);
    translate(dist * cos(TWO_PI * angle), dist * sin(TWO_PI * angle));
    rotate(selfRotSpeed * time);
    scale(size);
    fill(bcgColor);
    drawCircle(36);
  popMatrix();
}

void drawOrbit(int size, int orbitColor, int thickness, float anchorDist, float anchorAngle, float anchorRotSpeed){
  pushMatrix();
    rotate(anchorRotSpeed * time);
    translate(anchorDist * cos(TWO_PI * anchorAngle), anchorDist * sin(TWO_PI * anchorAngle));
    stroke(orbitColor);
    strokeWeight(thickness);
    noFill();
    ellipse(0,0,size,size);
    noStroke();
  popMatrix();
}

void drawStar(int size, int bcgColor, float selfRotSpeed){
  pushMatrix();
    rotate(selfRotSpeed);
    scale(size);
    fill(bcgColor);
    drawCircle(36);
  popMatrix();
}

void draw() {
  background(bg);
  translate(width *.5f, height *.5f);
  noStroke();
  
  drawOrbit(350, #ff0000, 2, 0, 0, 0);
  drawOrbit(600, #ff0000, 2, 0, 0, 0);
  drawOrbit(900, #ff0000, 2, 0, 0, 0);
  drawOrbit(1405, #ff0000, 2, 0, 0, 0);
  drawOrbit(1800, #ff0000, 2, 0, 0, 0);
  
  drawOrbit(110, #d1a3a8, 1, 300, .2f, 7);
  drawOrbit(102, #d1a3a8, 1, 450, .7f, 4);
  drawOrbit(140, #d1a3a8, 1, 450, .7f, 4);
  drawOrbit(214, #d1a3a8, 1, 700, .9f, 3);
  drawOrbit(233, #d1a3a8, 1, 700, .9f, 3);
  drawOrbit(250, #d1a3a8, 1, 700, .9f, 3);
  drawOrbit(270, #d1a3a8, 1, 700, .9f, 3);
  
  drawStar(100,#fcdc0a,time);
  
  
  drawRotateCelestialBody(10, #bf593f, 0, 0, 175, .5f, 0, -10, 4);
  drawRotateCelestialBody(20, #50ccc8, 0, 0, 300, .2f, 0, 7, 6);
  drawRotateCelestialBody(23, #696732, 0, 0, 450, .7f, 0, 4, 5);
  drawRotateCelestialBody(48, #1bc416, 0, 0, 700, .9f, 0, 3, 3);
  drawRotateCelestialBody(21, #1d3e85, 0, 0, 900, .1f, 0, 2, 3);
  
  drawRotateCelestialBody(7, #0a7d4b, 300, .2f, 55, .2f, 7, 25, 6);
  
  drawRotateCelestialBody(5, #86c91a, 450, .7f, 50, .3f, 4, 30, 5);
  drawRotateCelestialBody(6, #b9f558, 450, .7f, 70, .6f, 4, 10, 5);
  
  drawRotateCelestialBody(6, #abdbb3, 700, .9f, 135, .3f, 3, 15, 3);
  drawRotateCelestialBody(4, #498509, 700, .9f, 125, .1f, 3, 17, 3);
  drawRotateCelestialBody(5, #9447e6, 700, .9f, 117, .8f, 3, 20, 3);
  drawRotateCelestialBody(3, #b00c1d, 700, .9f, 107, .5f, 3, 23, 3);
  
  
  time += .001f;
}
