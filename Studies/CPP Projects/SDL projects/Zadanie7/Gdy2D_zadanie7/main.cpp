#include <SDL.h>
#include <SDL_image.h>
#include <iostream>
#include <string>
#include <fstream>
#include <string>
#include <vector>
#include <sstream>
#include <windows.h>
#include "CirclePlayer.h"
#include "RectPlayer.h"
#include "Player.h";
#include "CollisionEngine.h";

int SCREEN_WIDTH = 800;
int SCREEN_HEIGHT = 800;
int PLAYER_SIZE = SCREEN_WIDTH / 11;
int TROPHY_SIZE = SCREEN_WIDTH / 11;
//Analog joystick dead zone
const int JOYSTICK_DEAD_ZONE = 8000;

SDL_Window* window = NULL;
SDL_Renderer* renderer = NULL;
//Game Controller 1 handler
SDL_Joystick* gGameController = NULL;

SDL_Rect area;
std::vector<SDL_Rect> colliders;

SDL_Texture* wallTexture = NULL;
SDL_Texture* floorTexture = NULL;
SDL_Texture* doorTexture = NULL;
SDL_Texture* crateTexture = NULL;
SDL_Texture* trophyTexture = NULL;
SDL_Texture* player1Texture = NULL;
SDL_Texture* player2Texture = NULL;

CirclePlayer* player1 = new CirclePlayer(0, 0, PLAYER_SIZE / 2);
RectPlayer* player2 = new RectPlayer(0, 0, PLAYER_SIZE, PLAYER_SIZE);


float smooth = 0.95;

float cameraX = 0;
float cameraY = 0;

float playersCenterX, playersCenterY;

float scale;

bool startOfMap = true;
bool endOfMap = false;
int currentMap = 0;
int player1Points = 0, player2Points = 0;
bool player1Wins = false, player2Wins = false;
char answear;

std::vector<std::string> maps[3];
float scales[3] = { 0.625, 0.500, 0.4165 };
//float scales[3] = { 1, 1, 1 };
//float scales[3] = { 0.4165, 0.4165, 0.4165 };
std::pair<float, float> player1StartPositions[9];
std::pair<float, float> player1StartPosition;
std::pair<float, float> player2StartPositions[9];
std::pair<float, float> player2StartPosition;
std::pair<float, float> trophyPositions[9];
std::pair<float, float> trophyPosition;

bool quit = false;

//float upperCameraBorder = SCREEN_HEIGHT / 8, lowerCameraBorder = SCREEN_HEIGHT - SCREEN_HEIGHT / 8 - PLAYER1_SIZE;
//float vertCameraOffset = 0, vertCameraOffsetSpeed = 0.6;

bool init();
SDL_Texture* loadTexture(std::string path);
bool loadMedia();
std::vector<std::string> loadMapData(std::string filePath);
void loadMap(std::vector<std::string> data);
void close();
void eventHandler();
void clear_screen(char fill = ' ');


