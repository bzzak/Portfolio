#include <SDL.h>
#include <SDL_image.h>
#include <iostream>
#include <string>
#include <fstream>
#include <string>
#include <vector>
#include <sstream>
#include <windows.h>
#include "RectPlayer.h"
#include "Player.h";
#include "Engine.h";

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
SDL_Texture* lanternTexture = NULL;
SDL_Texture* moonTexture = NULL;
SDL_Texture* cloudTexture = NULL;
SDL_Texture* buildingTexture = NULL;
SDL_Texture* trophyTexture = NULL;
SDL_Texture* player1Texture = NULL;
SDL_Texture* player2Texture = NULL;

RectPlayer* player = new RectPlayer(SCREEN_WIDTH / 10 + PLAYER_SIZE / 2, SCREEN_HEIGHT - SCREEN_HEIGHT / 10 - PLAYER_SIZE, PLAYER_SIZE, PLAYER_SIZE);


float smooth = 0.95;

float cameraX = 0;
float cameraY = 0;
bool isCameraXLocked = true;

std::vector<std::string> map; 
std::pair<float, float> cameraOffset;

// JUMPING
bool isJumping = false;
double t_h = .5f;
double h = 300;
double x_h = 140;
double v_0 = -(2 * h * 1 / x_h);
double g = (2 * h * 1 * 1) / (x_h * x_h);
double t = 0;
double vel_y = 0;


// PARALAXIS
std::vector<std::string> frontMap;
std::vector<std::string> backMap;
std::vector<std::string> middleMap;

std::vector<std::pair<int, int>>* frontMapSizes;
std::vector<std::pair<int, int>>* backMapSizes;
std::vector<std::pair<int, int>>* middleMapSizes;

float backParalaxis = 0.3;
float middleParalaxis = 0.6;
float frontParalaxis = 0.8;

bool isParalaxisChanged = true;

bool quit = false;

//float upperCameraBorder = SCREEN_HEIGHT / 8, lowerCameraBorder = SCREEN_HEIGHT - SCREEN_HEIGHT / 8 - PLAYER1_SIZE;
//float vertCameraOffset = 0, vertCameraOffsetSpeed = 0.6;

