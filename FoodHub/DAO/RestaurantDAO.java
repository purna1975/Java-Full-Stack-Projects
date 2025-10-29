package com.tap.dao;

import java.util.List;
import com.tap.model.Restaurant;

public interface RestaurantDAO {
	
	void addRestaurant(Restaurant r);
	Restaurant getRestaurant(int restaurantId);
	void updateRestaurant(Restaurant r);
	void deleteRestaurant(int restaurantId);
	List<Restaurant> getAllRestaurants();
	

}
