void keyPressed()
{
  if(!(refreshScreen || endScreen))
  {
    if(key != CODED)
    {
      switch(key)
      {
        case 'A':
        case 'a':
          player2.set_vx_target(-1);
          break;
        case 'D':
        case 'd':
          player2.set_vx_target(1);
          break;
        case 'W':
        case 'w':
          player2.set_vy_target(-1);
          break;
        case 'S':
        case 's':
          player2.set_vy_target(1);
          break;   
      }
    }
    else
    {
      switch(keyCode)
      {
        case LEFT:
          player1.set_vx_target(-1);
          break;
        case RIGHT:
          player1.set_vx_target(1);
          break;
        case UP:
          player1.set_vy_target(-1);
          break;
        case DOWN:
          player1.set_vy_target(1);
          break;   
      }
    }
  }
}

void keyReleased()
{
  if(!(refreshScreen || endScreen))
  {
    if(key != CODED)
    {
      switch(key)
      {
        case 'A':
        case 'a':
          if(player2.get_vx() < 0) player2.set_vx_target(0);
          break;
        case 'D':
        case 'd':
          if(player2.get_vx() > 0) player2.set_vx_target(0);
          break;
        case 'W':
        case 'w':
          if(player2.get_vy() < 0) player2.set_vy_target(0);
          break;
        case 'S':
        case 's':
          if(player2.get_vy() > 0) player2.set_vy_target(0);
          break;   
      }
    }
    else
    {
      switch(keyCode)
      {
        case LEFT:
          if(player1.get_vx() < 0) player1.set_vx_target(0);
          break;
        case RIGHT:
          if(player1.get_vx() > 0) player1.set_vx_target(0);
          break;
        case UP:
          if(player1.get_vy() < 0) player1.set_vy_target(0);
          break;
        case DOWN:
          if(player1.get_vy() > 0) player1.set_vy_target(0);
          break;   
      }
    }
  }
}