int main(int argc, char* args[])
{
	if (!init())
	{
		std::cout << "Fail to init!" << std::endl;
	}
	else
	{
		if (!loadMedia())
		{
			std::cout << "Fail to load media!" << std::endl;
		}
		else
		{
			srand(time(NULL));
			
			Uint64 NOW = SDL_GetPerformanceCounter();
			Uint64 LAST = 0;
			double deltaTime = 0;

			std::vector<std::string> map;

			std::vector<std::string> map1 = loadMapData("map1.txt");
			std::vector<std::string> map2 = loadMapData("map2.txt");
			std::vector<std::string> map3 = loadMapData("map3.txt");

			maps[0] = map1;
			maps[1] = map2;
			maps[2] = map3;

			player1StartPositions[0] = std::pair<float, float>(SCREEN_WIDTH / 10 + ( SCREEN_WIDTH / 10 * 2 - (SCREEN_WIDTH / 10 + player1->get_r() * 2)), SCREEN_HEIGHT / 10 + (SCREEN_HEIGHT / 10 * 2 - (SCREEN_HEIGHT / 10 + player1->get_r() * 2)));
			player1StartPositions[1] = std::pair<float, float>(SCREEN_WIDTH / 10 * 9 + (SCREEN_WIDTH / 10 * 10 - (SCREEN_WIDTH / 10 * 9 + player1->get_r() * 2)), SCREEN_HEIGHT / 10 * 2 + (SCREEN_HEIGHT / 10 * 3 - (SCREEN_HEIGHT / 10 * 2 + player1->get_r() * 2)));
			player1StartPositions[2] = std::pair<float, float>(SCREEN_WIDTH / 10 * 14 + (SCREEN_WIDTH / 10 * 15 - (SCREEN_WIDTH / 10 * 14 + player1->get_r() * 2)), SCREEN_HEIGHT / 10 * 1 + (SCREEN_HEIGHT / 10 * 2 - (SCREEN_HEIGHT / 10 * 1 + player1->get_r() * 2)));

			player1StartPositions[3] = std::pair<float, float>(SCREEN_WIDTH / 10 * 2 + (SCREEN_WIDTH / 10 * 3 - (SCREEN_WIDTH / 10 * 2 + player1->get_r() * 2)), SCREEN_HEIGHT / 10 + (SCREEN_HEIGHT / 10 * 2 - (SCREEN_HEIGHT / 10 + player1->get_r() * 2)));
			player1StartPositions[4] = std::pair<float, float>(SCREEN_WIDTH / 10 * 10 - player1->get_r(), SCREEN_HEIGHT / 10 * 1 + (SCREEN_HEIGHT / 10 * 2 - (SCREEN_HEIGHT / 10 * 1 + player1->get_r() * 2)));
			player1StartPositions[5] = std::pair<float, float>(SCREEN_WIDTH / 10 * 17 + (SCREEN_WIDTH / 10 * 18 - (SCREEN_WIDTH / 10 * 17 + player1->get_r() * 2)), SCREEN_HEIGHT / 10 * 1 + (SCREEN_HEIGHT / 10 * 2 - (SCREEN_HEIGHT / 10 * 1 + player1->get_r() * 2)));

			player1StartPositions[6] = std::pair<float, float>(SCREEN_WIDTH / 10 * 1 + (SCREEN_WIDTH / 10 * 2 - (SCREEN_WIDTH / 10 * 1 + player1->get_r() * 2)), SCREEN_HEIGHT / 10 + (SCREEN_HEIGHT / 10 * 2 - (SCREEN_HEIGHT / 10 + player1->get_r() * 2)));
			player1StartPositions[7] = std::pair<float, float>(SCREEN_WIDTH / 10 * 12 - player1->get_r(), SCREEN_HEIGHT / 10 * 1 + (SCREEN_HEIGHT / 10 * 2 - (SCREEN_HEIGHT / 10 * 1 + player1->get_r() * 2)));
			player1StartPositions[8] = std::pair<float, float>(SCREEN_WIDTH / 10 * 22 + (SCREEN_WIDTH / 10 * 23 - (SCREEN_WIDTH / 10 * 22 + player1->get_r() * 2)), SCREEN_HEIGHT / 10 * 1 + (SCREEN_HEIGHT / 10 * 2 - (SCREEN_HEIGHT / 10 * 1 + player1->get_r() * 2)));


			player2StartPositions[0] = std::pair<float, float>(SCREEN_WIDTH / 10 * 1 + (SCREEN_WIDTH / 10 * 2 - (SCREEN_WIDTH / 10 * 1 + player2->get_width())), SCREEN_HEIGHT / 10 * 14 + (SCREEN_HEIGHT / 10 * 15 - (SCREEN_HEIGHT / 10 * 14 + player2->get_height())));
			player2StartPositions[1] = std::pair<float, float>(SCREEN_WIDTH / 10 * 9 + (SCREEN_WIDTH / 10 * 10 - (SCREEN_WIDTH / 10 * 9 + player2->get_width())), SCREEN_HEIGHT / 10 * 13 + (SCREEN_HEIGHT / 10 * 14 - (SCREEN_HEIGHT / 10 * 13 + player2->get_height())));
			player2StartPositions[2] = std::pair<float, float>(SCREEN_WIDTH / 10 * 14 + (SCREEN_WIDTH / 10 * 15 - (SCREEN_WIDTH / 10 * 14 + player2->get_width())), SCREEN_HEIGHT / 10 * 14 + (SCREEN_HEIGHT / 10 * 15 - (SCREEN_HEIGHT / 10 * 14 + player2->get_height())));

			player2StartPositions[3] = std::pair<float, float>(SCREEN_WIDTH / 10 * 2 + (SCREEN_WIDTH / 10 * 3 - (SCREEN_WIDTH / 10 * 2 + player2->get_width())), SCREEN_HEIGHT / 10 * 18 + (SCREEN_HEIGHT / 10 * 19 - (SCREEN_HEIGHT / 10 * 18 + player2->get_height())));
			player2StartPositions[4] = std::pair<float, float>(SCREEN_WIDTH / 10 * 10 - player2->get_width() / 2, SCREEN_HEIGHT / 10 * 18 + (SCREEN_HEIGHT / 10 * 19 - (SCREEN_HEIGHT / 10 * 18 + player2->get_height())));
			player2StartPositions[5] = std::pair<float, float>(SCREEN_WIDTH / 10 * 17 + (SCREEN_WIDTH / 10 * 18 - (SCREEN_WIDTH / 10 * 17 + player2->get_width())), SCREEN_HEIGHT / 10 * 18 + (SCREEN_HEIGHT / 10 * 19 - (SCREEN_HEIGHT / 10 * 18 + player2->get_height())));

			player2StartPositions[6] = std::pair<float, float>(SCREEN_WIDTH / 10 * 1 + (SCREEN_WIDTH / 10 * 2 - (SCREEN_WIDTH / 10 * 1 + player2->get_width())), SCREEN_HEIGHT / 10 * 22 + (SCREEN_HEIGHT / 10 * 23 - (SCREEN_HEIGHT / 10 * 22 + player2->get_height())));
			player2StartPositions[7] = std::pair<float, float>(SCREEN_WIDTH / 10 * 12 - player2->get_width() / 2, SCREEN_HEIGHT / 10 * 22 + (SCREEN_HEIGHT / 10 * 23 - (SCREEN_HEIGHT / 10 * 22 + player2->get_height())));
			player2StartPositions[8] = std::pair<float, float>(SCREEN_WIDTH / 10 * 22 + (SCREEN_WIDTH / 10 * 23 - (SCREEN_WIDTH / 10 * 22 + player2->get_width())), SCREEN_HEIGHT / 10 * 22 + (SCREEN_HEIGHT / 10 * 23 - (SCREEN_HEIGHT / 10 * 22 + player2->get_height())));


			trophyPositions[0] = std::pair<float, float>(SCREEN_WIDTH / 10 * 2 + (SCREEN_WIDTH / 10 * 3 - (SCREEN_WIDTH / 10 * 2 + TROPHY_SIZE)), SCREEN_HEIGHT / 10 * 5 + (SCREEN_HEIGHT / 10 * 6 - (SCREEN_HEIGHT / 10 * 5 + TROPHY_SIZE)));
			trophyPositions[1] = std::pair<float, float>(SCREEN_WIDTH / 10 * 7 + (SCREEN_WIDTH / 10 /2), SCREEN_HEIGHT / 10 * 7 + (SCREEN_HEIGHT / 10 * 8 - (SCREEN_HEIGHT / 10 * 7 + TROPHY_SIZE)));
			trophyPositions[2] = std::pair<float, float>(SCREEN_WIDTH / 10 * 13 + (SCREEN_WIDTH / 10 * 14 - (SCREEN_WIDTH / 10 * 13 + TROPHY_SIZE)), SCREEN_HEIGHT / 10 * 10 + (SCREEN_HEIGHT / 10 * 11 - (SCREEN_HEIGHT / 10 * 10 + TROPHY_SIZE)));

			trophyPositions[3] = std::pair<float, float>(SCREEN_WIDTH / 10 * 9 + (SCREEN_WIDTH / 10 * 10 - (SCREEN_WIDTH / 10 * 9 + TROPHY_SIZE)), SCREEN_HEIGHT / 10 * 10 - TROPHY_SIZE / 2);
			trophyPositions[4] = std::pair<float, float>(SCREEN_WIDTH / 10 * 4 + (SCREEN_WIDTH / 10 * 5 - (SCREEN_WIDTH / 10 * 4 + TROPHY_SIZE)), SCREEN_HEIGHT / 10 * 9 + (SCREEN_HEIGHT / 10 * 10 - (SCREEN_HEIGHT / 10 * 9 + TROPHY_SIZE)));
			trophyPositions[5] = std::pair<float, float>(SCREEN_WIDTH / 10 * 15 + (SCREEN_WIDTH / 10 * 16 - (SCREEN_WIDTH / 10 * 15 + TROPHY_SIZE)), SCREEN_HEIGHT / 10 * 9 + (SCREEN_HEIGHT / 10 * 10 - (SCREEN_HEIGHT / 10 * 9 + TROPHY_SIZE)));

			trophyPositions[6] = std::pair<float, float>(SCREEN_WIDTH / 10 * 12 - TROPHY_SIZE / 2, SCREEN_HEIGHT / 10 * 12 + (SCREEN_HEIGHT / 10 * 13 - (SCREEN_HEIGHT / 10 * 12 + TROPHY_SIZE)));
			trophyPositions[7] = std::pair<float, float>(SCREEN_WIDTH / 10 * 3 + (SCREEN_WIDTH / 10 * 4 - (SCREEN_WIDTH / 10 * 3 + TROPHY_SIZE)), SCREEN_HEIGHT / 10 * 8 + (SCREEN_HEIGHT / 10 * 9 - (SCREEN_HEIGHT / 10 * 8 + TROPHY_SIZE)));
			trophyPositions[8] = std::pair<float, float>(SCREEN_WIDTH / 10 * 20 + (SCREEN_WIDTH / 10 * 21 - (SCREEN_WIDTH / 10 * 20 + TROPHY_SIZE)), SCREEN_HEIGHT / 10 * 16 + (SCREEN_HEIGHT / 10 * 17 - (SCREEN_HEIGHT / 10 * 16 + TROPHY_SIZE)));


			

			//Main Loop
			while (!quit)
			{
				if (startOfMap) 
				{
					//currentMap = 0;

					player1->set_vx(0);
					player1->set_vy(0);
					player1->set_vx_target(0);
					player1->set_vy_target(0);
					player1->set_vx_check(0);
					player1->set_vy_check(0);

					player2->set_vx(0);
					player2->set_vy(0);
					player2->set_vx_target(0);
					player2->set_vy_target(0);
					player2->set_vx_check(0);
					player2->set_vy_check(0);

					

					player1StartPosition = player1StartPositions[rand() % 3 + currentMap * 3];
					player1->set_x(player1StartPosition.first);
					player1->set_y(player1StartPosition.second);

					player2StartPosition = player2StartPositions[rand() % 3 + currentMap * 3];
					player2->set_x(player2StartPosition.first);
					player2->set_y(player2StartPosition.second);

					trophyPosition = trophyPositions[rand() % 3 + currentMap * 3];

					map = maps[currentMap];
					scale = scales[currentMap];

					printf("\nPLAYER 1     PLAYER 2\n");
					printf("       %d  :  %d\n\n", player1Points, player2Points);

					startOfMap = false;
				}

				eventHandler();

				//if ((abs(player2->get_x() - player1->get_x()) >= (SCREEN_WIDTH / scale - 3 * PLAYER_SIZE / scale) ||
				//		abs(player2->get_y() - player1->get_y()) >= SCREEN_HEIGHT / scale - 3 * PLAYER_SIZE / scale) && scale >= 0.3)
				//{
				//	scale -= 0.005;
				//	if(player2->get_x() > player1->get_x())playersCenterX = abs(player2->get_x() - player1->get_x()) / 2 + player1->get_x();
				//	else playersCenterX = abs(player2->get_x() - player1->get_x()) / 2 + player2->get_x();
				//	if (player2->get_y() > player1->get_y())playersCenterY = abs(player2->get_y() - player1->get_y()) / 2 + player1->get_y();
				//	else playersCenterY = abs(player2->get_y() - player1->get_y()) / 2 + player2->get_y();

				//	cameraX -= (SCREEN_WIDTH / 2 - playersCenterX) / scale;
				//	cameraY -= (SCREEN_HEIGHT / 2 - playersCenterY) / scale;
				//	
				//}
				//else if (abs(player2->get_x() - player1->get_x()) <= (SCREEN_WIDTH - 4 * PLAYER_SIZE) / scale &&
				//		 abs(player2->get_y() - player1->get_y()) <= (SCREEN_HEIGHT - 4 * PLAYER_SIZE) / scale && scale <= 0.995f &&
				//		(player1->get_vx() != 0 || player2->get_vx() != 0 || player1->get_vy() != 0 || player2->get_vy() != 0))
				//{
				//	scale += 0.005;
				//	
				//	if (player2->get_x() > player1->get_x())playersCenterX = abs(player2->get_x() - player1->get_x()) / 2 + player1->get_x();
				//	else playersCenterX = abs(player2->get_x() - player1->get_x()) / 2 + player2->get_x();
				//	if (player2->get_y() > player1->get_y())playersCenterY = abs(player2->get_y() - player1->get_y()) / 2 + player1->get_y();
				//	else playersCenterY = abs(player2->get_y() - player1->get_y()) / 2 + player2->get_y();

				//	cameraX -= (SCREEN_WIDTH  / 2 - playersCenterX) / scale;
				//	cameraY -= (SCREEN_HEIGHT / 2 - playersCenterY) / scale;

				//	/*if (player2->get_x() >= SCREEN_WIDTH / scale - 2 * (PLAYER_SIZE / scale))
				//	{
				//		player2->set_x(player2->get_x() - 8);
				//	}
				//	if (player2->get_y() >= SCREEN_HEIGHT / scale - 2 * (PLAYER_SIZE / scale))
				//	{
				//		player2->set_y(player2->get_y() - 6);
				//	}
				//	if (player1->get_x() >= SCREEN_WIDTH / scale - 2 * (PLAYER_SIZE / scale))
				//	{
				//		player1->set_x(player1->get_x() - 8);
				//	}
				//	if (player1->get_y() >= SCREEN_WIDTH / scale - 2 * (PLAYER_SIZE / scale))
				//	{
				//		player1->set_y(player1->get_y() - 6);
				//	}*/
				//}
				//printf("scale: %f\n", scale);
				SDL_RenderSetScale(renderer, scale, scale);
				
				LAST = NOW;
				NOW = SDL_GetPerformanceCounter();

				deltaTime = (double)((NOW - LAST) * 1000 / (double)SDL_GetPerformanceFrequency());
				
				SDL_SetRenderDrawColor(renderer, 0x66, 0x66, 0x66, 0xFF);
				SDL_RenderClear(renderer);

				loadMap(map);

				area = { (int)trophyPosition.first + (int)cameraX, (int)trophyPosition.second + (int)cameraY, TROPHY_SIZE, TROPHY_SIZE };
				SDL_RenderCopy(renderer, trophyTexture, NULL, &area);

				colliders.push_back(area);

				SDL_SetRenderDrawColor(renderer, 0, 255, 0, 1);

				for (int i = 0; i < colliders.size(); i++) 
				{
					SDL_RenderDrawRect(renderer, &colliders.at(i));
				}
				SDL_Rect cameraBorder= { SCREEN_WIDTH / 10 , SCREEN_HEIGHT / 10, (SCREEN_WIDTH  - SCREEN_WIDTH  / 10) / scale   /* - 30*/, (SCREEN_HEIGHT - SCREEN_HEIGHT / 10) / scale  /* - 30*/};
				
				SDL_SetRenderDrawColor(renderer, 255, 0, 0, 1);
				SDL_RenderDrawRect(renderer, &cameraBorder);

				player1->draw(renderer, player1Texture);
				player1->move(SCREEN_WIDTH, SCREEN_HEIGHT, scale, cameraX, cameraY, deltaTime, smooth, 0.0001, player2);

				player2->draw(renderer, player2Texture);
				player2->move(SCREEN_WIDTH, SCREEN_HEIGHT, scale, cameraX, cameraY, deltaTime, smooth, 0.0001, player1);

				endOfMap = CollisionEngine::Physics(colliders, player1, player2, player1Points, player2Points, player1Wins, player2Wins, deltaTime);

				colliders.clear();
				
					//Update screen
				SDL_RenderPresent(renderer);

				//if ((abs(player2->get_x() - player1->get_x()) >= (SCREEN_WIDTH  - SCREEN_WIDTH / 10) / scale  ||
				//		abs(player2->get_y() - player1->get_y()) >= SCREEN_HEIGHT - SCREEN_HEIGHT / 10) / scale  && scale >= 0.3)
				//{
				//	scale -= 0.005;
				//	/*if(player2->get_x() > player1->get_x())playersCenterX = abs(player2->get_x() - player1->get_x()) / 2 + player1->get_x();
				//	else playersCenterX = abs(player2->get_x() - player1->get_x()) / 2 + player2->get_x();
				//	if (player2->get_y() > player1->get_y())playersCenterY = abs(player2->get_y() - player1->get_y()) / 2 + player1->get_y();
				//	else playersCenterY = abs(player2->get_y() - player1->get_y()) / 2 + player2->get_y();*/

				//	/*cameraX -= (SCREEN_WIDTH / 2 - playersCenterX) / scale;
				//	cameraY -= (SCREEN_HEIGHT / 2 - playersCenterY) / scale;*/
				//	
				//}
				//else if (abs(player2->get_x() - player1->get_x()) <= (SCREEN_WIDTH - 4 * PLAYER_SIZE) / scale &&
				//		 abs(player2->get_y() - player1->get_y()) <= (SCREEN_HEIGHT - 4 * PLAYER_SIZE) / scale && scale <= 0.995f &&
				//		(player1->get_vx() != 0 || player2->get_vx() != 0 || player1->get_vy() != 0 || player2->get_vy() != 0))
				//{
				//	scale += 0.005;
				//	
				//	/*if (player2->get_x() > player1->get_x())playersCenterX = abs(player2->get_x() - player1->get_x()) / 2 + player1->get_x();
				//	else playersCenterX = abs(player2->get_x() - player1->get_x()) / 2 + player2->get_x();
				//	if (player2->get_y() > player1->get_y())playersCenterY = abs(player2->get_y() - player1->get_y()) / 2 + player1->get_y();
				//	else playersCenterY = abs(player2->get_y() - player1->get_y()) / 2 + player2->get_y();

				//	cameraX -= (SCREEN_WIDTH  / 2 - playersCenterX) / scale;
				//	cameraY -= (SCREEN_HEIGHT / 2 - playersCenterY) / scale;*/

				//	/*if (player2->get_x() >= SCREEN_WIDTH / scale - 2 * (PLAYER_SIZE / scale))
				//	{
				//		player2->set_x(player2->get_x() - 8);
				//	}
				//	if (player2->get_y() >= SCREEN_HEIGHT / scale - 2 * (PLAYER_SIZE / scale))
				//	{
				//		player2->set_y(player2->get_y() - 6);
				//	}
				//	if (player1->get_x() >= SCREEN_WIDTH / scale - 2 * (PLAYER_SIZE / scale))
				//	{
				//		player1->set_x(player1->get_x() - 8);
				//	}
				//	if (player1->get_y() >= SCREEN_WIDTH / scale - 2 * (PLAYER_SIZE / scale))
				//	{
				//		player1->set_y(player1->get_y() - 6);
				//	}*/
				//}

				if (endOfMap)
				{
					printf("End of Map!\n");
					clear_screen();
					if(player1Wins) printf("\nPLAYER 1 WINS %d MAP!", currentMap + 1);
					else printf("\nPLAYER 2 WINS %d MAP!", currentMap + 1);
					SDL_Delay(2000);
					clear_screen();

					currentMap++;

					if ( player1Points == 2 || player2Points == 2) 
					{
						clear_screen();
						if (player1Points > player2Points) printf("\nPLAYER 1 WINS THE GAME!");
						else printf("\nPLAYER 2 WINS THE GAME!");
						SDL_Delay(2000);
						clear_screen();
						printf("\nPlay Again ( type y / Y for YES or type anything else to end the game ) ?\n");
						printf("Answear: ");
						std::cin >> answear;

						clear_screen();

						if (!(answear == 'y' || answear == 'Y'))
						{
							quit = true;
						}

						player1Points = 0;
						player2Points = 0;
						currentMap = 0;

						SDL_PumpEvents();
						SDL_FlushEvents(SDL_FIRSTEVENT,SDL_LASTEVENT);
					}

					startOfMap = true;
					endOfMap = false;
				}
			}
		}
	}

	close();
	return 0;
}

