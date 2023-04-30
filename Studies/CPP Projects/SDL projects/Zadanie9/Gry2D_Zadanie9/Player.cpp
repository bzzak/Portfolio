#include "Player.h"
#include <SDL.h>


Player::Player(float x, float y) : x { x }, y { y }
	{
		
	};

	Player::~Player()
	{
	
	};


	const float Player::get_x() const
	{
		return x;
	};


	const float Player::get_y() const
	{
		return y;
	};


	const float Player::get_vx() const
	{
		return vx;
	};


	const float Player::get_vy() const
	{
		return vy;
	};


	const float Player::get_vx_target() const
	{
		return vx_target;
	};


	const float Player::get_vy_target() const
	{
		return vy_target;
	};


	const float Player::get_vx_check() const
	{
		return vx_check;
	};


	const float Player::get_vy_check() const
	{
		return vy_check;
	};


	const bool Player::get_is_velocity_component_very_small(float& component, float target_component, float smooth, float eps)
	{
		component = target_component * (1 - smooth) + component * smooth;
		return component <= eps && component >= -eps;
	};


	const bool Player::get_is_vx_very_small(float smooth, float eps)
	{
		return get_is_velocity_component_very_small(vx_check, vx_target, smooth, eps);
	};


	const bool Player::get_is_vy_very_small(float smooth, float eps)
	{
		return get_is_velocity_component_very_small(vy_check, vy_target, smooth, eps);
	};

	void Player::set_x(float new_x)
	{
		x = new_x;
	};


	void Player::set_y(float new_y)
	{
		y = new_y;
	};


	void Player::set_vx(float new_vx)
	{
		vx = new_vx;
	};


	void Player::set_vy(float new_vy)
	{
		vy = new_vy;
	};


	void Player::set_vx_target(float new_vx_target)
	{
		vx_target = new_vx_target;
	};


	void Player::set_vy_target(float new_vy_target)
	{
		vy_target = new_vy_target;
	};

	void Player::set_vx_check(float new_vx_check)
	{
		vx_check = new_vx_check;
	}

	void Player::set_vy_check(float new_vy_check)
	{
		vy_check = new_vy_check;
	}


	/*void Player::draw(SDL_Renderer* renderer, SDL_Texture* player)
	{
		SDL_Rect player_area = {x, y, size_x, size_y};
		SDL_RenderCopy(renderer, player, NULL, &player_area);
	};*/


	

