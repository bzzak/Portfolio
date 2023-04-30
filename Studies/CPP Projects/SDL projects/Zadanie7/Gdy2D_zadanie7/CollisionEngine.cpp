#include "CollisionEngine.h"
#include "CirclePlayer.h"
#include "RectPlayer.h"


bool CollisionEngine::Physics(std::vector<SDL_Rect> colliders, CirclePlayer* player1, RectPlayer* player2, int& player1Points, int& player2Points, bool& player1Wins, bool& player2Wins, float deltaTime)
{
	float newVxP1, newVyP1, newVxP2, newVyP2;
	float c_x = player1->get_x() + player1->get_r();;
	float c_y = player1->get_y() + player1->get_r();
	float l, r, t, b;
	float nearest_x, nearest_y;
	float left, right, top, bottom;

	for (int i = 0; i < colliders.size(); i++) {

		//check collision beetwen  circle player1 and rect obstacles
		l = colliders[i].x;
		r = colliders[i].x + colliders[i].w;
		t = colliders[i].y;
		b = colliders[i].y + colliders[i].h;

		if (c_x < l) nearest_x = l;
		else if (l < c_x && c_x < r) nearest_x = c_x;
		else nearest_x = r;


		if (c_y < t) nearest_y = t;
		else if (t < c_y && c_y < b) nearest_y = c_y;
		else nearest_y = b;
		
		float distance = sqrt(pow(nearest_x - c_x, 2) + pow(nearest_y - c_y, 2));

		if (distance < player1->get_r())
		{
			if (i == colliders.size() - 1)
			{
				player1Points++;
				player1Wins = true;
				player2Wins = false;
				return true;
			}
			//eventually separate circle player1 from overlaped obstacle
			if (nearest_x == c_x && nearest_y == c_y)
			{
				//separate like two rects
				left = c_x - l + player1->get_r();
				right = r - c_x + player1->get_r();
				top = c_y - t + player1->get_r();
				bottom = b - c_y + player1->get_r();

				left < right ? newVxP1 = -left : newVxP1 = right;
				top < bottom ? newVyP1 = -top : newVyP1 = bottom;

				if (abs(newVxP1) < abs(newVyP1)) newVyP1 = 0;
				else if (abs(newVxP1) > abs(newVyP1)) newVxP1 = 0;
			}
			else
			{
				//separate like two circles
				newVxP1 = (c_x - nearest_x) / distance * (player1->get_r() - distance);
				newVyP1 = (c_y - nearest_y) / distance * (player1->get_r() - distance);
			}

			player1->set_x(player1->get_x() + newVxP1);
			player1->set_y(player1->get_y() + newVyP1);
		}

		

		//check collision beetwen  rect player2 and rect obstacles
		left = (player2->get_x() + player2->get_width()) - colliders[i].x;
		right = (colliders[i].x + colliders[i].w) - player2->get_x();
		top = (player2->get_y() + player2->get_height()) - colliders[i].y;
		bottom = (colliders[i].y + colliders[i].h) - player2->get_y();
		

		if ( left > 0 &&  right > 0 && top > 0 &&  bottom > 0)
		{
			if (i == colliders.size() - 1)
			{
				player2Points++;
				player1Wins = false;
				player2Wins = true;
				return true;
			}
			//eventually separate rect player1 from overlaped obstacle
			left < right ? newVxP2 = -left : newVxP2 = right;
			top < bottom ? newVyP2 = -top : newVyP2 = bottom;

			if(abs(newVxP2) < abs(newVyP2)) newVyP2 = 0;
			else if ( abs(newVxP2) > abs(newVyP2)) newVxP2 = 0;

			//if (newVyP2 == 0) printf("TOUCH DETECTED: vx changed\n");
			//else printf("TOUCH DETECTED: vy changed\n");

			player2->set_x(player2->get_x() + newVxP2);
			player2->set_y(player2->get_y() + newVyP2);

		}
	}

	//check collisions beetwen player1 and player2

	l = player2->get_x();
	r = player2->get_x() + player2->get_width();
	t = player2->get_y();
	b = player2->get_y() + player2->get_height();

	if (c_x < l) nearest_x = l;
	else if (l < c_x && c_x < r) nearest_x = c_x;
	else nearest_x = r;


	if (c_y < t) nearest_y = t;
	else if (t < c_y && c_y < b) nearest_y = c_y;
	else nearest_y = b;

	float distance = sqrt(pow(nearest_x - c_x, 2) + pow(nearest_y - c_y, 2));

	if (distance < player1->get_r())
	{
		//eventually separate circle player1 from overlaped obstacle
		if (nearest_x == c_x && nearest_y == c_y)
		{
			//separate like two rects
			left = c_x - l + player1->get_r();
			right = r - c_x + player1->get_r();
			top = c_y - t + player1->get_r();
			bottom = b - c_y + player1->get_r();

			left < right ? newVxP1 = (-left) : newVxP1 = right;
			top < bottom ? newVyP1 = (-top) : newVyP1 =  bottom;

			if (abs(newVxP1) < abs(newVyP1)) newVyP1 = 0;
			else if (abs(newVxP1) > abs(newVyP1)) newVxP1 = 0;

			player1->set_x(player1->get_x() + newVxP1);
			player1->set_y(player1->get_y() + newVyP1);
			player2->set_x(player2->get_x() - newVxP1);
			player2->set_y(player2->get_y() - newVyP1);
		}
		else
		{
			//separate like two circles
			newVxP1 = (c_x - nearest_x) / distance * 0.5 * (player1->get_r() - distance);
			newVyP1 = (c_y - nearest_y) / distance * 0.5 * (player1->get_r() - distance);

			player1->set_x(player1->get_x() + newVxP1);
			player1->set_y(player1->get_y() + newVyP1);
			player2->set_x(player2->get_x() - newVxP1);
			player2->set_y(player2->get_y() - newVyP1);
		}

		
	}

	return false;

	//std::vector<std::vector<std::vector<float>>> normals;
	//for (int i = 0; i < circles.size(); i++)
	//{
	//	for (int j = 0; j < circles.size(); j++)
	//	{
	//		
	//		if (j != i)
	//		{
	//			float left = pow(circles.at(j).GetX() - circles.at(i).GetX(), 2);
	//			float right = pow(circles.at(j).GetY() - circles.at(i).GetY(), 2);

	//			if (left + right < pow(circles.at(i).GetR() + circles.at(j).GetR(), 2))
	//			{
	//				float distance = sqrtf(left + right);
	//				float newVx, newVy;

	//				float overlap = 0.5 * (distance - circles.at(j).GetR() - circles.at(i).GetR());

	//				newVx = overlap * (circles.at(j).GetX() - circles.at(i).GetX()) / distance;

	//				newVy = overlap * (circles.at(j).GetY() - circles.at(i).GetY()) / distance;

	//				

	//				if (isSeparated)
	//				{
	//					circles.at(j).SetX(circles.at(j).GetX() - newVx);
	//					circles.at(j).SetY(circles.at(j).GetY() - newVy);

	//					circles.at(i).SetX(circles.at(i).GetX() + newVx);
	//					circles.at(i).SetY(circles.at(i).GetY() + newVy);
	//				}

	//				if (isBouncing)
	//				{
	//					float defaultMass = 5;
	//					float speedValue1 = sqrtf(powf(circles.at(j).GetVx() , 2) + powf(circles.at(j).GetVy(), 2));
	//					float speedValue2 = sqrtf(powf(circles.at(i).GetVx(), 2) + powf(circles.at(i).GetVy(), 2));
	//					// Normal
	//					float nx = (circles.at(j).GetX() - circles.at(i).GetX()) / distance;
	//					float ny = (circles.at(j).GetY() - circles.at(i).GetY()) / distance;

	//					// Tangent
	//					float tx = -ny;
	//					float ty = nx;

	//					// Dot Product Tangent
	//					float dpTan1 = circles.at(j).GetVx() * tx + circles.at(j).GetVy() * ty;
	//					float dpTan2 = circles.at(i).GetVx() * tx + circles.at(i).GetVy() * ty;

	//					// Dot Product Normal
	//					float dpNorm1 = circles.at(j).GetVx() * nx + circles.at(j).GetVy() * ny;
	//					float dpNorm2 = circles.at(i).GetVx() * nx + circles.at(i).GetVy() * ny;

	//					float m1 = ( 2.0f * defaultMass * dpNorm2) / ( 2 * defaultMass);
	//					float m2 = ( 2.0f * defaultMass * dpNorm1) / (2 * defaultMass);

	//					float finalDistance1 = sqrt((tx * dpTan1 + nx * m1) * (tx * dpTan1 + nx * m1) + (ty * dpTan1 + ny * m1) * (ty * dpTan1 + ny * m1));
	//					float finalDistance2 = sqrt((tx * dpTan2 + nx * m2) * (tx * dpTan2 + nx * m2) + (ty * dpTan2 + ny * m2) * (ty * dpTan2 + ny * m2));

	//					float normFinalX1 = (tx * dpTan1 + nx * m1) / finalDistance1;
	//					float normFinalY1 = (ty * dpTan1 + ny * m1) / finalDistance1;
	//					float normFinalX2 = (tx * dpTan2 + nx * m2) / finalDistance2;
	//					float normFinalY2 = (ty * dpTan2 + ny * m2) / finalDistance2;

	//					circles.at(j).SetVx(normFinalX1 * speedValue1);
	//					circles.at(j).SetVy(normFinalY1 * speedValue1);
	//					circles.at(i).SetVx(normFinalX2 * speedValue2);
	//					circles.at(i).SetVy(normFinalY2 * speedValue2);


	//					/*circles.at(j).SetVx(-circles.at(j).GetVx() + 2 * (circles.at(j).GetVx() * newVx + circles.at(j).GetVy() * newVy) * newVx);
	//					circles.at(j).SetVy(-circles.at(j).GetVy() + 2 * (circles.at(j).GetVx() * newVx + circles.at(j).GetVy() * newVy) * newVy);

	//					circles.at(i).SetVx(circles.at(i).GetVx() - 2 * (circles.at(i).GetVx() * newVx + circles.at(i).GetVy() * newVy) * newVx);
	//					circles.at(i).SetVy(circles.at(i).GetVy() - 2 * (circles.at(i).GetVx() * newVx + circles.at(i).GetVy() * newVy) * newVy);*/
	//				}

	//			}
	//		}
	//	}
	//}
}





