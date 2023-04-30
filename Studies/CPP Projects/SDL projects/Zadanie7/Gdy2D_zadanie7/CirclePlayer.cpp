#include "CirclePlayer.h"
#include "RectPlayer.h"
#include <iostream>

	CirclePlayer::CirclePlayer(float x, float y, float r) : Player{ x, y }, r { r }
	{

	}

	CirclePlayer::~CirclePlayer()
	{

	}


	const float CirclePlayer::get_r() const
	{
		return r;
	};


	void CirclePlayer::draw(SDL_Renderer* renderer, SDL_Texture* player)
	{
		//std::cout << "Draw Circle" << std::endl;
		SDL_Rect player_area = { x, y, 2*r, 2*r };

		SDL_RenderCopy(renderer, player, NULL, &player_area);

	};


	void CirclePlayer::move(int screenWidth, int screenHeight, float scale, float& cameraX, float& cameraY, float deltaTime, float smooth, float eps, Player* player)
	{
		RectPlayer* rPlayer = dynamic_cast<RectPlayer*>(player);
		
		if (get_is_vx_very_small(smooth, eps)) vx = 0;
		else vx = vx_check;

		if ((x + vx * deltaTime * 0.5) <= (((screenWidth ) - (screenWidth  / 10) ) / scale /* + (screenWidth / scale / 10 * 2 - (screenWidth / scale / 10 + r / scale * 2))*/)  &&
			(x + vx * deltaTime * 0.5) >= screenWidth / 10)
		{
			x += vx * deltaTime * 0.5;
		}
		else
		{
			if (scale >= 0.3)
			{
				cameraX -= vx * deltaTime * 0.5;
			}
			/*if (player->get_x() - vx * deltaTime * 0.5 >= 0 &&
				player->get_x() - vx * deltaTime * 0.5 <= screenWidth / scale - rPlayer->get_width() / scale)
			{
				player->set_x(player->get_x() - vx * deltaTime * 0.5);
			}*/
		}

		

		if (get_is_vy_very_small(smooth, eps)) vy = 0;
		else vy = vy_check;

		if ((y + vy * deltaTime * 0.5) <= ((screenHeight)-(screenHeight / 10)) / scale &&
			(y + vy * deltaTime * 0.5) >= screenHeight / 10)
		{
			y += vy * deltaTime * 0.5;
		}
		else
		{
			if (scale >= 0.3)
			{
				cameraY -= vy * deltaTime * 0.5;
			}
			/*if (player->get_y() - vy * deltaTime * 0.5 >= 0 &&
				player->get_y() - vy * deltaTime * 0.5 <= screenHeight / scale - rPlayer->get_height() / scale)
			{
				player->set_y(player->get_y() - vy * deltaTime * 0.5);
			}*/
		}

		//std::cout << "Move Circle To: " << x << " , " << y << std::endl;
	};