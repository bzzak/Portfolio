#include "CircleCollisionEngine.h"

CircleCollisionEngine::CircleCollisionEngine(int sw, int sh) 
{
	this->SCREEN_WIDTH = sw;
	this->SCREEN_HEIGHT = sh;
}

CircleCollisionEngine::~CircleCollisionEngine()
{

}






void CircleCollisionEngine::MoveAll(float deltaTime)
{
	for (int i = 0; i < circles.size(); i++)
	{
		circles.at(i).SetX(circles.at(i).GetX() + circles.at(i).GetCircleMove(deltaTime).first);
		circles.at(i).SetY(circles.at(i).GetY() + circles.at(i).GetCircleMove(deltaTime).second);

		if (circles.at(i).GetX() < circles.at(i).GetR())
		{
			circles.at(i).SetX(circles.at(i).GetR());
		}
		else if (circles.at(i).GetX() > SCREEN_WIDTH - circles.at(i).GetR())
		{
			circles.at(i).SetX(SCREEN_WIDTH - circles.at(i).GetR());
		}

		if (circles.at(i).GetY() < circles.at(i).GetR())
		{
			circles.at(i).SetY(circles.at(i).GetR());
		}
		else if (circles.at(i).GetY() > SCREEN_WIDTH - circles.at(i).GetR())
		{
			circles.at(i).SetY(SCREEN_WIDTH - circles.at(i).GetR());
		}
	}
}


void CircleCollisionEngine::BounceFromTheEdges(float deltaTime)
{
	for (int i = 0; i < circles.size(); i++)
	{
		float newVx = circles.at(i).GetCircleMove(deltaTime).first;
		float newVy = circles.at(i).GetCircleMove(deltaTime).second;
		if (circles.at(i).GetX() + newVx > SCREEN_WIDTH - circles.at(i).GetR() )
		{
			circles.at(i).SetVx(-fabs(circles.at(i).GetVx()));
		}
		if (circles.at(i).GetX() + newVx < circles.at(i).GetR())
		{
			circles.at(i).SetVx(fabs(circles.at(i).GetVx()));
		}

		if (circles.at(i).GetY() + newVy > SCREEN_HEIGHT - circles.at(i).GetR() )	
		{		
			circles.at(i).SetVy(-fabs(circles.at(i).GetVy()));
		}
		if (circles.at(i).GetY() + newVy < circles.at(i).GetR())
		{
			circles.at(i).SetVy(fabs(circles.at(i).GetVy()));
		}
	}
}

void CircleCollisionEngine::Physics(float deltaTime, bool isSeparated, bool isBouncing)
{
	std::vector<std::vector<std::vector<float>>> normals;
	for (int i = 0; i < circles.size(); i++)
	{
		for (int j = 0; j < circles.size(); j++)
		{
			
			if (j != i)
			{
				float left = pow(circles.at(j).GetX() - circles.at(i).GetX(), 2);
				float right = pow(circles.at(j).GetY() - circles.at(i).GetY(), 2);

				if (left + right < pow(circles.at(i).GetR() + circles.at(j).GetR(), 2))
				{
					float distance = sqrtf(left + right);
					float newVx, newVy;

					float overlap = 0.5 * (distance - circles.at(j).GetR() - circles.at(i).GetR());

					newVx = overlap * (circles.at(j).GetX() - circles.at(i).GetX()) / distance;

					newVy = overlap * (circles.at(j).GetY() - circles.at(i).GetY()) / distance;

					

					if (isSeparated)
					{
						circles.at(j).SetX(circles.at(j).GetX() - newVx);
						circles.at(j).SetY(circles.at(j).GetY() - newVy);

						circles.at(i).SetX(circles.at(i).GetX() + newVx);
						circles.at(i).SetY(circles.at(i).GetY() + newVy);
					}

					if (isBouncing)
					{
						float defaultMass = 5;
						float speedValue1 = sqrtf(powf(circles.at(j).GetVx() , 2) + powf(circles.at(j).GetVy(), 2));
						float speedValue2 = sqrtf(powf(circles.at(i).GetVx(), 2) + powf(circles.at(i).GetVy(), 2));
						// Normal
						float nx = (circles.at(j).GetX() - circles.at(i).GetX()) / distance;
						float ny = (circles.at(j).GetY() - circles.at(i).GetY()) / distance;

						// Tangent
						float tx = -ny;
						float ty = nx;

						// Dot Product Tangent
						float dpTan1 = circles.at(j).GetVx() * tx + circles.at(j).GetVy() * ty;
						float dpTan2 = circles.at(i).GetVx() * tx + circles.at(i).GetVy() * ty;

						// Dot Product Normal
						float dpNorm1 = circles.at(j).GetVx() * nx + circles.at(j).GetVy() * ny;
						float dpNorm2 = circles.at(i).GetVx() * nx + circles.at(i).GetVy() * ny;

						float m1 = ( 2.0f * defaultMass * dpNorm2) / ( 2 * defaultMass);
						float m2 = ( 2.0f * defaultMass * dpNorm1) / (2 * defaultMass);

						float finalDistance1 = sqrt((tx * dpTan1 + nx * m1) * (tx * dpTan1 + nx * m1) + (ty * dpTan1 + ny * m1) * (ty * dpTan1 + ny * m1));
						float finalDistance2 = sqrt((tx * dpTan2 + nx * m2) * (tx * dpTan2 + nx * m2) + (ty * dpTan2 + ny * m2) * (ty * dpTan2 + ny * m2));

						float normFinalX1 = (tx * dpTan1 + nx * m1) / finalDistance1;
						float normFinalY1 = (ty * dpTan1 + ny * m1) / finalDistance1;
						float normFinalX2 = (tx * dpTan2 + nx * m2) / finalDistance2;
						float normFinalY2 = (ty * dpTan2 + ny * m2) / finalDistance2;

						circles.at(j).SetVx(normFinalX1 * speedValue1);
						circles.at(j).SetVy(normFinalY1 * speedValue1);
						circles.at(i).SetVx(normFinalX2 * speedValue2);
						circles.at(i).SetVy(normFinalY2 * speedValue2);


						/*circles.at(j).SetVx(-circles.at(j).GetVx() + 2 * (circles.at(j).GetVx() * newVx + circles.at(j).GetVy() * newVy) * newVx);
						circles.at(j).SetVy(-circles.at(j).GetVy() + 2 * (circles.at(j).GetVx() * newVx + circles.at(j).GetVy() * newVy) * newVy);

						circles.at(i).SetVx(circles.at(i).GetVx() - 2 * (circles.at(i).GetVx() * newVx + circles.at(i).GetVy() * newVy) * newVx);
						circles.at(i).SetVy(circles.at(i).GetVy() - 2 * (circles.at(i).GetVx() * newVx + circles.at(i).GetVy() * newVy) * newVy);*/
					}

				}
			}
		}
	}
}





