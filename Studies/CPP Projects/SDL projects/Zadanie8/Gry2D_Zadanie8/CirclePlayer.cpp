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


	std::pair<float,float> CirclePlayer::move(int screenWidth, int screenHeight, float& cameraX, float& cameraY, float cX,  bool& isCameraXLocked, float deltaTime, float smooth, float eps)
	{
		if (get_is_vx_very_small(smooth, eps)) vx = 0;
		else vx = vx_check;

		if ((x + vx * deltaTime * 0.5) <= ((screenWidth ) - (screenWidth  / 10) ) &&
			(x + vx * deltaTime * 0.5) >= screenWidth / 10)
		{
			x += vx * deltaTime * 0.5;
		}
		else
		{
			cameraX -= vx * deltaTime * 0.5;
		}

		if (get_is_vy_very_small(smooth, eps)) vy = 0;
		else vy = vy_check;

		if ((y + vy * deltaTime * 0.5) <= ((screenHeight)-(screenHeight / 10)) &&
			(y + vy * deltaTime * 0.5) >= screenHeight / 10)
		{
			y += vy * deltaTime * 0.5;
		}
		else
		{
			cameraY -= vy * deltaTime * 0.5;
		}

		return std::pair<float, float>(0, 0);

	};