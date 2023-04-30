//Using SDL, SDL_image, standard IO, math, and strings
#include <SDL.h>
#include <SDL_image.h>
#include <stdio.h>
#include <string>
#include <fstream>
#include <iostream>
#include <cmath>
#include <vector>
#include "Circle.h"
#include "CircleCollisionEngine.h"

bool isSeparated = false;
bool isBouncing = false;

//Screen dimension constants
int SCREEN_WIDTH = 800;
int SCREEN_HEIGHT = 800;

//Starts up SDL and creates window
bool init();

//Loads media
bool loadMedia(std::string path);

//Frees media and shuts down SDL
void close();

//Loads individual image as texture
SDL_Texture* loadTexture(std::string path);

////Current displayed texture
SDL_Texture* gTexture = NULL;

//The window we'll be rendering to
SDL_Window* gWindow = NULL;

//The window renderer
SDL_Renderer* gRenderer = NULL;




bool init()
{
	//Initialization flag
	bool success = true;

	//Initialize SDL
	if (SDL_Init(SDL_INIT_VIDEO | SDL_INIT_JOYSTICK) < 0)
	{
		printf("SDL could not initialize! SDL Error: %s\n", SDL_GetError());
		success = false;
	}
	else
	{
		//Set texture filtering to linear
		if (!SDL_SetHint(SDL_HINT_RENDER_SCALE_QUALITY, "1"))
		{
			printf("Warning: Linear texture filtering not enabled!");
		}

		//Create window
		gWindow = SDL_CreateWindow("SDL Circle Colission", SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED, SCREEN_WIDTH, SCREEN_HEIGHT, SDL_WINDOW_SHOWN);
		if (gWindow == NULL)
		{
			printf("Window could not be created! SDL Error: %s\n", SDL_GetError());
			success = false;
		}
		else
		{
			//Create renderer for window
			gRenderer = SDL_CreateRenderer(gWindow, -1, SDL_RENDERER_ACCELERATED);
			if (gRenderer == NULL)
			{
				printf("Renderer could not be created! SDL Error: %s\n", SDL_GetError());
				success = false;
			}
			else
			{
				//Initialize renderer color
				SDL_SetRenderDrawColor(gRenderer, 0xFF, 0xFF, 0xFF, 0xFF);

				//Initialize PNG loading
				int imgFlags = IMG_INIT_PNG;
				if (!(IMG_Init(imgFlags) & imgFlags))
				{
					printf("SDL_image could not initialize! SDL_image Error: %s\n", IMG_GetError());
					success = false;
				}
			}
		}
	}
	return success;
}


bool loadMedia(std::string path)
{
	//Loading success flag
	bool success = true;

	//Load PNG texture
	gTexture = NULL;
	gTexture = loadTexture(path);
	if (gTexture == NULL)
	{
		printf("Failed to load texture image!\n");
		success = false;
	}

	return success;
}

void close()
{
	//Free loaded image
	SDL_DestroyTexture(gTexture);
	gTexture = NULL;

	//Destroy window
	SDL_DestroyRenderer(gRenderer);
	SDL_DestroyWindow(gWindow);
	gWindow = NULL;
	gRenderer = NULL;

	//Quit SDL subsystems
	IMG_Quit();
	SDL_Quit();
}

SDL_Texture* loadTexture(std::string path)
{
	//The final texture
	SDL_Texture* newTexture = NULL;

	//Load image at specified path
	SDL_Surface* loadedSurface = IMG_Load(path.c_str());
	if (loadedSurface == NULL)
	{
		printf("Unable to load image %s! SDL_image Error: %s\n", path.c_str(), IMG_GetError());
	}
	else
	{
		//Create texture from surface pixels
		newTexture = SDL_CreateTextureFromSurface(gRenderer, loadedSurface);
		if (newTexture == NULL)
		{
			printf("Unable to create texture from %s! SDL Error: %s\n", path.c_str(), SDL_GetError());
		}

		//Get rid of old loaded surface
		SDL_FreeSurface(loadedSurface);
	}

	return newTexture;
}


