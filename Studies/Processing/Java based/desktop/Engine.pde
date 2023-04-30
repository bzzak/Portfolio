class Engine {
  
  public  boolean Collisions(ArrayList<RectCollider> colliders, Player player1, Player player2, Ball ball)
  {
    boolean isSomeoneGainedPoint = false;
  
    //PLAYER 1 COLLISIONS

    for (int i = 0; i < colliders.size(); i++) 
    {
      RectCollider collider = colliders.get(i);
      
      //Check collision beetwen  head of player1 and rect obstacles
     
      PVector move1 = circleVSrectCollision(player1.headCollider, collider);

      if(!collider.isTrigger) player1.moveByVector(move1);
      
      //Check collision beetwen  shoe of player1 and rect obstacles
      
      PVector move2 = rectVSrectCollision(player1.shoeCollider, collider);
      
      if(!collider.isTrigger) player1.moveByVector(move2);
    }

    //Check collision beetwen head of player1  and football
      PVector moveBall1 = circleVScircleCollision(player1.headCollider, ball.collider);
      PVector moveBall1a = new PVector(- moveBall1.x / 2, - moveBall1.y / 2);
      PVector moveBall1b = new PVector( moveBall1.x / 2, moveBall1.y / 2);
      
      player1.moveByVector(moveBall1b);
      ball.moveByVector(moveBall1a);

    //Check collision beetwen shoe of player1  and football
      PVector moveBall2 = circleVSrectCollision(ball.collider, player1.shoeCollider);
      PVector moveBall2a = new PVector(- moveBall2.x / 2, - moveBall2.y / 2);
      PVector moveBall2b = new PVector( moveBall2.x / 2, moveBall2.y / 2);
      
      player1.moveByVector(moveBall2a);
      ball.moveByVector(moveBall2b);


    //PLAYER 2 COLLISIONS


    for (int i = 0; i < colliders.size(); i++) 
    {
      RectCollider collider = colliders.get(i);
      
      //Check collision beetwen  head of player2 and rect obstacles

      PVector move1 = circleVSrectCollision(player2.headCollider, collider);

      if(!collider.isTrigger) player2.moveByVector(move1);

      //Check collision beetwen  shoe of player2 and rect obstacles
      
      PVector move2 = rectVSrectCollision(player2.shoeCollider, collider);
      
      if(!collider.isTrigger) player2.moveByVector(move2);
    }
  
    //Check collision beetwen head of player2  and football
      PVector moveBall3 = circleVScircleCollision(player2.headCollider, ball.collider);
      PVector moveBall3a = new PVector(- moveBall3.x / 2, - moveBall3.y / 2);
      PVector moveBall3b = new PVector( moveBall3.x / 2, moveBall3.y / 2);
      
      player2.moveByVector(moveBall3b);
      ball.moveByVector(moveBall3a);

    //Check collision beetwen shoe of player2  and football
      PVector moveBall4 = circleVSrectCollision(ball.collider, player2.shoeCollider);
      PVector moveBall4a = new PVector(- moveBall4.x / 2, - moveBall4.y / 2);
      PVector moveBall4b = new PVector( moveBall4.x / 2, moveBall4.y / 2);
      
      player2.moveByVector(moveBall4a);
      ball.moveByVector(moveBall4b);
      
    //Ball VS Obstacles Collisions
      for (int i = 0; i < colliders.size(); i++) 
      {
        RectCollider collider = colliders.get(i);
        
        //Check collision beetwen  ball and rect obstacles
       
        PVector move = circleVSrectCollision(ball.collider, collider);
  
        if(!collider.isTrigger) ball.moveByVector(move);
        else if(collider.triggerType == TriggerType.BALLRESPAWN && (move.x != 0 || move.y != 0))
        {
          ball.respawn();
        }
        else if(collider.triggerType == TriggerType.POINTP1 && (move.x != 0 || move.y != 0))
        {
          player1Score++;
          isSomeoneGainedPoint = true;
          if(player1Score == win) endScreen = true;
        }
        else if(collider.triggerType == TriggerType.POINTP2 && (move.x != 0 || move.y != 0))
        {
          player2Score++;
          isSomeoneGainedPoint = true;
          if(player2Score == win) endScreen = true;
        }
        
      }

    //PLAYER 1 VS PLAYER 2 Collisions

    //Check collision beetwen head of player1 and head of player 2

      PVector move1 = circleVScircleCollision(player1.headCollider, player2.headCollider);
      PVector move1a = new PVector(- move1.x / 2, - move1.y / 2);
      PVector move1b = new PVector(move1.x / 2, move1.y / 2);

      player1.moveByVector(move1b);
      player2.moveByVector(move1a);

    //Check collision beetwen head of player1 and shoe of player 2

      PVector move2 = circleVSrectCollision(player1.headCollider, player2.shoeCollider);
      PVector move2a = new PVector(- move2.x / 2, - move2.y / 2);
      PVector move2b = new PVector(move2.x / 2, move2.y / 2);

      player1.moveByVector(move2b);
      player2.moveByVector(move2a);


    //Check collision beetwen shoe of player1 and head of player 2

      PVector move3 = circleVSrectCollision(player2.headCollider, player1.shoeCollider);
      PVector move3a = new PVector(- move3.x / 2, - move3.y / 2);
      PVector move3b = new PVector(move3.x / 2, move3.y / 2);

      player1.moveByVector(move3a);
      player2.moveByVector(move3b);


    //Check collision beetwen shoe of player1 and shoe of player 2
    
      PVector move4 = rectVSrectCollision(player1.shoeCollider, player2.shoeCollider);
      PVector move4a = new PVector(- move4.x / 2, - move4.y / 2);
      PVector move4b = new PVector(move4.x / 2, move4.y / 2);

      player1.moveByVector(move4b);
      player2.moveByVector(move4a);

    return isSomeoneGainedPoint;
  }
  
  
  private  PVector circleVSrectCollision(CircleCollider cCol, RectCollider rCol)
  {
      float newVx = 0, newVy = 0;
      float l, r, t, b;
      float nearest_x, nearest_y;
      float left, right, top, bottom;
    
      l = rCol.x;
      r = rCol.x + rCol.w;
      t = rCol.y;
      b = rCol.y + rCol.h;

      if (cCol.x < l) nearest_x = l;
      else if (l < cCol.x && cCol.x < r) nearest_x = cCol.x;
      else nearest_x = r;


      if (cCol.y < t) nearest_y = t;
      else if (t < cCol.y && cCol.y < b) nearest_y = cCol.y;
      else nearest_y = b;
    
      float distance = sqrt(pow(nearest_x - cCol.x, 2) + pow(nearest_y - cCol.y, 2));

      if (distance < cCol.d / 2)
      {
        //print("Distance: ", distance, "\n");
        //print("Radius  : ", cCol.d / 2, "\n");
        // Eventually separate circle from rect
    
        if (nearest_x == cCol.x && nearest_y == cCol.y)
        {
          //print("Rect Separation mode!\n");
          // Separate like two rects
        
          left = cCol.x - l + cCol.d / 2;
          right = r - cCol.x + cCol.d / 2;
          top = cCol.y - t + cCol.d / 2;
          bottom = b - cCol.y + cCol.d / 2;

          if(left < right) newVx = -left;
          else newVx = right;
          if(top < bottom) newVy = -top;
          else newVy = bottom;
          
          if (abs(newVx) < abs(newVy)) newVy = 0;
          else if (abs(newVx) > abs(newVy)) newVx = 0;
        }
        else
        {
          //print("Circle Separation mode!\n");
          // Separate like two circles
        
          newVx = (cCol.x - nearest_x) / distance * (cCol.d / 2 - distance);
          newVy = (cCol.y - nearest_y) / distance * (cCol.d / 2 - distance);
        }
        //print("Circle vs Rect Detected: ", newVx, "  ", newVy, "\n");
      }

    return new PVector(newVx, newVy);
  }
  
  
  private  PVector rectVSrectCollision(RectCollider rCol1, RectCollider rCol2)
  {
      float newVx = 0, newVy = 0;
      float l, r, t, b;
      float left, right, top, bottom;
      
      l = rCol2.x;
      r = rCol2.x + rCol2.w;
      t = rCol2.y;
      b = rCol2.y + rCol2.h;
      
      
      left = (rCol1.x + rCol1.w) - l;
      right = r - rCol1.x;
      top = (rCol1.y + rCol1.h) - t;
      bottom = b - rCol1.y;
    
      if ( left > 0 &&  right > 0 && top > 0 &&  bottom > 0)
      {
        
        //eventually separate rect 1 from rect 2
        if(left < right) newVx = -left;
        else newVx = right;
        if(top < bottom) newVy = -top;
        else newVy = bottom;
        
        if(abs(newVx) < abs(newVy)) newVy = 0;
        else if ( abs(newVx) > abs(newVy)) newVx = 0;
  
        //if (newVyP2 == 0) printf("TOUCH DETECTED: vx changed\n");
        //else printf("TOUCH DETECTED: vy changed\n");
        //print("Rect vs Rect Detected: ", newVx, "  ", newVy, "\n");
      }
      
    return new PVector(newVx, newVy);
  }
  
  private  PVector circleVScircleCollision(CircleCollider cCol1, CircleCollider cCol2)
  {
        float newVx = 0, newVy = 0;
        float left = pow(cCol2.x - cCol1.x, 2);
        float right = pow(cCol2.y - cCol1.y, 2);

        if (left + right < pow(cCol1.d / 2 + cCol2.d / 2, 2))
        {
          float distance = sqrt(left + right);
          float overlap = (distance - cCol2.d / 2 - cCol1.d / 2);

          newVx = overlap * (cCol2.x - cCol1.x) / distance;
          newVy = overlap * (cCol2.y - cCol1.y) / distance;
          
          //print("Circle vs Circle Detected: ", newVx, "  ", newVy, "\n");
        }
        
    return new PVector(newVx, newVy);
  }
}
