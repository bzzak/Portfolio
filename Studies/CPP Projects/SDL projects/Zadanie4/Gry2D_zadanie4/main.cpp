#include <SDL.h>
#include <SDL_image.h>
#include <iostream>
#include <string>
#include <fstream>
#include <string>
#include <vector>
#include <sstream>

const int SCREEN_WIDTH = 600;
const int SCREEN_HEIGHT = 600;
const int PLAYER1_SIZE = 50;

SDL_Window* window = NULL;
SDL_Renderer* renderer = NULL;
SDL_Texture* wallTexture = NULL;
SDL_Texture* floorTexture = NULL;
SDL_Texture* doorTexture = NULL;
SDL_Texture* crateTexture = NULL;
SDL_Rect area;

float x_keyboard_origin = SCREEN_WIDTH / 2 - PLAYER1_SIZE / 2, y_keyboard_origin = SCREEN_HEIGHT - SCREEN_HEIGHT/ 2 - PLAYER1_SIZE / 2;
float x_keyboard = x_keyboard_origin, x_velocity_keyboard = 0, y_keyboard = y_keyboard_origin, y_velocity_keyboard = 0, x_velocity_target = 0, y_velocity_target = 0;

float smooth = 0.75;

float upperCameraBorder = SCREEN_HEIGHT / 8, lowerCameraBorder = SCREEN_HEIGHT - SCREEN_HEIGHT / 8 - PLAYER1_SIZE;
float vertCameraOffset = 0, vertCameraOffsetSpeed = 0.6;

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
				LAST = NOW;
				NOW = SDL_GetPerformanceCounter();

				deltaTime = (double)((NOW - LAST) * 1000 / (double)SDL_GetPerformanceFrequency());

				while (SDL_PollEvent(&e) != 0)
				{

					if (e.type == SDL_QUIT)
					{
						quit = true;
					}

					switch (e.type) {

					case SDL_KEYDOWN:

						switch (e.key.keysym.sym) {
						case SDLK_LEFT:
							x_velocity_target = -1;
							printf("Key pressed: LEFT!\n");
							break;
						case SDLK_RIGHT:
							x_velocity_target = 1;
							printf("Key pressed: RIGHT!\n");
							break;
						case SDLK_UP:
							y_velocity_target = -1;
							printf("Key pressed: UP!\n");
							break;
						case SDLK_DOWN:
							printf("Key pressed: DOWN!\n");
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
							printf("Key released: LEFT!\n");
							break;
						case SDLK_RIGHT:
							if (x_velocity_keyboard > 0)
								x_velocity_target = 0;
							printf("Key released: RIGHT!\n");
							break;
						case SDLK_UP:
							if (y_velocity_keyboard < 0)
								y_velocity_target = 0;
							printf("Key released: UP!\n");
							break;
						case SDLK_DOWN:
							if (y_velocity_keyboard > 0)
								y_velocity_target = 0;
							printf("Key released: DOWN!\n");
							break;
						default:
							break;
						}
						break;

					default:
						break;
					}
				}

				SDL_SetRenderDrawColor(renderer, 0x66, 0x66, 0x66, 0xFF);
				SDL_RenderClear(renderer);

				loadMap(outputs);

				SDL_Rect fillAnotherRect = { x_keyboard_origin, y_keyboard, PLAYER1_SIZE, PLAYER1_SIZE };
				SDL_SetRenderDrawColor(renderer, 0, 255, 0, 255);
				SDL_RenderFillRect(renderer, &fillAnotherRect);

				x_velocity_keyboard = x_velocity_target * (1 - smooth) + x_velocity_keyboard * smooth;
				//if ((x_keyboard + x_velocity_keyboard) <= SCREEN_WIDTH - PLAYER1_SIZE && (x_keyboard + x_velocity_keyboard) >= 0)
				//{
					x_keyboard += x_velocity_keyboard * deltaTime * 0.5;
				//}

				y_velocity_keyboard = y_velocity_target * (1 - smooth) + y_velocity_keyboard * smooth;
				//if ((y_keyboard + y_velocity_keyboard) <= SCREEN_HEIGHT - PLAYER1_SIZE && (y_keyboard + y_velocity_keyboard) >= 0)
				//{
					y_keyboard += y_velocity_keyboard * deltaTime * 0.5;
				//}

					if (y_keyboard < upperCameraBorder) { 
						y_keyboard = upperCameraBorder;
						vertCameraOffset += vertCameraOffsetSpeed;

					}
					else if (y_keyboard > lowerCameraBorder) { 
						y_keyboard = lowerCameraBorder; 
						vertCameraOffset -= vertCameraOffsetSpeed;
					}

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
	if (SDL_Init(SDL_INIT_VIDEO) < 0) {
		std::cout << "Error occured during SDL initialization: " << SDL_GetError() << std::endl;
		success = false;
	}
	else {
		if (!SDL_SetHint(SDL_HINT_RENDER_SCALE_QUALITY, "1"))
		{
			std::cout << "WARNING: Linear taxture filtering disabled!" << std::endl;
		}

		window = SDL_CreateWindow("Zadanie 4", SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED, SCREEN_WIDTH, SCREEN_HEIGHT, SDL_WINDOW_SHOWN);
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
			area = { SCREEN_WIDTH / 10 * (j+1) + (int)(x_keyboard_origin - x_keyboard), SCREEN_WIDTH / 10 * i + (int) vertCameraOffset, SCREEN_WIDTH / 10, SCREEN_WIDTH / 10 };
			if (row[j + stoi(data.at(1))] == '/') SDL_RenderCopy(renderer, wallTexture, NULL, &area);
			else if (row[j + stoi(data.at(1))] == '*') SDL_RenderCopy(renderer, floorTexture, NULL, &area);
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
	wallTexture = NULL;
	floorTexture = NULL;
	doorTexture = NULL;
	crateTexture = NULL;

	if (renderer != NULL) SDL_DestroyRenderer(renderer);
	if (window != NULL) SDL_DestroyWindow(window);
	renderer = NULL;
	window = NULL;

	IMG_Quit();
	SDL_Quit();
}