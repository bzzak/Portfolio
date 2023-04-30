int[][] colors = {{255,0,0}, {0,255,0}, {0,0,255}, {255,255,0}, {255,0,255}, {0,255,255}};
ArrayList<int[]> colorsArray = new ArrayList<int[]>();
ArrayList<int[]> colorsRandom = new ArrayList<int[]>();
int counter,iterations;
float w,h, x, y;
float[] xCoords = new float[3], yCoords = new float[3];
float[] xCoordsLine = new float[2], yCoordsLine = new float[2];
final int WINDOW_WIDTH = 800;
final int WINDOW_HEIGHT = 600;
boolean isDataLoaded = false, canContinue = false;
XML data;
XML background;
XML rect;
XML circle;
XML ellipse;
XML triangle;
XML polygon;



public enum Shapes {
  RECT, CIRCLE, ELLIPSE;
}
  
void drawRectOrCircleOrEllipse(Shapes s){
  if(!isDataLoaded){
    w = random(10,100);
    h = random(10,100);
    
    
    
    
    
    
    
    fill(colorsRandom.get(0)[0],colorsRandom.get(0)[1],colorsRandom.get(0)[2]);
    
    
    switch(s){
      case RECT:
      x = random(WINDOW_WIDTH/2);
      y = random(WINDOW_HEIGHT/3);
      if(w + x > WINDOW_WIDTH/2) x = WINDOW_WIDTH/2 - w;
      if(h + y > WINDOW_HEIGHT/3) y = WINDOW_HEIGHT/3 - h;
      rect.setFloat("x", x);
      rect.setFloat("y", y);
      rect.setFloat("w",w);
      rect.setFloat("h",h);
      rect.setInt("r", colorsRandom.get(0)[0]);
      rect.setInt("g", colorsRandom.get(0)[1]);
      rect.setInt("b", colorsRandom.get(0)[2]);
      rect(x,y,w,h);
      colorsRandom.remove(0);
      break;
      case CIRCLE:
      x = random(WINDOW_WIDTH/2, WINDOW_WIDTH);
      y = random(WINDOW_HEIGHT/3);
      if(w + x > WINDOW_WIDTH) x = WINDOW_WIDTH - w;
      if(h + y > WINDOW_HEIGHT/3) y = WINDOW_HEIGHT/3 - h;
      circle.setFloat("x", x);
      circle.setFloat("y", y);
      circle.setFloat("radius", w/2);
      circle.setInt("r", colorsRandom.get(0)[0]);
      circle.setInt("g", colorsRandom.get(0)[1]);
      circle.setInt("b", colorsRandom.get(0)[2]);
      circle(x,y,w/2);
      colorsRandom.remove(0);
      break;
      case ELLIPSE:
      x = random(WINDOW_WIDTH/2);
      y = random(2*WINDOW_HEIGHT/3, WINDOW_HEIGHT);
      if(w + x > WINDOW_WIDTH/2) x = WINDOW_WIDTH/2 - w;
      if(h + y > WINDOW_HEIGHT) y = WINDOW_HEIGHT - h;
      ellipse.setFloat("x", x);
      ellipse.setFloat("y", y);
      ellipse.setFloat("radiusA", w/2);
      ellipse.setFloat("radiusB", h/2);
      ellipse.setInt("r", colorsRandom.get(0)[0]);
      ellipse.setInt("g", colorsRandom.get(0)[1]);
      ellipse.setInt("b", colorsRandom.get(0)[2]);
      ellipse(x,y,w/2,h/2);
      colorsRandom.remove(0);
      break;
      default:
      break;
    }
  }else{
    
    w = rect.getFloat("w");
    h = rect.getFloat("h");
    
    
    
    
    switch(s){
      case RECT:
      fill(rect.getInt("r"),rect.getInt("g"),rect.getInt("b"));
      x = rect.getFloat("x");
      y = rect.getFloat("y");
      rect(x,y,w,h);
      break;
      case CIRCLE:
      fill(circle.getInt("r"),circle.getInt("g"),circle.getInt("b"));
      x = circle.getFloat("x");
      y = circle.getFloat("y");
      circle(x,y,circle.getFloat("radius"));
      break;
      case ELLIPSE:
      fill(ellipse.getInt("r"),ellipse.getInt("g"),ellipse.getInt("b"));
      x = ellipse.getFloat("x");
      y = ellipse.getFloat("y");
      ellipse(x,y,ellipse.getFloat("radiusA"),ellipse.getFloat("radiusB"));
      break;
      default:
      break;
    }
    
    
    
  }
}

