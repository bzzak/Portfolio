#include <SDL.h>
#include <SDL_image.h>
#include <iostream>
#include <string>
#include <fstream>
#include <string>
#include <vector>
#include <sstream>

int SCREEN_WIDTH = 800;
int SCREEN_HEIGHT = 600;
int PLAYER_SIZE = 100;
//Analog joystick dead zone
const int JOYSTICK_DEAD_ZONE = 8000;

SDL_Window* window = NULL;
SDL_Renderer* renderer = NULL;
//Game Controller 1 handler
SDL_Joystick* gGameController = NULL;

SDL_Texture* wallTexture = NULL;
SDL_Texture* floorTexture = NULL;
SDL_Texture* doorTexture = NULL;
SDL_Texture* crateTexture = NULL;
SDL_Texture* player1 = NULL;
SDL_Texture* player2 = NULL;
SDL_Rect area;

float x_keyboard_origin = SCREEN_WIDTH / 4 - PLAYER_SIZE / 2, y_keyboard_origin = SCREEN_HEIGHT - SCREEN_HEIGHT/ 2 - PLAYER_SIZE / 2;
float x_keyboard = x_keyboard_origin, x_velocity_keyboard = 0, y_keyboard = y_keyboard_origin, y_velocity_keyboard = 0, x_velocity_target = 0, y_velocity_target = 0;
float x_velocity_keyboard_check = 0, y_velocity_keyboard_check = 0;

float x_gamePad_origin =  3 * SCREEN_WIDTH / 4 - PLAYER_SIZE / 2, y_gamePad_origin = SCREEN_HEIGHT - SCREEN_HEIGHT / 2 - PLAYER_SIZE / 2;
float x_gamePad = x_gamePad_origin, x_velocity_gamePad = 0, y_gamePad = y_gamePad_origin, y_velocity_gamePad = 0, x_velocity_target_gamePad = 0, y_velocity_target_gamePad = 0;
float x_velocity_gamePad_check = 0, y_velocity_gamePad_check = 0;

float smooth = 0.95;

float cameraX = 0;
float cameraY = 0;

float scale = 1;

//float upperCameraBorder = SCREEN_HEIGHT / 8, lowerCameraBorder = SCREEN_HEIGHT - SCREEN_HEIGHT / 8 - PLAYER1_SIZE;
//float vertCameraOffset = 0, vertCameraOffsetSpeed = 0.6;

