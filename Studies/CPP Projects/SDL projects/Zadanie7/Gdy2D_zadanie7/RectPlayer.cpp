#include "RectPlayer.h"
#include "CirclePlayer.h"
#include <iostream>


	RectPlayer::RectPlayer(float x, float y, float width, float height) : Player{ x, y }, width { width }, height { height }
	{

	}

	RectPlayer::~RectPlayer()
	{

	}



	const float RectPlayer::get_width() const
	{
		return width;
	};


	const float RectPlayer::get_height() const
	{
		return height;
	};




	void RectPlayer::draw(SDL_Renderer* renderer, SDL_Texture* player)
	{
		//std::cout << "Draw Rect" << std::endl;
		SDL_Rect player_area = { x, y, width, height };

		SDL_RenderCopy(renderer, player, NULL, &player_area);
	
	};


	void RectPlayer::move(int screenWidth, int screenHeight, float scale, float& cameraX, float& cameraY , float deltaTime, float smooth, float eps, Player* player)
	{
		CirclePlayer* cPlayer = dynamic_cast<CirclePlayer*>(player);

		if (get_is_vx_very_small(smooth, eps)) vx = 0;
		else vx = vx_check;

		if ((x + vx * deltaTime * 0.5) <= ((screenWidth)-(screenWidth / 10)) / scale &&
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
				player->get_x() - vx * deltaTime * 0.5 <= screenWidth / scale - 2 * cPlayer->get_r() / scale)
			{
				player->set_x(player->get_x() - vx * deltaTime * 0.5);
			}*/
		}



		if (get_is_vy_very_small(smooth, eps)) vy = 0;
		else vy = vy_check;

		if ((y + vy * deltaTime * 0.5) <= ((screenHeight)-(screenHeight / 10)) / scale &&
			(y + vy * deltaTime * 0.5) >= 0 + screenHeight / 10 / scale)
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
				player->get_y() - vy * deltaTime * 0.5 <= screenHeight / scale - 2 * cPlayer->get_r() / scale)
			{
				player->set_y(player->get_y() - vy * deltaTime * 0.5);
			}*/
		}

		//std::cout << "Move Rect To: " << x << " , " << y << std::endl;
	};