#pragma once

#include "Player.h"
#include <SDL.h>

class CirclePlayer : public Player
{
private:
	float r;
public:
	CirclePlayer(float x, float y, float r);

	~CirclePlayer();

	const float get_r() const;

	void draw(SDL_Renderer* renderer, SDL_Texture* player) override;
	void move(int screenWidth, int screenHeight, float scale, float& cameraX, float& cameraY, float deltaTime, float smooth, float eps, Player* other) override;
	
};
