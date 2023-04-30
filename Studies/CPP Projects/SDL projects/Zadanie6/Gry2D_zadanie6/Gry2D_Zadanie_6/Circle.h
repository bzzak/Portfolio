#pragma once
#include <iostream>
#include <string>

class Circle
{
private:
	float x, y, r;
	float vx, vy;
	float m;

public:

	Circle(float given_x, float given_y, float given_r);

	~Circle();

	const float GetX() const;
	const float GetY() const;
	const float GetR() const;
	const float GetVx() const;
	const float GetVy() const;
	const float GetM() const;

	void SetX(float new_x);
	void SetY(float new_y);
	void SetVx(float new_Vx);
	void SetVy(float new_Vy);

	const std::pair<float, float> GetCircleMove(float deltaTime);

};
