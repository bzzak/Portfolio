PFont fontA, fontB;
int fontSize = 68;
int[][] colors = {{255,0,0}, {0,255,0}, {0,0,255}, {255,255,0}, {255,0,255}, {0,255,255}};
ArrayList<int[]> colorsArray = new ArrayList<int[]>();
ArrayList<int[]> colorsRandom = new ArrayList<int[]>();
int counter,iterations;
float w,h, x, y;
float[] xCoords = new float[3], yCoords = new float[3];
float[] xCoordsLine = new float[2], yCoordsLine = new float[2];
final int WINDOW_WIDTH = 800;
final int WINDOW_HEIGHT = 600;

public enum Shapes {
  RECT, CIRCLE, ELLIPSE;
}
  
void drawRectOrCircleOrEllipse(Shapes s){
  w = random(10,100);
  h = random(10,100);
  
  
  fill(colorsRandom.get(0)[0],colorsRandom.get(0)[1],colorsRandom.get(0)[2]);
  colorsRandom.remove(0);
  
  switch(s){
    case RECT:
    x = random(WINDOW_WIDTH/2);
    y = random(WINDOW_HEIGHT/3);
    if(w + x > WINDOW_WIDTH/2) x = WINDOW_WIDTH/2 - w;
    if(h + y > WINDOW_HEIGHT/3) y = WINDOW_HEIGHT/3 - h;
    rect(x,y,w,h);
    break;
    case CIRCLE:
    x = random(WINDOW_WIDTH/2, WINDOW_WIDTH);
    y = random(WINDOW_HEIGHT/3);
    if(w + x > WINDOW_WIDTH) x = WINDOW_WIDTH - w;
    if(h + y > WINDOW_HEIGHT/3) y = WINDOW_HEIGHT/3 - h;
    circle(x,y,w/2);
    break;
    case ELLIPSE:
    x = random(WINDOW_WIDTH/2);
    y = random(2*WINDOW_HEIGHT/3, WINDOW_HEIGHT);
    if(w + x > WINDOW_WIDTH/2) x = WINDOW_WIDTH/2 - w;
    if(h + y > WINDOW_HEIGHT) y = WINDOW_HEIGHT - h;
    ellipse(x,y,w/2,h/2);
    break;
    default:
    break;
  }
}

void drawTriangle(){
  for(int i = 0; i < 3; i++) {
    xCoords[i] = random(WINDOW_WIDTH/2, WINDOW_WIDTH);
    yCoords[i] = random(2*WINDOW_HEIGHT/3, WINDOW_HEIGHT);
  }
  
  fill(colorsRandom.get(0)[0],colorsRandom.get(0)[1],colorsRandom.get(0)[2]);
  colorsRandom.remove(0);
  triangle(xCoords[0], yCoords[0], xCoords[1], yCoords[1], xCoords[2], yCoords[2]);
}

void drawPolygon(int nodes) {
  if(nodes > 1) {
    for(int i = 0; i < 2; i++) {
      xCoordsLine[i] = random(WINDOW_WIDTH);
      yCoordsLine[i] = random(WINDOW_HEIGHT/3, 2*WINDOW_HEIGHT/3);
    }
    
    stroke(colorsRandom.get(0)[0],colorsRandom.get(0)[1],colorsRandom.get(0)[2]);
    colorsRandom.remove(0);
    
    for(int i = 0; i < nodes - 1; i++){
      line(xCoordsLine[0], yCoordsLine[0], xCoordsLine[1], yCoordsLine[1] );
      xCoordsLine[1] = xCoordsLine[0];
      yCoordsLine[1] = yCoordsLine[0];
      xCoordsLine[0] = random(WINDOW_WIDTH);
      yCoordsLine[0] = random(WINDOW_HEIGHT/3, 2*WINDOW_HEIGHT/3);
    }
  } else {
    println("Number of nodes sholud be at least 2 to draw a polygon!");
  }

}

void makeLogo(){
  fill(0,0,0);
  textFont(fontA);
  textAlign(CENTER);
  text("Bartosz",WINDOW_WIDTH/2,WINDOW_HEIGHT/2);
  
  textFont(fontB);
  text("Zak", WINDOW_WIDTH/2,WINDOW_HEIGHT/2+fontSize);
}
  
void settings() {
  size(WINDOW_WIDTH,WINDOW_HEIGHT);
}

void setup(){
  for(int[] singleColor : colors){
    colorsArray.add(singleColor);
  }
  counter = colorsArray.size();
  iterations = counter;
  for(int i = 0; i < iterations; i++){
    int[] temp = colorsArray.get(int(random(counter)));
    colorsArray.remove(temp);
    colorsRandom.add(temp);
    counter--;
  }
  
  fontA = createFont("Fasthand-Regular.ttf", fontSize);
  fontB = createFont("Anton-Regular.ttf", fontSize);
  
  noLoop();
}

void draw() {
  background(colorsRandom.get(0)[0],colorsRandom.get(0)[1],colorsRandom.get(0)[2]);
  colorsRandom.remove(0);
  
  drawRectOrCircleOrEllipse(Shapes.RECT);
  drawRectOrCircleOrEllipse(Shapes.CIRCLE);
  drawRectOrCircleOrEllipse(Shapes.ELLIPSE);
  drawTriangle();
  drawPolygon(4);
  makeLogo();
  
}
