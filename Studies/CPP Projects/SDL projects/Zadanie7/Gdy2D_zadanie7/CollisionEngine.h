#pragma once
#include <vector>
#include <functional>
#include "Circle.h"
#include <SDL.h>
#include "CirclePlayer.h"
#include "RectPlayer.h"

static class CollisionEngine
{
public:

	static bool Physics(std::vector<SDL_Rect> colliders, CirclePlayer* player1, RectPlayer* player2, int& player1Points, int& player2Points, bool& player1Wins, bool& player2Wins, float deltaTime);

};