bool init();
SDL_Texture* loadTexture(std::string path);
bool loadMedia();
std::vector<std::string> loadMapData(std::string filePath);
std::vector<std::pair<int, int>>* loadSizeData(std::string filePath);
void loadMap(std::vector<std::string> data, bool isCollider = true, float paralaxis = 1, std::vector<std::pair<int, int>>* sizes = nullptr);
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

			Uint64 NOW = SDL_GetPerformanceCounter();
			Uint64 LAST = 0;
			double deltaTime = 0;
			double frameTime = 0;

			map = loadMapData("data/walls.txt");
			frontMap = loadMapData("data/frontLayer.txt");
			backMap = loadMapData("data/backgroundLayer.txt");
			middleMap = loadMapData("data/middleLayer.txt");

			frontMapSizes = loadSizeData("data/frontLayerSizes.txt");
			middleMapSizes = loadSizeData("data/middleLayerSizes.txt");
			backMapSizes = loadSizeData("data/backgroundLayerSizes.txt");

			//Main Loop
			while (!quit)
			{
				
				LAST = NOW;
				NOW = SDL_GetPerformanceCounter();

				deltaTime = (double)((NOW - LAST) * 1000 / (double)SDL_GetPerformanceFrequency());
				frameTime = ((double)(NOW - LAST) / (double)10000000);

				eventHandler();

				SDL_SetRenderDrawColor(renderer, 0x00, 0x00, 0x00, 0xFF);
				SDL_RenderClear(renderer);

				loadMap(backMap, false, backParalaxis, backMapSizes);

				loadMap(middleMap, false, middleParalaxis, middleMapSizes);

				loadMap(frontMap, false, frontParalaxis, frontMapSizes);

				loadMap(map);

				player->draw(renderer, player2Texture);

				


				/*SDL_SetRenderDrawColor(renderer, 0, 255, 0, 1);

				for (int i = 0; i < colliders.size(); i++)
				{
					SDL_RenderDrawRect(renderer, &colliders.at(i));
				}*/
				

				if (isJumping)
				{
					vel_y += g * frameTime;
					player->set_vy(vel_y * frameTime + 0.5f * g * frameTime * frameTime);
					t += frameTime;
				}

				cameraOffset = player->move(SCREEN_WIDTH, SCREEN_HEIGHT, cameraX, cameraY, cameraX, isCameraXLocked, deltaTime, smooth, 0.0001);


				if (Engine::Collisions(colliders, player, cameraOffset, cameraX, cameraY, deltaTime))
				{
					isJumping = false;
					player->set_vy(0);
					vel_y = player->get_vy();
					t = 0;
				}
				else 
				{
					isJumping = true;
				}

				colliders.clear();

				//Update screen
				SDL_RenderPresent(renderer);

				//Update Console Info
				if (isParalaxisChanged) 
				{
					clear_screen();
					std::cout << "PARALAXIS DEMO" << std::endl;
					std::cout << "-----------------------------------------" << std::endl;
					std::cout << "FRONT LAYER PARALAXIS     : " << frontParalaxis << std::endl;
					std::cout << "-----------------------------------------" << std::endl;
					std::cout << "MIDDLE LAYER PARALAXIS    : " << middleParalaxis << std::endl;
					std::cout << "-----------------------------------------" << std::endl;
					std::cout << "BACKGROUND LAYER PARALAXIS: " << backParalaxis << std::endl;
					std::cout << "-----------------------------------------" << std::endl;
					isParalaxisChanged = false;
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

		window = SDL_CreateWindow("Zadanie 9", SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED, SCREEN_WIDTH, SCREEN_HEIGHT, SDL_WINDOW_SHOWN);
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

	wallTexture = loadTexture("textures/wallMap.png");
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

	crateTexture = loadTexture("textures/crateMap.png");
	if (crateTexture == NULL)
	{
		std::cout << "Failed to load texture: " << IMG_GetError() << std::endl;
		success = false;
	}

	lanternTexture = loadTexture("textures/lantern.png");
	if (lanternTexture == NULL)
	{
		std::cout << "Failed to load texture: " << IMG_GetError() << std::endl;
		success = false;
	}

	moonTexture = loadTexture("textures/full-moon.png");
	if (moonTexture == NULL)
	{
		std::cout << "Failed to load texture: " << IMG_GetError() << std::endl;
		success = false;
	}

	cloudTexture = loadTexture("textures/cloud.png");
	if (cloudTexture == NULL)
	{
		std::cout << "Failed to load texture: " << IMG_GetError() << std::endl;
		success = false;
	}

	buildingTexture = loadTexture("textures/building.png");
	if (buildingTexture == NULL)
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

std::vector<std::pair<int, int>>* loadSizeData(std::string filePath)
{
	std::vector<std::pair<int, int>>* outputs = new std::vector<std::pair<int, int>>();
	std::ifstream file(filePath);
	std::string tmp;

	std::string width;
	std::string height;

	while (getline(file, tmp))
	{
		std::istringstream iline(tmp);
		getline(iline, width, ',');
		getline(iline, height);
		outputs->push_back(std::pair<int,int>(stoi(width), stoi(height)));
	}

	return outputs;
}

void loadMap(std::vector<std::string> data, bool isCollider, float paralaxis, std::vector<std::pair<int, int>>* sizes)
{
	//std::cout << -stoi(data.at(0)) + 1 << std::endl;
	//std::cout << data.size() - stoi(data.at(0)) - 2 << std::endl;
	int rowIterator = -stoi(data.at(0)) + 1;
	int rowCondition = data.size() - stoi(data.at(0)) + 1 - 2;
	int colIterator = -stoi(data.at(1)) + 1;
	int colCondition = 0;

	int sizeCounter = 0;
	int width = 0;
	int height = 0;

	for (int i = rowIterator; i < rowCondition; i++)
	{
		//std::cout << i + stoi(data.at(0)) + 1 << std::endl;
		std::string row = data.at(i + stoi(data.at(0)) + 1);
		colCondition = row.size() - stoi(data.at(1)) + 1;

		for (int j = colIterator; j < colCondition; j++) {

			if (sizes != nullptr)
			{
				if (sizeCounter < sizes->size() && !(row[j + (std::stoi(data.at(1)) - 1)] == '*'))
				{
					width = sizes->at(sizeCounter).first;
					height = sizes->at(sizeCounter).second;
					sizeCounter++;
				}
				else
				{
					width = SCREEN_WIDTH / 10;
					height = SCREEN_WIDTH / 10;
				}
			}
			else 
			{
				width = SCREEN_WIDTH / 10;
				height = SCREEN_WIDTH / 10;
			}

			area = { (int)(SCREEN_WIDTH / 10 * j + cameraX * paralaxis), (int)(SCREEN_HEIGHT / 10 * i + cameraY * paralaxis), width, height };

			if (!(row[j + (std::stoi(data.at(1)) - 1)] == '*') && isCollider) colliders.push_back(area);

			if (row[j + (std::stoi(data.at(1)) - 1)] == '/') SDL_RenderCopy(renderer, wallTexture, NULL, &area);
			else if (row[j + (stoi(data.at(1)) - 1)] == '$') SDL_RenderCopy(renderer, doorTexture, NULL, &area);
			else if (row[j + (stoi(data.at(1)) - 1)] == '+') SDL_RenderCopy(renderer, crateTexture, NULL, &area);
			else if (row[j + (stoi(data.at(1)) - 1)] == '-') SDL_RenderCopy(renderer, lanternTexture, NULL, &area);
			else if (row[j + (stoi(data.at(1)) - 1)] == '[') SDL_RenderCopy(renderer, moonTexture, NULL, &area);
			else if (row[j + (stoi(data.at(1)) - 1)] == 'o') SDL_RenderCopy(renderer, cloudTexture, NULL, &area);
			else if (row[j + (stoi(data.at(1)) - 1)] == '|') SDL_RenderCopy(renderer, buildingTexture, NULL, &area);
		}
	}
}


void close()
{
	if (wallTexture != NULL) SDL_DestroyTexture(wallTexture);
	if (floorTexture != NULL) SDL_DestroyTexture(floorTexture);
	if (doorTexture != NULL) SDL_DestroyTexture(doorTexture);
	if (crateTexture != NULL) SDL_DestroyTexture(crateTexture);
	if (lanternTexture != NULL) SDL_DestroyTexture(lanternTexture);
	if (moonTexture != NULL) SDL_DestroyTexture(moonTexture);
	if (cloudTexture != NULL) SDL_DestroyTexture(cloudTexture);
	if (buildingTexture != NULL) SDL_DestroyTexture(buildingTexture);
	if (trophyTexture != NULL) SDL_DestroyTexture(trophyTexture);
	if (player1Texture != NULL) SDL_DestroyTexture(player1Texture);
	if (player2Texture != NULL) SDL_DestroyTexture(player2Texture);
	wallTexture = NULL;
	floorTexture = NULL;
	doorTexture = NULL;
	crateTexture = NULL;
	lanternTexture = NULL;
	moonTexture = NULL;
	cloudTexture = NULL;
	buildingTexture = NULL;
	trophyTexture = NULL;
	player1Texture = NULL;
	player2Texture = NULL;

	//close players
	if (player != NULL) delete player;

	player = NULL;

	//close mapSizes

	if (frontMapSizes != NULL) delete frontMapSizes;
	if (middleMapSizes != NULL) delete middleMapSizes;
	if (backMapSizes != NULL) delete backMapSizes;

	frontMapSizes = NULL;
	middleMapSizes = NULL;
	backMapSizes = NULL;

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
		else if (e.type == SDL_KEYDOWN || e.type == SDL_KEYUP)
		{
			
			switch (e.type) {

			case SDL_KEYDOWN:

				switch (e.key.keysym.sym) {
				case 'a':
				case 'A':
					//printf("Key pressed: LEFT!\n");
					player->set_vx_target(-1);
					break;
				case 'd':
				case 'D':
					//printf("Key pressed: RIGHT!\n");
					player->set_vx_target(1);
					break;
				//case 'w':
				//case 'W':
				//	//printf("Key pressed: UP!\n");
				//	player->set_vy_target(-1);
				//	break;
				//case 's':
				//case 'S':
				//	//printf("Key pressed: DOWN!\n");
				//	player->set_vy_target(1);
				//	break;
				case SDLK_UP:
					frontParalaxis += 0.05;
					//cameraX = 0;
					isParalaxisChanged = true;
					break;
				case SDLK_DOWN:
					if(frontParalaxis - 0.05 > 0) frontParalaxis -= 0.05;
					//cameraX = 0;
					isParalaxisChanged = true;
					break;
				case SDLK_LEFT:
					if (middleParalaxis - 0.05 > 0) middleParalaxis -= 0.05;
					//cameraX = 0;
					isParalaxisChanged = true;
					break;
				case SDLK_RIGHT:
					middleParalaxis += 0.05;
					//cameraX = 0;
					isParalaxisChanged = true;
					break;
				case SDLK_o:
					if (backParalaxis - 0.05 > 0) backParalaxis -= 0.05;
					//cameraX = 0;
					isParalaxisChanged = true;
					break;
				case SDLK_p:
					backParalaxis += 0.05;
					//cameraX = 0;
					isParalaxisChanged = true;
					break;
				case SDLK_SPACE:
					if (t < 0.1f)
					{
						isJumping = true;

						v_0 = -(2 * h * 400 / x_h);
						g = (2 * h * 400 * 400) / (x_h * x_h);

						player->set_vy(v_0);
						vel_y = player->get_vy();

						/*clear_screen();

						std::cout << "HEIGHT  : " << h << std::endl;
						std::cout << "DISTANCE: " << x_h << std::endl;
						std::cout << "V0      : " << v_0 << std::endl;
						std::cout << "G       : " << g << std::endl << std::endl;*/
					}
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
					if (player->get_vx() < 0) player->set_vx_target(0);
					break;
				case 'd':
				case 'D':
					//printf("Key released: RIGHT!\n");
					if (player->get_vx() > 0) player->set_vx_target(0);
					break;
				//case 'w':
				//case 'W':
				//	//printf("Key released: UP!\n");
				//	if (player->get_vy() < 0) player->set_vy_target(0);
				//	break;
				//case 's':
				//case 'S':
				//	//printf("Key released: DOWN!\n");
				//	if (player->get_vy() > 0) player->set_vy_target(0);
				//	break;
				
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