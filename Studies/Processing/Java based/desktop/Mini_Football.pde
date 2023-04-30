ArrayList<RectCollider> colliders = new ArrayList<RectCollider>();


int SCREEN_WIDTH = 1400;
int SCREEN_HEIGHT = 900;

final int fontSize = 100;
float radius = 50;
PFont pixelFont;

PImage playground;
PImage crowd;
PShape goal;

Engine engine;
Player player1, player2;
Ball ball;

String playgroundPath, crowdPath, goalPath, head1Path, head2Path, shoeBluePath, shoeRedPath, ballPath;

int win = 1;
int player1Score = 0, player2Score = 0;

boolean endScreen = false, refreshScreen = false, isAfterDisplay = false;


void setup()
{
  size(1400,900); //<>//
   
  
  playgroundPath = "textures/playground.png";
  crowdPath = "textures/crowd.jpg";
  goalPath = "svg/goal.svg";
  head1Path = "svg/head1.svg";
  head2Path = "svg/head2.svg";
  shoeBluePath = "svg/shoeBlue.svg";
  shoeRedPath = "svg/shoeRed.svg";
  ballPath = "svg/football.svg";
  
  playground = loadImage(playgroundPath);
  crowd = loadImage(crowdPath);
  goal = loadShape(goalPath);
  
  pixelFont = createFont( "FreePixel.ttf", fontSize);
  
  engine = new Engine();
  
  player1 = new Player(SCREEN_WIDTH / 2 + 110, 575, 150, 150, head1Path, shoeBluePath, false);
  
  player2 = new Player(SCREEN_WIDTH / 2 - 110, 575, 150, 150, head2Path, shoeRedPath, true);
  
  ball = new Ball(ballPath, SCREEN_WIDTH / 2 - radius , SCREEN_HEIGHT / 2 - radius, radius);
  
  colliders.add(new RectCollider(0, 0.8 * SCREEN_HEIGHT, SCREEN_WIDTH, 0.2 * SCREEN_HEIGHT, TriggerType.BALLRESPAWN));
  colliders.add(new RectCollider(0, -13, SCREEN_WIDTH, 13, TriggerType.BALLRESPAWN));
  colliders.add(new RectCollider(-13, 0, 13, 0.585 * SCREEN_HEIGHT, TriggerType.BALLRESPAWN));
  colliders.add(new RectCollider(SCREEN_WIDTH, 0, 10, 0.585 * SCREEN_HEIGHT, TriggerType.BALLRESPAWN));
  
  colliders.add(new RectCollider(13, 0.43 * SCREEN_HEIGHT, 150, 325, TriggerType.POINTP1));
  colliders.add(new RectCollider(0.883 * SCREEN_WIDTH, 0.43 * SCREEN_HEIGHT, 150, 325, TriggerType.POINTP2));
  
  colliders.add(new RectCollider(0, 0.8 * SCREEN_HEIGHT, SCREEN_WIDTH, 0.2 * SCREEN_HEIGHT, TriggerType.NONE));
  colliders.add(new RectCollider(0, 0.415 * SCREEN_HEIGHT, 13, 0.385 * SCREEN_HEIGHT, TriggerType.NONE));
  colliders.add(new RectCollider(-13, 0, 13, 0.585 * SCREEN_HEIGHT, TriggerType.NONE));
  colliders.add(new RectCollider(0, 0.415 * SCREEN_HEIGHT, 208, 13, TriggerType.NONE));
  colliders.add(new RectCollider(0, -13, SCREEN_WIDTH, 13, TriggerType.NONE));
  colliders.add(new RectCollider(SCREEN_WIDTH, 0, 10, 0.585 * SCREEN_HEIGHT, TriggerType.NONE));
  colliders.add(new RectCollider(SCREEN_WIDTH - 208, 0.415 * SCREEN_HEIGHT, 208, 13, TriggerType.NONE));
  colliders.add(new RectCollider(SCREEN_WIDTH - 13, 0.415 * SCREEN_HEIGHT, 13, 0.385 * SCREEN_HEIGHT, TriggerType.NONE));
  
  
  //colliders.add(new CircleCollider(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2, 10, false));
  
}


void draw() 
{
  if(refreshScreen)
  {
    if(isAfterDisplay)
    {
      refreshScreen = false;
      isAfterDisplay = false;
      ball.respawn();
      player1.respawn();
      player2.respawn();
      delay(1000);
      return;
    }
    
    player1.set_vx(0);
    player1.set_vy(0);
    player1.set_vx_target(0);
    player1.set_vy_target(0);
    
    player2.set_vx(0);
    player2.set_vy(0);
    player2.set_vx_target(0);
    player2.set_vy_target(0);
         
    drawScene();
    player1.draw();
    player2.draw();
    ball.draw();
    drawGoals();
    
    isAfterDisplay = true;
  }
  else if(endScreen)
  {
    if(isAfterDisplay)
    {
      endScreen = false;
      isAfterDisplay = false;
      delay(5000);
      return;
    }
    
    if(player1Score == win)
    {
      player1Score = 0;
      player2Score = 0;
      drawEndScreen("PLAYER 1 WON THE GAME!", player1);
      player1.resizeToFirstSize();
      player1.respawn();
    }
    else if(player2Score == win)
    {
      player1Score = 0;
      player2Score = 0;
      drawEndScreen("PLAYER 2 WON THE GAME!", player2);
      player2.flip();
      player2.resizeToFirstSize();
      player2.respawn();
    }
    
    isAfterDisplay = true;
  }
  else
  {
    drawScene();
  
    player1.move(0.001, 0.95);
    player2.move(0.001, 0.95);
    
    if(engine.Collisions(colliders, player1, player2, ball)) refreshScreen = true;
    
    player1.draw();
    player2.draw();
    ball.draw();
    drawGoals();
  }
            
}


void drawScene() 
{
  background(125, 255, 12);
  image(crowd, 0, 0, SCREEN_WIDTH, 0.8 * SCREEN_HEIGHT);
  image(playground, 0, 0.8 * SCREEN_HEIGHT, SCREEN_WIDTH, 0.2 * SCREEN_HEIGHT);
  drawScore();
  
  //for(Collider c : colliders){
  //  c.show();
  //}
  
}

void drawEndScreen(String winMessage, Player player)
{
  if(player.get_is_shoe_fliped()) player.flip();
  background(125, 255, 12);
  image(crowd, 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
  pushMatrix();
  fill(0,0,0);
  textFont(pixelFont);
  textSize(85);
  textAlign(CENTER);
  text(winMessage,SCREEN_WIDTH/2,85);
  player.set_w(250);
  player.set_h(250);
  player.set_x(SCREEN_WIDTH / 2 - player.get_w() / 2);
  player.set_y(SCREEN_HEIGHT / 2 - player.get_h() / 2);
  player.draw();
  popMatrix();
}

void drawGoals()
{
  shape(goal, 0, 0.8 * SCREEN_HEIGHT - 350, 210, 350);
  pushMatrix();
  translate(SCREEN_WIDTH , 0.8 * SCREEN_HEIGHT - 350);
  scale(-1,1);
  shape(goal, 0,0, 210, 350);
  popMatrix();
}

void drawScore()
{
  fill(0,0,0);
  textFont(pixelFont);
  textAlign(CENTER);
  String score = player2Score + " : " + player1Score; 
  text(score,SCREEN_WIDTH/2,75);
}
