package com.tap.dao;

import java.util.List;
import com.tap.model.Menu;

public interface MenuDAO {
	
	void addMenu(Menu m);
	Menu getMenu(int menuId);
	void updateMenu(Menu m);
	void deleteMenu(int menuId);
	List<Menu> getAllMenus();
	List<Menu> getAllMenusByRestaurantId(int restaurantId);
}