bool init()
{
	bool success = true;
	if (SDL_Init(SDL_INIT_VIDEO | SDL_INIT_JOYSTICK) < 0) {
		std::cout << "Error occured during SDL initialization: " << SDL_GetError() << std::endl;
		success = false;
	}
	else {
		if (!SDL_SetHint(SDL_HINT_RENDER_SCALE_QUALITY, "1"))
		{
			std::cout << "WARNING: Linear taxture filtering disabled!" << std::endl;
		}

		//Check for joysticks
		if (SDL_NumJoysticks() < 1)
		{
			std::cout << "WARNING: No joysticks connected!" << std::endl;
		}
		else
		{
			//Load joystick
			gGameController = SDL_JoystickOpen(0);
			if (gGameController == NULL)
			{
				std::cout << "WARNING: Unable to open game controller! SDL Error: " << SDL_GetError() << std::endl;
			}
		}

		window = SDL_CreateWindow("Zadanie 7", SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED, SCREEN_WIDTH, SCREEN_HEIGHT, SDL_WINDOW_SHOWN);
		if (window == NULL)
		{
			std::cout << "Error occured during window creation: " << SDL_GetError() << std::endl;
			success = false;
		}
		else
		{
			renderer = SDL_CreateRenderer(window, -1, SDL_RENDERER_ACCELERATED);
			if (renderer == NULL)
			{
				std::cout << "Error occured during renderer creation: " << SDL_GetError() << std::endl;
				success = false;
			}
			else
			{
				SDL_SetRenderDrawColor(renderer, 0x66, 0x66, 0x66, 0xFF);

				int imgFlags = IMG_INIT_PNG;
				if (!(IMG_Init(imgFlags) & imgFlags))
				{
					std::cout << "Error occured during IMG initialization: " << IMG_GetError() << std::endl;
					success = false;
				}
			}

		}
	}

	return success;
}

