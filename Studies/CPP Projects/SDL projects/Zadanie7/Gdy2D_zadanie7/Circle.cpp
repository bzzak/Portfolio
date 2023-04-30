//#include <iostream>
//#include <string>
//#include "Circle.h"
//
//	Circle::Circle(float given_x, float given_y, float given_r)
//	{
//		this->x = given_x;
//		this->y = given_y;
//		this->r = given_r;
//		this->m = given_r;
//
//		this->vx = (-1 + static_cast <float> (rand()) / (static_cast <float> (RAND_MAX / (1 + 1))));
//		this->vy = (-1 + static_cast <float> (rand()) / (static_cast <float> (RAND_MAX / (1 + 1))));
//	}
//
//	Circle::~Circle()
//	{
//
//	}
//
//	const float Circle::GetX() const
//	{
//		return x;
//	}
//
//	const float Circle::GetY() const
//	{
//		return y;
//	}
//
//	const float Circle::GetR() const
//	{
//		return r;
//	}
//
//	const float Circle::GetVx() const
//	{
//		return this->vx;
//	}
//
//	const float Circle::GetVy() const
//	{
//		return this->vy;
//	}
//
//	const float Circle::GetM() const
//	{
//		return this->m;
//	}
//
//	
//	const std::pair<float, float> Circle::GetCircleMove(float deltaTime)
//	{
//		float speedFactor = 0.2;
//		return { GetVx() * (float)deltaTime * speedFactor , GetVy() * (float)deltaTime * speedFactor };
//	}
//
//
//	void Circle::SetX(float new_x)
//	{
//		this->x = new_x;
//	}
//
//	void Circle::SetY(float new_y)
//	{
//		this->y = new_y;
//	}
//
//	void Circle::SetVx(float new_Vx)
//	{
//		this->vx = new_Vx;
//	}
//
//	void Circle::SetVy(float new_Vy)
//	{
//		this->vy = new_Vy;
//	}
//
//	
