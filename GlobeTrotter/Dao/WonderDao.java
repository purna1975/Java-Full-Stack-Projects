package com.tap.dao;

import java.util.List;

import com.tap.model.Wonder;

public interface WonderDao {
    List<Wonder> getAllWonders();
    Wonder getWonderById(int wonderId);
}
