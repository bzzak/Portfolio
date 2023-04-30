#pragma once
#include <vector>
#include <functional>
#include <SDL.h>
#include "CirclePlayer.h"
#include "RectPlayer.h"

static class Engine
{
public:

	static bool Collisions(std::vector<SDL_Rect> colliders, RectPlayer* player, std::pair<float,float> cameraOffset, float& cameraX, float& cameraY, float deltaTime);

};

