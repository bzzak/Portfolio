ArrayList <String> paths = new ArrayList<String>();
ArrayList <Card> cardSet = new ArrayList<Card>();
ArrayList <Card> visibleCards = new ArrayList<Card>();
ArrayList <Card> activeCards;
int[] cardCounter = {0, 0, 0, 0, 0};
String strawberyPath;
String plumPath;
String applePath;
String bananaPath;
String pearPath;
boolean canContinue = false;



void setup(){
  size(1000,800);
   
  strawberyPath = "svg/truskawka.svg";
  plumPath = "svg/sliwka.svg";
  applePath = "svg/jablko.svg";
  bananaPath = "svg/banan.svg";
  pearPath = "svg/gruszka.svg";
  
  paths.add(strawberyPath);
  paths.add(plumPath);
  paths.add(applePath);
  paths.add(bananaPath);
  paths.add(pearPath);
  
  int random ;
  
  for(int i = 0; i < 9; i++) {
    
    do{    
      random = int(random(0,5));
      cardCounter[random] += 1;
      if(cardCounter[random] <= 2) cardSet.add(new Card(150, 250, paths.get(random)));
    }while (cardCounter[random] > 2); 
    
    cardSet.get(i).setX(55 + 355 * (i % 3));
    cardSet.get(i).setY(15 + 260 * int(i * 0.34)); 
    
  
  }
    
  activeCards = new ArrayList<Card>(cardSet);
  
  
}

void draw() {
  background(193, 255, 145);
  
  if(activeCards.size() > 1){
  for(int i = 0; i < 9; i++) { 
    cardSet.get(i).draw();
  }
  
  
  
  if(visibleCards.size() == 2){
    
    
    if(canContinue){
      delay(1000);
      if(visibleCards.get(0).getPath() == visibleCards.get(1).getPath()){
        activeCards.remove(visibleCards.get(0));
        activeCards.remove(visibleCards.get(1));
        visibleCards.get(0).disable();
        visibleCards.get(1).disable(); 
      } else {
        visibleCards.get(0).hide();
        visibleCards.get(1).hide();
      }
      
      visibleCards.clear();
    }
    canContinue = true;
    
  }
  
  if(visibleCards.size() == 0) canContinue = false;
  
  } else {
     String message = ""; 
     Card lastCard = activeCards.get(0); 
     lastCard.setWidth(250);
     lastCard.setHeight(350);
     lastCard.setX(width / 2 - 130);
     lastCard.setY(height / 2 - 220);
     lastCard.reveal();
     lastCard.draw();
     
     switch(lastCard.getPath()){
     case "svg/truskawka.svg":
       message = "Truskawki są bardzo soczyste!";
       break;
     case "svg/sliwka.svg":
       message = "Ze śliwek zrobisz wspaniałe ciasto!";
       break;
     case "svg/jablko.svg":
       message = "Jabłka jest bardzo zdrowe dla człowieka!";
       break;
     case "svg/banan.svg":
       message = "Banany zawierają dużo potasu!";
       break;
     case "svg/gruszka.svg":
       message = "Gruszki są bardzo słodkie!";
       break;
     
     }
     
     textAlign(CENTER);
     textSize(44);
     fill(0);
     text(message,width/2,height - 150);
  }
  
}