SDL_Texture* loadTexture(std::string path)
{
	SDL_Texture* newTexture = NULL;

	newTexture = IMG_LoadTexture(renderer, path.c_str());
	if (newTexture == NULL)
	{
		std::cout << "Error occured during loading texture " << path << " : " << IMG_GetError() << std::endl;
	}
	return newTexture;
}

bool loadMedia()
{
	bool success = true;

	wallTexture = loadTexture("textures/wall.png");
	if (wallTexture == NULL)
	{
		std::cout << "Failed to load texture: " << IMG_GetError() << std::endl;
		success = false;
	}

	floorTexture = loadTexture("textures/floor.png");
	if (floorTexture == NULL)
	{
		std::cout << "Failed to load texture: " << IMG_GetError() << std::endl;
		success = false;
	}

	doorTexture = loadTexture("textures/door.png");
	if (doorTexture == NULL)
	{
		std::cout << "Failed to load texture: " << IMG_GetError() << std::endl;
		success = false;
	}

	crateTexture = loadTexture("textures/crate.png");
	if (crateTexture == NULL)
	{
		std::cout << "Failed to load texture: " << IMG_GetError() << std::endl;
		success = false;
	}

	trophyTexture = loadTexture("textures/trophy.png");
	if (trophyTexture == NULL)
	{
		std::cout << "Failed to load texture: " << IMG_GetError() << std::endl;
		success = false;
	}

	player1Texture = loadTexture("textures/circlePlayer.png");
	if (player1Texture == NULL)
	{
		std::cout << "Failed to load texture: " << IMG_GetError() << std::endl;
		success = false;
	}

	player2Texture = loadTexture("textures/squarePlayer.png");
	if (player2Texture == NULL)
	{
		std::cout << "Failed to load texture: " << IMG_GetError() << std::endl;
		success = false;
	}

	return success;
}

