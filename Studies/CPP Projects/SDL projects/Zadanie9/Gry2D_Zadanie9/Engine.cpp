#include "Engine.h"
#include "RectPlayer.h"


bool Engine::Collisions(std::vector<SDL_Rect> colliders, RectPlayer* player, std::pair<float, float> cameraOffset, float& cameraX, float& cameraY, float deltaTime)
{
	float newVxP, newVyP;
	float left, right, top, bottom;

	for (int i = 0; i < colliders.size(); i++) {

		//check collision beetwen  rect player and rect obstacles
		left = (player->get_x() + player->get_width()) - colliders[i].x;
		right = (colliders[i].x + colliders[i].w) - player->get_x();
		top = (player->get_y() + player->get_height()) - colliders[i].y;
		bottom = (colliders[i].y + colliders[i].h) - player->get_y();
		

		if ( left > 0 &&  right > 0 && top > 0 &&  bottom > 0)
		{
			
			//eventually separate rect player1 from overlaped obstacle
			left < right ? newVxP = -left : newVxP = right;
			top < bottom ? newVyP = -top : newVyP = bottom;

			if(abs(newVxP) < abs(newVyP)) newVyP = 0;
			else if ( abs(newVxP) > abs(newVyP)) newVxP = 0;

			//if (newVyP2 == 0) printf("TOUCH DETECTED: vx changed\n");
			//else printf("TOUCH DETECTED: vy changed\n");

			player->set_x(player->get_x() + newVxP);
			player->set_y(player->get_y() + newVyP);

			if(cameraOffset.first < 0) cameraX = cameraOffset.first;
			else if(cameraOffset.first > 0) cameraX = cameraOffset.first;
			if (cameraOffset.second > 0) cameraY = cameraOffset.second;
			else if (cameraOffset.second < 0) cameraY = cameraOffset.second;

			if (newVyP == -top) {
				return true;
			}
		}
	}

	return false;

}





