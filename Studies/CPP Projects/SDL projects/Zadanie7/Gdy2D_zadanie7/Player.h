#pragma once
#include <SDL.h>

class Player
{
protected:
	float x, y;
	float vx = 0, vy = 0;
	float vx_target = 0, vy_target = 0;
	float vx_check = 0, vy_check = 0;

	const bool get_is_velocity_component_very_small(float& component,float target_component, float smooth, float eps);

public:

	Player(float x, float y);

	~Player();


	const float get_x() const;
	const float get_y() const;
	const float get_vx() const;
	const float get_vy() const;
	const float get_vx_target() const;
	const float get_vy_target() const;
	const float get_vx_check() const;
	const float get_vy_check() const;
	const bool get_is_vx_very_small(float smooth, float eps);
	const bool get_is_vy_very_small(float smooth, float eps);

	void set_x(float new_x);
	void set_y(float new_y);
	void set_vx(float new_vx);
	void set_vy(float new_vy);
	void set_vx_target(float new_vx_target);
	void set_vy_target(float new_vy_target);
	void set_vx_check(float new_vx_check);
	void set_vy_check(float new_vy_check);

	virtual void draw(SDL_Renderer* renderer, SDL_Texture* player) = 0;
	virtual void move(int screenWidth, int screenHeight, float scale, float& cameraX, float& cameraY, float deltaTime, float smooth, float eps, Player* player) = 0;
};
