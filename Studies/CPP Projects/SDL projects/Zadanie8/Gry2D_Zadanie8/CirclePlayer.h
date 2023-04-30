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
	std::pair<float, float> move(int screenWidth, int screenHeight, float& cameraX, float& cameraY, float cX, bool& isCameraXLocked, float deltaTime, float smooth, float eps) override;
	
};
