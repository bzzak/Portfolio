PImage mundialBackground, trophy;
PImage netherlands, senegal, equador, quatar, england, usa, iran, wales, argentina, poland, mexico, saudi_arabia; 
//france, australia, tunisia, denmark, japan, spain, germany, costa_rica, maroco, croatia, belgium, canada, brazil, switzerland, camerun, serbia, portugal, south_corea, uruguay, ghana;
PImage[] flags;
PFont font;


Group a, b, c;

MenuButton groups, matches, ladder, back;
float menuButtonWidth, menuButtonHeight;
float menuButtonsFontSize;

int menuChoice, clickedMenuButton;
float groupScroll = 0;

public void settings()
{
  size(450,850);
}

public void setup()
{
  mundialBackground = loadImage("katar_background.jpeg");
  mundialBackground.resize(width, height);
  
  trophy = loadImage("trophy.png");
  
  netherlands = loadImage("netherlands.png");
  senegal = loadImage("senegal.png");
  equador = loadImage("equador.png");
  quatar = loadImage("quatar.png");
  
  england = loadImage("england.png");
  usa = loadImage("usa.png");
  iran = loadImage("iran.png");
  wales = loadImage("wales.png");
  
  argentina = loadImage("argentina.png");
  poland = loadImage("poland.png");
  mexico = loadImage("mexico.png");
  saudi_arabia = loadImage("saudi_arabia.png");
  
  //france = loadImage("img/flags/france.png");
  //australia = loadImage("img/flags/australia.png");
  //tunisia = loadImage("img/flags/tunisia.png");
  //denmark = loadImage("img/flags/denmark.png");
  
  //japan = loadImage("img/flags/japan.png");
  //spain = loadImage("img/flags/spain.png");
  //germany = loadImage("img/flags/germany.png");
  //costa_rica = loadImage("img/flags/costa_rica.png");
  
  //maroco = loadImage("img/flags/maroco.png");
  //croatia = loadImage("img/flags/croatia.png");
  //belgium = loadImage("img/flags/belgium.png");
  //canada = loadImage("img/flags/canada.png");
  
  //brazil = loadImage("img/flags/brazil.png");
  //switzerland = loadImage("img/flags/switzerland.png");
  //camerun = loadImage("img/flags/camerun.png");
  //serbia = loadImage("img/flags/serbia.png");
  
  //portugal = loadImage("img/flags/portugal.png");
  //south_corea = loadImage("img/flags/south_corea.png");
  //uruguay = loadImage("img/flags/uruguay.png");
  //ghana = loadImage("img/flags/ghana.png");
  
  flags = new PImage[] {netherlands, senegal, equador, quatar, england, usa, iran, wales, argentina, poland, mexico, saudi_arabia}; 
  //france, australia, tunisia, denmark, japan, spain, germany, costa_rica, maroco, croatia, belgium, canada, brazil, switzerland, camerun, serbia, portugal, south_corea, uruguay, ghana};
  
  font = createFont("SimpleMelody.ttf", 30);
  
  menuButtonWidth = 0.6 * width;
  menuButtonHeight = 0.2 * height;
  menuButtonsFontSize = 30;
  
  menuChoice = 0;
  clickedMenuButton = 0;
  
  
  
  back = new MenuButton(0.02 * width, 0.02 * width, 0.1 * width, 0.1 * width, font, 10, "X", 0);
  groups = new MenuButton(width / 2 - menuButtonWidth / 2, 0.1 * height, menuButtonWidth, menuButtonHeight, font, menuButtonsFontSize, "Grupy", 1);
  matches = new MenuButton(width / 2 - menuButtonWidth / 2, 0.5 * height - menuButtonHeight / 2, menuButtonWidth, menuButtonHeight, font, menuButtonsFontSize, "Mecze", 2);
  ladder = new MenuButton(width / 2 - menuButtonWidth / 2, 0.7 * height, menuButtonWidth, menuButtonHeight, font, menuButtonsFontSize, "Drabinka", 3);
  a = new Group(0.1 * width, 0.1 * height, font, "Grupa A", new String[][]{{"Holandia", "0", "3", "2" , "1", "0", "4", "7"}, {"Senegal", "1", "3", "2" , "1", "0", "1", "6"}, {"Ekwador", "2", "3", "1" , "1", "1", "1", "4"}, {"Katar", "3", "3", "0" , "0", "3", "-6", "0"} });
  b = new Group(0.1 * width, 0.55 * height, font, "Grupa B", new String[][]{{"Anglia", "4", "3", "2" , "1", "0", "4", "7"}, {"USA", "5", "3", "2" , "1", "0", "1", "6"}, {"Iran", "6", "3", "1" , "1", "1", "1", "4"}, {"Walia", "7", "3", "0" , "0", "3", "-6", "0"} });
  c = new Group(0.1 * width, height, font, "Grupa C", new String[][]{{"Argentyna", "8", "3", "2" , "1", "0", "4", "7"}, {"Polska", "9", "3", "2" , "1", "0", "1", "6"}, {"Meksyk", "10", "3", "1" , "1", "1", "1", "4"}, {"Arabia Saud.", "11", "3", "0" , "0", "3", "-6", "0"} });
  
}

public void draw()
{
  background(mundialBackground);
  switch(menuChoice)
  {
    case 0:
      
      showMainMenu();
      break;
    case 1:
      showGroupView();
      back.draw();
      break;
    case 2:
      
      back.draw();
      break;
    case 3:
      showLedderView();
      back.draw();
      break;
  
  }
  
}

public void showMainMenu()
{
  groups.draw();
  matches.draw();
  ladder.draw();
}

public void showGroupView()
{
  a.draw();
  b.draw();
  c.draw();
}

public void showLedderView()
{
  image(trophy, 0.7 * width / 2, 0.2 * height / 2, 0.3 * width, 0.4* height);
  image(flags[8], width / 2 - 0.1 * width , height / 2 + 0.1 * height, 0.2 * width, 0.2 * width);
  textFont(font);
  textSize(0.07 * width);
  textAlign(CENTER, CENTER);
  fill(220);
  text("Argentyna Mistrzem Swiata 2022!", width / 2 , height / 2 + 0.3 * height );
  
}
