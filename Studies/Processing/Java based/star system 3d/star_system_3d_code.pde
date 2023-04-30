//import peasy.*;

//PeasyCam cam;

// Images
PImage galaxy;
PImage starTexture;
PImage make;
PImage earth;
PImage moonTexture;
PImage mars;
PImage eris;
PImage ceres;
PImage haumea;

// Shapes
SpaceShip ship;
PShape planetoid;
PShape lineX;
PShape lineY;
PShape lineZ;
PShape starShape;
PShape rock1Shape;
PShape rock2Shape;
PShape gasShape;
PShape outerShape;
PShape rock2Moon1Shape;
PShape rock2Moon2Shape;
PShape gasMoon1Shape;
PShape gasMoon2Shape;
PShape gasMoon3Shape;
PShape gasMoon4Shape;
PShape trueEarthShape;
PShape moonShape;

// Celestials Bodies
CelestialBody star;
CelestialBody rock1;
CelestialBody rock2;
CelestialBody gas;
CelestialBody outer;
CelestialBody rock2Moon1;
CelestialBody rock2Moon2;
CelestialBody gasMoon1;
CelestialBody gasMoon2;
CelestialBody gasMoon3;
CelestialBody gasMoon4;
CelestialBody trueEarth;
CelestialBody moon;

void setup(){
  
  fullScreen(P3D);
  //cam = new PeasyCam(this, 5000);
  //frustum(0,0,0,0,40,500);
  
  ship = new SpaceShip(1000, "obj/Intergalactic_Spaceships_Version_2.obj", .01 , 10.5);
  
  // Load Textures and Objects
  galaxy = loadImage("img/backgrounds/galaxy2.jpg");
  starTexture = loadImage("img/textures/sun.jpg");
  earth = loadImage("img/textures/earth.jpg");
  planetoid = loadShape("obj/10464_Asteroid_v1_Iterations-2.obj");
  make = loadImage("img/textures/make.jpg");
  moonTexture = loadImage("img/textures/moon.jpg");
  mars = loadImage("img/textures/mars.jpg");
  eris = loadImage("img/textures/eris.jpg");
  ceres = loadImage("img/textures/ceres.jpg");
  haumea = loadImage("img/textures/haumea.jpg");
  
  // Set axes guide lines
  lineX = createShape(LINE, 0, 0, 0, 10000, 0, 0);
  lineX.setFill(color(255,0,0));
  lineX.setStroke(color(255,0,0));
  lineY = createShape(LINE, 0, 0, 0, 0, 10000, 0);
  lineY.setFill(color(255,0,0));
  lineY.setStroke(color(255,0,0));
  lineZ = createShape(LINE, 0, 0, 0, 0, 0, 10000);
  lineZ.setFill(color(255,0,0));
  lineZ.setStroke(color(255,0,0));
  noStroke();
  
  // Set Shapes
  starShape = createShape(SPHERE, 400);
  starShape.setTexture(starTexture);
  rock1Shape = createShape(SPHERE, 40);
  rock1Shape.setTexture(make);
  trueEarthShape = createShape(BOX, 75, 75, 75);
  trueEarthShape.setTexture(earth);
  moonShape = createShape(SPHERE, 50);
  moonShape.setTexture(moonTexture);
  rock2Shape = createShape(SPHERE, 80);
  rock2Shape.setTexture(mars);
  gasMoon1Shape = createShape(SPHERE, 25);
  gasMoon1Shape.setFill(color(224, 9, 13));
  gasMoon2Shape = createShape(SPHERE, 42);
  gasMoon2Shape.setTexture(ceres);
  gasMoon3Shape = createShape(SPHERE, 49);
  gasMoon3Shape.setTexture(eris);
  gasMoon4Shape = createShape(SPHERE, 20);
  gasMoon4Shape.setTexture(haumea);
  gasShape = createShape(SPHERE, 240);
  gasShape.setFill(color(33, 194, 44));
  outerShape = createShape(SPHERE, 120);
  outerShape.setFill(color(7, 71, 140));
  
  // set Celestial Body Objects
  rock1 = new CelestialBody(rock1Shape, 1, 900, .8, .003, .007, false, true);
  moon = new CelestialBody(moonShape, 200, .08, .002, .005);
  CelestialBody[] trueEarthSatelites = {moon};
  trueEarth = new CelestialBody(trueEarthShape, 1500, .1, .002, .005, true, false, trueEarthSatelites);
  rock2Moon1 = new CelestialBody(planetoid, .1, 350, .2, .004, .007);
  rock2Moon2 = new CelestialBody(planetoid, .05, 450, -.4, .002, .004);
  CelestialBody[] rock2Moons = {rock2Moon1, rock2Moon2};
  rock2 = new CelestialBody(rock2Shape, 2400, .15, .006, .003, rock2Moons);
  gasMoon1 = new CelestialBody(gasMoon1Shape, 340, .01, .008, .004);
  gasMoon2 = new CelestialBody(gasMoon2Shape, 420, .1, .004, .007);
  gasMoon3 = new CelestialBody(gasMoon3Shape, 610, -.3, .003, .005);
  gasMoon4 = new CelestialBody(gasMoon4Shape, 730, .32, .002, .003);
  CelestialBody[] gasMoons = {gasMoon1, gasMoon2, gasMoon3, gasMoon4};
  gas = new CelestialBody(gasShape, 6000, .21, .003, .001, gasMoons);
  outer = new CelestialBody(outerShape, 8000, .15, .005, .002);
  CelestialBody[] starSatelites = {rock1, trueEarth, rock2, gas, outer};
  star = new CelestialBody(starShape, 0, 0, 0, 0.005, starSatelites);//, earthSatelites);
  
  
}

