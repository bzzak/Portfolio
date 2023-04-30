#include <SDL.h>
#include <SDL_image.h>
#include <iostream>
#include <string>

const int SCREEN_WIDTH = 600;
const int SCREEN_HEIGHT = 600;

SDL_Window* window = NULL;
//SDL_Surface* screenSurface = NULL;
SDL_Texture* texture1 = NULL;
SDL_Texture* texture2 = NULL;
SDL_Texture* texture3 = NULL;
SDL_Renderer* renderer = NULL;
SDL_Rect area;
int x_pos_3_rect = 250;
int moveFlag = 1;
int move = 1;

bool init();
bool loadMedia();
void close();
SDL_Texture* loadTexture(std::string path);


int main(int argc, char* args[]) 
{
	if (!init()) 
	{
		std::cout << "Fail to init!" << std::endl;
	}
	else 
	{
		if (!loadMedia()) {
			std::cout << "Fail to load media!" << std::endl;
		}
		else 
		{
			bool quit = false;
			//Main Loop
			while (!quit)
			{
				SDL_Event e;
				while (SDL_PollEvent(&e) != 0)
				{
					//User requests quit
					if (e.type == SDL_QUIT)
					{
						quit = true;
					}
				}

				SDL_RenderClear(renderer);

				area = { 50, 100, 100, 100 };
				SDL_RenderCopy(renderer, texture1, NULL, &area);

				area = { 450, 400, 100, 100 };
				SDL_RenderCopy(renderer, texture2, NULL, &area);

				if (x_pos_3_rect >= 500)
				{
					x_pos_3_rect = 500;
					move = -10;
					moveFlag = -1;
				}
				else if (x_pos_3_rect  <= 0)
				{
					x_pos_3_rect = 0;
					move = 10;
					moveFlag = 1;
				}

				area = { x_pos_3_rect, 250, 100, 100 };
				SDL_RenderCopy(renderer, texture3, NULL, &area);

				if (moveFlag == 1) 
				{
					x_pos_3_rect += move;	
					move++;
				}
				else 
				{
					x_pos_3_rect += move;
					move--;
				}

				SDL_RenderPresent(renderer);
				SDL_Delay(50);
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
		window = SDL_CreateWindow("Zadanie 1", SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED, SCREEN_WIDTH, SCREEN_HEIGHT, SDL_WINDOW_SHOWN);
		if (window == NULL) {
			std::cout << "Error occured during window creation: " << SDL_GetError() << std::endl;
			success = false;
		}
		else {
			renderer = SDL_CreateRenderer(window, -1, SDL_RENDERER_ACCELERATED);
			if (renderer == NULL) {
				std::cout << "Error occured during renderer creation: " << SDL_GetError() << std::endl;
				success = false;
			}
			else {
				SDL_SetRenderDrawColor(renderer, 0x66, 0x66, 0x66, 0xFF);

				int imgFlags = IMG_INIT_PNG;
				if (!IMG_Init(imgFlags) & imgFlags) {
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

	texture1 = loadTexture("textures/sdl_1_image.png");
	if (texture1 == NULL)
	{
		std::cout << "Failed to load texture: " << IMG_GetError() << std::endl;
		success = false;
	}

	texture2 = loadTexture("textures/sdl_2_image.png");
	if (texture2 == NULL)
	{
		std::cout << "Failed to load texture: " << IMG_GetError() << std::endl;
		success = false;
	}

	texture3 = loadTexture("textures/sdl_3_image.png");
	if (texture3 == NULL)
	{
		std::cout << "Failed to load texture: " << IMG_GetError() << std::endl;
		success = false;
	}

	return success;
}

void close() 
{

	if(texture1 != NULL) SDL_DestroyTexture(texture1);
	if(texture2 != NULL) SDL_DestroyTexture(texture2);
	if(texture3 != NULL) SDL_DestroyTexture(texture3);
	texture1 = NULL;
	texture2 = NULL;
	texture3 = NULL;

	if (renderer != NULL) SDL_DestroyRenderer(renderer);
	if (window != NULL) SDL_DestroyWindow(window);
	renderer = NULL;
	window = NULL;

	IMG_Quit();
	SDL_Quit();
}