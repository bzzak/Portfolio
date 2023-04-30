
final int WINDOW_WIDTH = 750;
final int WINDOW_HEIGHT = 1000;

int secondsCounter = 0;
int actualS,actualM,actualH;
int waverDirection = -1;
float waverSpeed = 0;
float waverAngle = 20;
float waverLighteness = 0;


void drawClock(){
  
  stroke(0,0,0);
  strokeWeight(12);
  fill(0,0,0,100);
  rect(WINDOW_WIDTH/4,WINDOW_HEIGHT/8,WINDOW_WIDTH/2,3*WINDOW_HEIGHT/4);
  
  strokeWeight(4);
  fill(0,0,100);
  circle(WINDOW_WIDTH/2, WINDOW_HEIGHT/3, WINDOW_WIDTH/3);
  
  strokeWeight(16);
  point(WINDOW_WIDTH/2, WINDOW_HEIGHT/3);
  
  
  strokeWeight(7);
  pushMatrix();
  translate(WINDOW_WIDTH/2, WINDOW_HEIGHT/3);
  
  for(int i = 0; i < 12; i++){
    line(0,WINDOW_WIDTH/9 - 10*WINDOW_WIDTH/41,0,WINDOW_WIDTH/9 - WINDOW_WIDTH/4);
    rotate(radians(360/12));
  }
  
  strokeWeight(5);
  for(int i = 0; i < 60; i++){
    if(i%5 != 0){
    point(0,WINDOW_WIDTH/9 - 100*WINDOW_WIDTH/407);
    }
    rotate(radians(6));
  }
  popMatrix();
  
  pushMatrix();
  strokeWeight(8);
  translate(WINDOW_WIDTH/2, WINDOW_HEIGHT/3);
  if(actualS%720 == 0 && actualS != 0 && actualS != 360 && secondsCounter%30 == 1){
    actualH += 1;
    rotate(radians(actualH));
    //println(actualH);
  }else {
    rotate(radians(actualH));
  }
  line(0,0,0,-WINDOW_HEIGHT/30);
  popMatrix();
  
  pushMatrix();
  strokeWeight(6);
  translate(WINDOW_WIDTH/2, WINDOW_HEIGHT/3);
  if(actualS%360 == 0 && actualS != 0 && secondsCounter%30 == 1){
    actualM += 6;
    rotate(radians(actualM));
    //println(actualS);
  }else {
    rotate(radians(actualM));
  }
  line(0,0,0,-WINDOW_HEIGHT/16);
  popMatrix();
  
  pushMatrix();
  strokeWeight(4);
  translate(WINDOW_WIDTH/2, WINDOW_HEIGHT/3);
  if(secondsCounter%30 == 0){
    actualS += 6;
    rotate(radians(actualS));
    //println(actualS);
  }else {
    rotate(radians(actualS));
  }
  line(0,0,0,-WINDOW_HEIGHT/11);
  popMatrix();
  
}

void drawClockWavered(){
  if(waverAngle > 0 && waverDirection == -1) waverSpeed += 0.02;
  else if(waverAngle < 0 && waverDirection == -1) waverSpeed -= 0.02;
  else if(waverAngle > 0 && waverDirection == 1) waverSpeed -= 0.02;
  else if(waverAngle < 0 && waverDirection == 1) waverSpeed += 0.02;
  if(waverSpeed <= 0) waverDirection *= -1;
  waverAngle += waverDirection * waverSpeed; 
  waverLighteness = 100 - abs(waverAngle)*100/20.0;
  stroke(0,0,0);
  strokeWeight(10);
  pushMatrix();
  translate(WINDOW_WIDTH/2, WINDOW_HEIGHT/3);
  rotate(radians(waverAngle));
  line(0,0,0,360);
  strokeWeight(8);
  fill(0,100,waverLighteness);
  circle(0,360,90);
  popMatrix();
  
}


void settings(){
  size(WINDOW_WIDTH, WINDOW_HEIGHT);
}


void setup() {
  
  colorMode(HSB, 360, 100, 100);
  frameRate(30);
  
  float temp = 30*hour()+minute()/2;
  
  actualS = second()*6;
  actualM = minute()*6;
  actualH = int(temp);
  
  if(temp%2 != 0) actualS += 360;
  
  noStroke();
  noFill();
}

void draw() {
  background(0,0,100);
  drawClockWavered();
  drawClock();
  secondsCounter++;
}  