std::vector<std::string> loadMapData(std::string filePath)
{
	std::vector<std::string> outputs;
	std::ifstream file(filePath);
	std::string tmp;

	std::string row;
	std::string column;

	getline(file, tmp);
	std::istringstream iline(tmp);
	getline(iline, row, ',');
	getline(iline, column);

	outputs.push_back(row);
	outputs.push_back(column);

	while (getline(file, tmp))
	{
		outputs.push_back(tmp);
	}
	return outputs;
}

void loadMap(std::vector<std::string> data)
{
	//std::cout << -stoi(data.at(0)) + 1 << std::endl;
	//std::cout << data.size() - stoi(data.at(0)) - 2 << std::endl;
	int rowIterator = -stoi(data.at(0)) + 1;
	int rowCondition = data.size() - stoi(data.at(0)) + 1 - 2;
	int colIterator = -stoi(data.at(1)) + 1;
	int colCondition = 0;
	for (int i = rowIterator; i < rowCondition; i++)
	{
		//std::cout << i + stoi(data.at(0)) + 1 << std::endl;
		std::string row = data.at(i + stoi(data.at(0)) + 1);
		colCondition = row.size() - stoi(data.at(1)) + 1;
		
		for (int j = colIterator; j < colCondition; j++) {
			area = { SCREEN_WIDTH / 10 * j + (int)cameraX/*+ (int)(x_keyboard_origin - x_keyboard)*/, SCREEN_HEIGHT / 10 * i + (int)cameraY /*+ (int) vertCameraOffset*/, SCREEN_WIDTH / 10, SCREEN_WIDTH / 10 };

			if (!(row[j + (std::stoi(data.at(1)) - 1)] == '*')) colliders.push_back(area);
			
			if (row[j + (std::stoi(data.at(1)) - 1)] == '/') SDL_RenderCopy(renderer, wallTexture, NULL, &area);
			else if (row[j + (std::stoi(data.at(1)) - 1)] == '*') SDL_RenderCopy(renderer, floorTexture, NULL, &area);
			else if (row[j + (stoi(data.at(1)) - 1)] == '$') SDL_RenderCopy(renderer, doorTexture, NULL, &area);
			else if (row[j + (stoi(data.at(1)) - 1)] == '+') SDL_RenderCopy(renderer, crateTexture, NULL, &area);
		}
	}
}