bool init();
SDL_Texture* loadTexture(std::string path);
bool loadMedia();
std::vector<std::string> loadMapData(std::string filePath);
void loadMap(std::vector<std::string> data);
void close();


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

			bool quit = false;

			SDL_Event e;
			Uint64 NOW = SDL_GetPerformanceCounter();
			Uint64 LAST = 0;
			double deltaTime = 0;

			std::vector<std::string> outputs = loadMapData("map.txt");

			//Main Loop
			while (!quit)
			{
				if ((abs(x_gamePad - x_keyboard) >= (SCREEN_WIDTH / scale - 2*PLAYER_SIZE / scale)  ||
					abs(y_gamePad - y_keyboard) >= SCREEN_HEIGHT / scale - 2*PLAYER_SIZE / scale) && scale >= 0.3)
				{
					scale -= 0.005;
				}

				else if (abs(x_gamePad - x_keyboard) <= (SCREEN_WIDTH - 600) / scale &&
					abs(y_gamePad - y_keyboard) <= (SCREEN_HEIGHT - 450) / scale && scale <= 0.995f &&
					(x_velocity_keyboard != 0 || x_velocity_gamePad != 0 || y_velocity_keyboard != 0 || y_velocity_gamePad != 0))
				{
					scale += 0.005;
					//cameraX -= 4;
					//cameraY -= 3;
					if (x_gamePad >= SCREEN_WIDTH / scale - PLAYER_SIZE / scale)
					{
						x_gamePad -= 8;
					}
					if (y_gamePad >= SCREEN_HEIGHT / scale - PLAYER_SIZE / scale)
					{
						y_gamePad -= 6;
					}
					if (x_keyboard >= SCREEN_WIDTH / scale - PLAYER_SIZE / scale)
					{
						x_keyboard -= 8;
					}
					if (y_gamePad >= SCREEN_WIDTH / scale - PLAYER_SIZE / scale)
					{
						y_keyboard -= 6;
					}
				}
				SDL_RenderSetScale(renderer, scale, scale);
				//SCREEN_WIDTH /= scale;
				//SCREEN_HEIGHT /= scale;
				//PLAYER_SIZE /= scale;
				std::cout << scale << std::endl;



				LAST = NOW;
				NOW = SDL_GetPerformanceCounter();

				deltaTime = (double)((NOW - LAST) * 1000 / (double)SDL_GetPerformanceFrequency());

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
									x_velocity_target_gamePad = -1;
								}
								//Right of dead zone
								else if (e.jaxis.value > JOYSTICK_DEAD_ZONE)
								{
									//std::cout << e.jaxis.value << std::endl;
									x_velocity_target_gamePad = 1;
								}
								else
								{
									x_velocity_target_gamePad = 0;
								}
							}
							//Y axis motion
							else if (e.jaxis.axis == 1)
							{
								//Below of dead zone
								if (e.jaxis.value < -JOYSTICK_DEAD_ZONE)
								{
									//std::cout << e.jaxis.value << std::endl;
									y_velocity_target_gamePad = -1;
								}
								//Above of dead zone
								else if (e.jaxis.value > JOYSTICK_DEAD_ZONE)
								{
									//std::cout << e.jaxis.value << std::endl;
									y_velocity_target_gamePad = 1;
								}
								else
								{
									y_velocity_target_gamePad = 0;
								}
							}
						}

						switch (e.type) {

						case SDL_KEYDOWN:

							switch (e.key.keysym.sym) {
							case SDLK_LEFT:
								x_velocity_target = -1;
								//printf("Key pressed: LEFT!\n");
								break;
							case SDLK_RIGHT:
								x_velocity_target = 1;
								//printf("Key pressed: RIGHT!\n");
								break;
							case SDLK_UP:
								y_velocity_target = -1;
								//printf("Key pressed: UP!\n");
								break;
							case SDLK_DOWN:
								//printf("Key pressed: DOWN!\n");
								y_velocity_target = 1;
								break;
							default:
								break;
							}
							break;


						case SDL_KEYUP:
							switch (e.key.keysym.sym) {

							case SDLK_LEFT:
								if (x_velocity_keyboard < 0)
									x_velocity_target = 0;
								//printf("Key released: LEFT!\n");
								break;
							case SDLK_RIGHT:
								if (x_velocity_keyboard > 0)
									x_velocity_target = 0;
								//printf("Key released: RIGHT!\n");
								break;
							case SDLK_UP:
								if (y_velocity_keyboard < 0)
									y_velocity_target = 0;
								//printf("Key released: UP!\n");
								break;
							case SDLK_DOWN:
								if (y_velocity_keyboard > 0)
									y_velocity_target = 0;
								//printf("Key released: DOWN!\n");
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

				SDL_SetRenderDrawColor(renderer, 0x66, 0x66, 0x66, 0xFF);
				SDL_RenderClear(renderer);

				loadMap(outputs);

				SDL_Rect player1_area = {  x_keyboard, y_keyboard, PLAYER_SIZE, PLAYER_SIZE};
				
				SDL_RenderCopy(renderer, player1, NULL, &player1_area);

				x_velocity_keyboard_check = x_velocity_target * (1 - smooth) + x_velocity_keyboard_check * smooth;
				if (x_velocity_keyboard_check <= 0.0001 && x_velocity_keyboard_check >= -0.0001) x_velocity_keyboard = 0; 
			    else x_velocity_keyboard = x_velocity_keyboard_check;

				if ((x_keyboard + x_velocity_keyboard * deltaTime * 0.5) <= SCREEN_WIDTH / scale - PLAYER_SIZE / scale &&
					(x_keyboard + x_velocity_keyboard * deltaTime * 0.5) >= 0)
				{
					x_keyboard += x_velocity_keyboard * deltaTime * 0.5;
				}
				else
				{
					if (scale >= 0.3)
					{
						cameraX -= x_velocity_keyboard * deltaTime * 0.5;
					}
					if (x_gamePad - x_velocity_keyboard * deltaTime * 0.5 >= 0 &&
						x_gamePad - x_velocity_keyboard * deltaTime * 0.5 <= SCREEN_WIDTH / scale - PLAYER_SIZE / scale)
					{
						x_gamePad -= x_velocity_keyboard * deltaTime * 0.5;
					}
				}

				//std::cout << x_velocity_keyboard << std::endl;

				y_velocity_keyboard_check = y_velocity_target * (1 - smooth) + y_velocity_keyboard_check * smooth;
				if (y_velocity_keyboard_check <= 0.0001 && y_velocity_keyboard_check >= -0.0001) y_velocity_keyboard = 0;
				else y_velocity_keyboard = y_velocity_keyboard_check;

				if ((y_keyboard + y_velocity_keyboard * deltaTime * 0.5) <= SCREEN_HEIGHT / scale - PLAYER_SIZE &&
					(y_keyboard + y_velocity_keyboard * deltaTime * 0.5) >= 0)
				{
					y_keyboard += y_velocity_keyboard * deltaTime * 0.5;
				}
				else
				{
					if (scale >= 0.3)
					{
						cameraY -= y_velocity_keyboard * deltaTime * 0.5;
					}
					if (y_gamePad - y_velocity_keyboard * deltaTime * 0.5 >= 0 &&
						y_gamePad - y_velocity_keyboard * deltaTime * 0.5 <= SCREEN_HEIGHT / scale - PLAYER_SIZE / scale)
					{
						y_gamePad -= y_velocity_keyboard * deltaTime * 0.5;
					}
				}

				//std::cout << y_velocity_keyboard << std::endl;

				SDL_Rect player2_area = { /*x_keyboard_origin*/ x_gamePad, y_gamePad, PLAYER_SIZE, PLAYER_SIZE };

				SDL_RenderCopy(renderer, player2, NULL, &player2_area);

				x_velocity_gamePad_check = x_velocity_target_gamePad * (1 - smooth) + x_velocity_gamePad_check * smooth;
				if (x_velocity_gamePad_check <= 0.0001 && x_velocity_gamePad_check >= -0.0001) x_velocity_gamePad = 0;
				else x_velocity_gamePad = x_velocity_gamePad_check;
				
				if ((x_gamePad + x_velocity_gamePad * deltaTime * 0.5) <= SCREEN_WIDTH / scale - PLAYER_SIZE / scale &&
					(x_gamePad + x_velocity_gamePad * deltaTime * 0.5) >= 0)
				{
					x_gamePad += x_velocity_gamePad * deltaTime * 0.5;
				}
				else
				{
					if (scale >= 0.3)
					{
						cameraX -= x_velocity_gamePad * deltaTime * 0.5;
					}
					if (x_keyboard - x_velocity_gamePad * deltaTime * 0.5 <= SCREEN_WIDTH / scale - PLAYER_SIZE / scale
						&& x_keyboard - x_velocity_gamePad * deltaTime * 0.5 >= 0)
						x_keyboard -= x_velocity_gamePad * deltaTime * 0.5;
				}

				//std::cout << x_velocity_gamePad << std::endl;
				
				y_velocity_gamePad_check = y_velocity_target_gamePad * (1 - smooth) + y_velocity_gamePad_check * smooth;
				if (y_velocity_gamePad_check <= 0.0001 && y_velocity_gamePad_check >= -0.0001) y_velocity_gamePad = 0;
				else y_velocity_gamePad = y_velocity_gamePad_check;
				
				if ((y_gamePad + y_velocity_gamePad * deltaTime * 0.5) <= SCREEN_HEIGHT / scale - PLAYER_SIZE / scale &&
					(y_gamePad + y_velocity_gamePad * deltaTime * 0.5) >= 0)
				{
					y_gamePad += y_velocity_gamePad * deltaTime * 0.5;
				}
				else 
				{
					if (scale >= 0.3)
					{
						cameraY -= y_velocity_gamePad * deltaTime * 0.5;
					}
					if (y_keyboard - y_velocity_gamePad * deltaTime * 0.5 <= SCREEN_HEIGHT / scale - PLAYER_SIZE / scale
						&& y_keyboard - y_velocity_gamePad * deltaTime * 0.5 >= 0)
						y_keyboard -= y_velocity_gamePad * deltaTime * 0.5;
				}

				//std::cout << y_velocity_gamePad << std::endl;

				//std::cout << y_velocity_gamePad << std::endl;
					/*if (y_keyboard < upperCameraBorder) { 
						y_keyboard = upperCameraBorder;
						vertCameraOffset += vertCameraOffsetSpeed;

					}
					else if (y_keyboard > lowerCameraBorder) { 
						y_keyboard = lowerCameraBorder; 
						vertCameraOffset -= vertCameraOffsetSpeed;
					}*/

				//Update screen
				SDL_RenderPresent(renderer);
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

		window = SDL_CreateWindow("Zadanie 5", SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED, SCREEN_WIDTH, SCREEN_HEIGHT, SDL_WINDOW_SHOWN);
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

	player1 = loadTexture("textures/player1.png");
	if (player1 == NULL)
	{
		std::cout << "Failed to load texture: " << IMG_GetError() << std::endl;
		success = false;
	}

	player2 = loadTexture("textures/player2.png");
	if (player2 == NULL)
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
	int rowIterator = -stoi(data.at(0))+1;
	int rowCondition = data.size() - stoi(data.at(0)) - 2;
	int colIterator = -stoi(data.at(1));
	int colCondition = 0;
	for (int i = rowIterator; i < rowCondition; i++)
	{
		//std::cout << i + stoi(data.at(0)) + 1 << std::endl;
		std::string row = data.at(i + stoi(data.at(0)) + 1);
		colCondition = row.size() - stoi(data.at(1));
		for (int j = colIterator; j < colCondition; j++) {
			area = { SCREEN_WIDTH / 10 * (j+1)  + (int)cameraX/*+ (int)(x_keyboard_origin - x_keyboard)*/, SCREEN_HEIGHT / 10 * i + (int)cameraY /*+ (int) vertCameraOffset*/, SCREEN_WIDTH / 10, SCREEN_WIDTH / 10 };
			if (row[j + stoi(data.at(1))] == '/') SDL_RenderCopy(renderer, wallTexture, NULL, &area);
			else if (row[j + std::stoi(data.at(1))] == '*') SDL_RenderCopy(renderer, floorTexture, NULL, &area);
			else if (row[j + stoi(data.at(1))] == '$') SDL_RenderCopy(renderer, doorTexture, NULL, &area);
			else if (row[j + stoi(data.at(1))] == '+') SDL_RenderCopy(renderer, crateTexture, NULL, &area);
		}
	}
}


void close()
{
	if (wallTexture != NULL) SDL_DestroyTexture(wallTexture);
	if (floorTexture != NULL) SDL_DestroyTexture(floorTexture);
	if (doorTexture != NULL) SDL_DestroyTexture(doorTexture);
	if (crateTexture != NULL) SDL_DestroyTexture(crateTexture);
	if (player1 != NULL) SDL_DestroyTexture(player1);
	if (player2 != NULL) SDL_DestroyTexture(player2);
	wallTexture = NULL;
	floorTexture = NULL;
	doorTexture = NULL;
	crateTexture = NULL;
	player1 = NULL;
	player2 = NULL;

	//Close game controller
	if(gGameController != NULL) SDL_JoystickClose(gGameController);
	gGameController = NULL;

	if (renderer != NULL) SDL_DestroyRenderer(renderer);
	if (window != NULL) SDL_DestroyWindow(window);
	renderer = NULL;
	window = NULL;

	IMG_Quit();
	SDL_Quit();
}