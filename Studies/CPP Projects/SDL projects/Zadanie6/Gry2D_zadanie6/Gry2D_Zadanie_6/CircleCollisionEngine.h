#pragma once
#include <vector>
#include <functional>
#include "Circle.h"

class CircleCollisionEngine
{
private:
	 int SCREEN_WIDTH;
	 int SCREEN_HEIGHT;
public:
	std::vector<Circle> circles;

	CircleCollisionEngine(int sw, int sh);
	~CircleCollisionEngine();

	void MoveAll(float deltaTime);

	void BounceFromTheEdges(float deltaTime);

	void Physics(float deltaTime, bool isSeparated, bool isBouncing);

};