void close()
{
	if (wallTexture != NULL) SDL_DestroyTexture(wallTexture);
	if (floorTexture != NULL) SDL_DestroyTexture(floorTexture);
	if (doorTexture != NULL) SDL_DestroyTexture(doorTexture);
	if (crateTexture != NULL) SDL_DestroyTexture(crateTexture);
	if (trophyTexture != NULL) SDL_DestroyTexture(trophyTexture);
	if (player1Texture != NULL) SDL_DestroyTexture(player1Texture);
	if (player2Texture != NULL) SDL_DestroyTexture(player2Texture);
	wallTexture = NULL;
	floorTexture = NULL;
	doorTexture = NULL;
	crateTexture = NULL;
	trophyTexture = NULL;
	player1Texture = NULL;
	player2Texture = NULL;

	//close players
	if (player1 != NULL) delete player1;
	if (player2 != NULL) delete player2;

	player1 = NULL;
	player2 = NULL;

	//Close game controller
	if (gGameController != NULL) SDL_JoystickClose(gGameController);
	gGameController = NULL;

	if (renderer != NULL) SDL_DestroyRenderer(renderer);
	if (window != NULL) SDL_DestroyWindow(window);
	renderer = NULL;
	window = NULL;

	IMG_Quit();
	SDL_Quit();
}

