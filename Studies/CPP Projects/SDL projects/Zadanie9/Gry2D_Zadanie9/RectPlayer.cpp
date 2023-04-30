#include "RectPlayer.h"
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


	std::pair<float,float> RectPlayer::move(int screenWidth, int screenHeight, float& cameraX, float& cameraY , float cX,  bool& isCameraXLocked, float deltaTime, float smooth, float eps)
	{
		float oldCameraX = cameraX;
		float oldCameraY = cameraY;

		if (get_is_vx_very_small(smooth, eps)) vx = 0;
		else vx = vx_check;


		/*if ((((x + vx * deltaTime * 0.5) <= screenWidth / 2 - width / 2) && (x + vx * deltaTime * 0.5) >= 0) || (((x + vx * deltaTime * 0.5) >= screenWidth / 2 - width / 2) && cameraX <= screenWidth / 10 * 22)) x += vx * deltaTime * 0.5;
		else cameraX -= vx * deltaTime * 0.5;*/

		if ((cameraX  >= 0) && (x + vx * deltaTime * 0.5 < screenWidth / 2 - width / 2))
		{
			cameraX = 0;
			x += vx * deltaTime * 0.5;
		}
		else if ((cameraX <=  - screenWidth / 10 * 50) && (x + vx * deltaTime * 0.5 > screenWidth / 2 - width / 2))
		{
			cameraX = - screenWidth / 10 * 50;
			x += vx * deltaTime * 0.5;
		}
		else if((x + vx * deltaTime * 0.5 >= screenWidth - 2 * screenWidth / 10) || (x + vx * deltaTime * 0.5 <= screenWidth / 10)) cameraX -= vx * deltaTime * 0.5;
		else x += vx * deltaTime * 0.5;
		
		

		//y += vy;

		/*if (get_is_vy_very_small(smooth, eps)) vy = 0;
		else vy = vy_check;*/

		if ((cameraY <= 0) && (y + vy> screenHeight / 2 - height / 2))
		{
			cameraY = 0;
			y += vy;
		}
		else if ((cameraY >= screenHeight / 10 * 5) && (y + vy  < screenHeight / 2 - height / 2))
		{
			cameraY = screenHeight / 10 * 5;
			y += vy;
		}
		else if((y + vy >= screenHeight - 2 * screenHeight / 10) || (y + vy <= screenHeight / 10)) cameraY -= vy * deltaTime * 0.5;
		else y += vy;

		return std::pair<float, float>( oldCameraX,  oldCameraY);
	};