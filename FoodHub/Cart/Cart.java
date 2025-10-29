package com.tap.test;

import java.util.Map;
import java.util.HashMap;

public class Cart {
    private Map<Integer, CartItem> items;

    public Cart() {
        items = new HashMap<>();
    }

    public Map<Integer, CartItem> getItems() {
        return items;
    }

    public void addItem(CartItem item) {
    	int itemId = item.getItemId();
        if (items.containsKey(itemId)) {
            // Update quantity if item already exists
            CartItem existingItem = items.get(itemId);
            existingItem.setQuantity(existingItem.getQuantity() + item.getQuantity());
        } else {
            items.put(itemId, item);
        }
    }

    public void updateItem(int itemId, int quantity) {
        if (items.containsKey(itemId)) {
            if(quantity <= 0) {
            	items.remove(itemId);
            }
            else {
            	items.get(itemId).setQuantity(quantity);
            }
        }
    }

    public void removeItem(int itemId) {
        items.remove(itemId);
    }

    // Add the clear method
    public void clear() {
        items.clear(); // Clears all items in the cart
    }
    public double getTotalPrice() {
        double total = 0.0;
        for (CartItem item : items.values()) {
            total += item.getPrice() * item.getQuantity();
        }
        return total;
    }
}