void eventHandler()
{
	SDL_Event e;
	//printf("Enter Handler!\n");

	while (SDL_PollEvent(&e) != 0)
	{

		if (e.type == SDL_QUIT)
		{
			quit = true;
		}
		else if (e.type == SDL_KEYDOWN || e.type == SDL_KEYUP || e.type == SDL_JOYAXISMOTION)
		{
			//Motion on controller 0
			if (e.jaxis.which == 0)
			{
				//X axis motion
				if (e.jaxis.axis == 0)
				{
					//Left of dead zone
					if (e.jaxis.value < -JOYSTICK_DEAD_ZONE)
					{
						//std::cout << e.jaxis.value << std::endl;
						//x_velocity_target_gamePad = -1;
						player2->set_vx_target(-1);
					}
					//Right of dead zone
					else if (e.jaxis.value > JOYSTICK_DEAD_ZONE)
					{
						//std::cout << e.jaxis.value << std::endl;
						//x_velocity_target_gamePad = 1;
						player2->set_vx_target(1);
					}
					else
					{
						//x_velocity_target_gamePad = 0;
						player2->set_vx_target(0);
					}
				}
				//Y axis motion
				else if (e.jaxis.axis == 1)
				{
					//Below of dead zone
					if (e.jaxis.value < -JOYSTICK_DEAD_ZONE)
					{
						//std::cout << e.jaxis.value << std::endl;
						//y_velocity_target_gamePad = -1;
						player2->set_vy_target(-1);
					}
					//Above of dead zone
					else if (e.jaxis.value > JOYSTICK_DEAD_ZONE)
					{
						//std::cout << e.jaxis.value << std::endl;
						//y_velocity_target_gamePad = 1;
						player2->set_vy_target(1);
					}
					else
					{
						//y_velocity_target_gamePad = 0;
						player2->set_vy_target(0);
					}
				}
			}

			switch (e.type) {

			case SDL_KEYDOWN:

				switch (e.key.keysym.sym) {
				case 'a':
				case 'A':
					//printf("Key pressed: LEFT!\n");
					player1->set_vx_target(-1);
					break;
				case 'd':
				case 'D':
					//printf("Key pressed: RIGHT!\n");
					player1->set_vx_target(1);
					break;
				case 'w':
				case 'W':
					//printf("Key pressed: UP!\n");
					player1->set_vy_target(-1);
					break;
				case 's':
				case 'S':
					//printf("Key pressed: DOWN!\n");
					player1->set_vy_target(1);
					break;
				default:
					break;
				}
				break;


			case SDL_KEYUP:
				switch (e.key.keysym.sym) {

				case 'a':
				case 'A':
					//printf("Key released: LEFT!\n");
					if (player1->get_vx() < 0) player1->set_vx_target(0);
					break;
				case 'd':
				case 'D':
					//printf("Key released: RIGHT!\n");
					if (player1->get_vx() > 0) player1->set_vx_target(0);
					break;
				case 'w':
				case 'W':
					//printf("Key released: UP!\n");
					if (player1->get_vy() < 0) player1->set_vy_target(0);
					break;
				case 's':
				case 'S':
					//printf("Key released: DOWN!\n");
					if (player1->get_vy() > 0) player1->set_vy_target(0);
					break;
				default:
					break;
				}
				break;

			default:
				break;
			}
		}
	}
}



void clear_screen(char fill) {
	COORD tl = { 0,0 };
	CONSOLE_SCREEN_BUFFER_INFO s;
	HANDLE console = GetStdHandle(STD_OUTPUT_HANDLE);
	GetConsoleScreenBufferInfo(console, &s);
	DWORD written, cells = s.dwSize.X * s.dwSize.Y;
	FillConsoleOutputCharacter(console, fill, cells, tl, &written);
	FillConsoleOutputAttribute(console, s.wAttributes, cells, tl, &written);
	SetConsoleCursorPosition(console, tl);
}