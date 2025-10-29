package com.tap.dao;

import java.util.List;

import com.tap.model.Feedback;

public interface FeedbackDao {
    void submitFeedback(Feedback feedback);
    List<Feedback> getAllFeedbacks();
}