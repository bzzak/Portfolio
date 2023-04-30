#pragma once

#include "Player.h"
#include <SDL.h>

class RectPlayer : public Player
{
private:
	float width;
	float height;

public:
	RectPlayer(float x, float y, float width, float height);

	~RectPlayer();

	const float get_width() const;
	const float get_height() const;

	void draw(SDL_Renderer* renderer, SDL_Texture* player) override;
	std::pair<float, float> move(int screenWidth, int screenHeight, float& cameraX, float& cameraY, float cX,  bool& isCameraXLocked, float deltaTime, float smooth, float eps) override;
};