void drawTriangle(){
  if(!isDataLoaded){
    for(int i = 0; i < 3; i++) {
      xCoords[i] = random(WINDOW_WIDTH/2, WINDOW_WIDTH);
      yCoords[i] = random(2*WINDOW_HEIGHT/3, WINDOW_HEIGHT);
    }
    triangle.setFloat("x1", xCoords[0]);
    triangle.setFloat("x2", xCoords[1]);
    triangle.setFloat("x3", xCoords[2]);
    
    triangle.setFloat("y1", yCoords[0]);
    triangle.setFloat("y2", yCoords[1]);
    triangle.setFloat("y3", yCoords[2]);
    
    fill(colorsRandom.get(0)[0],colorsRandom.get(0)[1],colorsRandom.get(0)[2]);
    triangle.setInt("r", colorsRandom.get(0)[0]);
    triangle.setInt("g", colorsRandom.get(0)[1]);
    triangle.setInt("b", colorsRandom.get(0)[2]);
    colorsRandom.remove(0);
    
    
    triangle(xCoords[0], yCoords[0], xCoords[1], yCoords[1], xCoords[2], yCoords[2]);
  }else {
   xCoords[0] = triangle.getFloat("x1");
   xCoords[1] = triangle.getFloat("x2");
   xCoords[2] = triangle.getFloat("x3");
   yCoords[0] = triangle.getFloat("y1");
   yCoords[1] = triangle.getFloat("y2");
   yCoords[2] = triangle.getFloat("y3");
    
    
    fill(triangle.getInt("r"),triangle.getInt("g"),triangle.getInt("b"));
    triangle(xCoords[0], yCoords[0], xCoords[1], yCoords[1], xCoords[2], yCoords[2]);
  }
}

void drawPolygon(int nodes) {
  if(!isDataLoaded){
    if(nodes > 1) {
      for(int i = 0; i < 2; i++) {
        xCoordsLine[i] = random(WINDOW_WIDTH);
        yCoordsLine[i] = random(WINDOW_HEIGHT/3, 2*WINDOW_HEIGHT/3);   
      }
      XML line = polygon.addChild("line");
      line.setFloat("x1", xCoordsLine[0]);
      line.setFloat("x2", xCoordsLine[1]);
      line.setFloat("y1", yCoordsLine[0]);
      line.setFloat("y2", yCoordsLine[1]);
      
      polygon.setInt("r", colorsRandom.get(0)[0]);
      polygon.setInt("g", colorsRandom.get(0)[1]);
      polygon.setInt("b", colorsRandom.get(0)[2]);
      
      stroke(colorsRandom.get(0)[0],colorsRandom.get(0)[1],colorsRandom.get(0)[2]);
      colorsRandom.remove(0);
      
      for(int i = 0; i < nodes - 1; i++){
        line(xCoordsLine[0], yCoordsLine[0], xCoordsLine[1], yCoordsLine[1] );
        xCoordsLine[0] = xCoordsLine[1];
        yCoordsLine[0] = yCoordsLine[1];
        xCoordsLine[1] = random(WINDOW_WIDTH);
        yCoordsLine[1] = random(WINDOW_HEIGHT/3, 2*WINDOW_HEIGHT/3);
        
        line = polygon.addChild("line");
        line.setFloat("x1", xCoordsLine[0]);
        line.setFloat("x2", xCoordsLine[1]);
        line.setFloat("y1", yCoordsLine[0]);
        line.setFloat("y2", yCoordsLine[1]);
      }
    } else {
      println("Number of nodes sholud be at least 2 to draw a polygon!");
    }
  } else {
      XML[] lines = polygon.getChildren();
      
      stroke(polygon.getInt("r"),polygon.getInt("g"),polygon.getInt("b"));
      
      for(int i = 0; i < lines.length - 2; i++){
        line(lines[i].getFloat("x1"), lines[i].getFloat("y1"), lines[i].getFloat("x2"), lines[i].getFloat("y2") );
      } 
  }
}

  
void settings() {
  size(WINDOW_WIDTH,WINDOW_HEIGHT);
}

void setup(){
  selectInput("Select a xml file to load data:", "loadData");
  while(!canContinue){
    delay(1);
  }
  
  background = data.getChild("background");
  rect = data.getChild("rect");
  circle = data.getChild("circle");
  ellipse = data.getChild("ellipse");
  triangle = data.getChild("triangle");
  polygon = data.getChild("polygon");
  
  if(!isDataLoaded){
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
  }
  
  noLoop();
}

void loadData(File selection){
  if(selection != null){
    data = loadXML(selection.getAbsolutePath());
    if(data != null) isDataLoaded = true;
  } else {
    data = loadXML("./data/template.xml");
    //wyjatek jesli nie istnieje
  }
  canContinue = true;
  
}

void draw() {
  
  if(!isDataLoaded){
    background.setInt("r",colorsRandom.get(0)[0]);
    background.setInt("g",colorsRandom.get(0)[1]);
    background.setInt("b",colorsRandom.get(0)[2]);
    background(colorsRandom.get(0)[0],colorsRandom.get(0)[1],colorsRandom.get(0)[2]);
    colorsRandom.remove(0);
  }else {
    background(background.getInt("r"),background.getInt("g"),background.getInt("b"));
  }
  
  drawRectOrCircleOrEllipse(Shapes.RECT);
  drawRectOrCircleOrEllipse(Shapes.CIRCLE);
  drawRectOrCircleOrEllipse(Shapes.ELLIPSE);
  drawTriangle();
  drawPolygon(4);
  
  if(!isDataLoaded) saveXML(data,"./data/LastState.xml");
  
}