void draw(){
  background(galaxy);
  //pointLight(255,255,255,-500,0,500);
  //lights();
  shininess(50);//size of specular (bigger value -> greater specular)
  specular(255, 0, 0);
  
  
// Draw guides
  //shape(lineX);
  //shape(lineY);
  //shape(lineZ);
  //shininess(25);//size of specular (bigger value -> greater specular)
  lightFalloff(1,0,0);
  
  // Main Initialization
  star.show();       //  Show all Objects
  star.orbit();      //  Make all objects orbit
  star.selfRotate(); //  Make all objects rotate
  ship.display();
}

void keyPressed() {
  /*##### SHIP #####*/
  if (keyCode == 'W') {
    ship.pressKey('W');
  } else if (keyCode == 'S') {
    ship.pressKey('S');
  } else if (keyCode == 'A') {
    ship.pressKey('A');
  } else if (keyCode == 'D') {
    ship.pressKey('D');
  } else if (keyCode == 'Q') {
    ship.pressKey('Q');
  } else if (keyCode == 'E') {
    ship.pressKey('E');
  } else if(keyCode == ' '){
    ship.pressKey(' ');
  } else if(key == CODED && keyCode == SHIFT){
    ship.pressKey('M');
  } //else if(keyCode == 'C'){
  //} else if(keyCode == 'V'){
  //} else if(keyCode == 'J'){ 
  //}
}

void keyReleased() {
  if (keyCode == 'W') {
    ship.releaseKey('W');
  } else if (keyCode == 'S') {
    ship.releaseKey('S');
  } else if (keyCode == 'A') {
    ship.releaseKey('A');
  } else if (keyCode == 'D') {
    ship.releaseKey('D');
  } else if (keyCode == 'Q') {
    ship.releaseKey('Q');
  } else if (keyCode == 'E') {
    ship.releaseKey('E');
  } else if (keyCode == ' ') {
    ship.releaseKey(' ');
  } else if(key == CODED && keyCode == SHIFT){
    ship.releaseKey('M');
  }
}
