public void mousePressed()
{
  if(menuChoice == 0)
  {
    if(groups.isClicked(mouseX, mouseY)) clickedMenuButton = 1;
    else if(matches.isClicked(mouseX, mouseY)) clickedMenuButton = 2;
    else if(ladder.isClicked(mouseX, mouseY)) clickedMenuButton = 3;
  }
  
  if(back.isClicked(mouseX, mouseY)) clickedMenuButton = 4;
  
}

public void mouseReleased()
{
  switch(clickedMenuButton)
  {
    case 1:
      if(groups.isClicked(mouseX, mouseY)) menuChoice = groups.getMenuOption();
      groups.setHighLight(false);
      clickedMenuButton = 0;
      break;
    case 2:
      if(matches.isClicked(mouseX, mouseY)) menuChoice = matches.getMenuOption();
      matches.setHighLight(false);
      clickedMenuButton = 0;
      break;
    case 3:
      if(ladder.isClicked(mouseX, mouseY)) menuChoice = ladder.getMenuOption();
      ladder.setHighLight(false);
      clickedMenuButton = 0;
      break;
    case 4:
      if(back.isClicked(mouseX, mouseY)) menuChoice = back.getMenuOption();
      back.setHighLight(false);
      clickedMenuButton = 0;
      break;
  }
}

public void mouseDragged()
{
  if(menuChoice == 1)
  {
    groupScroll += mouseY - pmouseY;
    if(groupScroll >= 0) groupScroll = 0;
    else if(groupScroll <= - 0.45 * height) groupScroll = - 0.45 * height;
  }

}