int main(int argc, char* args[])
{

	//Start up SDL and create window
	if (!init())
	{
		printf("Failed to initialize!\n");
	}
	else
	{
		//Load media
		if (!loadMedia("tekstury/kolo.png"))
		{
			printf("Failed to load media!\n");
		}
		else
		{
			//Main loop flag
			bool quit = false;

			//Event handler
			SDL_Event e;

			//Stuff for counting delta time
			Uint64 NOW = SDL_GetPerformanceCounter();
			Uint64 LAST = 0;
			double deltaTime = 0;

			//We will use blend mode to draw transparent shapes.
			SDL_SetRenderDrawBlendMode(gRenderer, SDL_BLENDMODE_BLEND);

			CircleCollisionEngine *engine = new CircleCollisionEngine(SCREEN_WIDTH, SCREEN_HEIGHT);

			srand(time(NULL));

			//Fill with circles
			int position_x = 100;
			int position_y = 100;
			int radian = 25;
			int repetitions = 15;

			for (int i = 0; i < repetitions; i++)
			{
				radian = (10 + static_cast <float> (rand()) / (static_cast <float> (RAND_MAX / (60 - 10))));
				position_x = (radian + static_cast <float> (rand()) / (static_cast <float> (RAND_MAX / (SCREEN_WIDTH - radian - radian))));
				position_y = (radian + static_cast <float> (rand()) / (static_cast <float> (RAND_MAX / (SCREEN_HEIGHT - radian - radian))));
				engine->circles.push_back(Circle(position_x, position_y, radian));
			}

			/*for (position_y = 100; position_y < SCREEN_HEIGHT; position_y += 200)
			{
				for (position_x = 100; position_x < SCREEN_WIDTH; position_x += 200)
				{
					radian = (10 + static_cast <float> (rand()) / (static_cast <float> (RAND_MAX / (50))));
					engine->circles.push_back(Circle(position_x, position_y, radian));
				}
			}*/

			std::cout << "HOW TO USE" << std::endl;
			std::cout << "-------------------------------------------------------" << std::endl;
			std::cout << "Press 's' or 'S' to activate/deactivate ball separation" << std::endl;
			std::cout << "Press 'b' or 'B' to activate/deactivate ball bouncing" << std::endl;
			std::cout << "-------------------------------------------------------" << std::endl;

			//While application is running
			while (!quit)
			{
				//Counting delta time
				LAST = NOW;
				NOW = SDL_GetPerformanceCounter();

				deltaTime = (double)((NOW - LAST) * 1000 / (double)SDL_GetPerformanceFrequency());

				//Handle events on queue
				while (SDL_PollEvent(&e) != 0)
				{
					//User requests quit
					if (e.type == SDL_QUIT)
					{
						quit = true;
					}
					else if (e.type == SDL_KEYDOWN)
					{
						//Select surfaces based on key press
						switch (e.key.keysym.sym)
						{
						case 's':
						case 'S':
							isSeparated = !isSeparated;
							if (isSeparated)
							{
								std::cout << "Ball separation ON!" << std::endl;
							}
							else
								std::cout << "Ball separation OFF!" << std::endl;
							break;

						case 'b':
						case 'B':
							isBouncing = !isBouncing;
							if (isBouncing)
							{
								std::cout << "Ball bouncing ON!" << std::endl;
							}
							else
								std::cout << "Ball bouncing OFF!" << std::endl;
							break;
						}
					}
				}

				//Clear screen
				SDL_SetRenderDrawColor(gRenderer, 125, 125, 125, 255);
				SDL_RenderClear(gRenderer);

				//Render a square and handle its movement depending on keyboard interaction handled earlier in the keyboardMovement function.
				loadMedia("./tekstury/kolo.png");


				//ALL MOVEMENT FOR CIRCLES
				

				engine->Physics(deltaTime, isSeparated, isBouncing);

				engine->BounceFromTheEdges(deltaTime);
				engine->MoveAll(deltaTime);
				


				for (Circle circle : engine->circles) 
				{
					SDL_Rect playerRect = {circle.GetX() - circle.GetR(), circle.GetY() - circle.GetR(), 2 * circle.GetR(), 2 * circle.GetR()};
					SDL_RenderCopy(gRenderer, gTexture, NULL, &playerRect);
				}
				SDL_DestroyTexture(gTexture);

				
				//Update screen
				SDL_RenderPresent(gRenderer);

			}
			delete engine;
		}
	}

	//Free resources and close SDL
	close();

	return 0;
}
