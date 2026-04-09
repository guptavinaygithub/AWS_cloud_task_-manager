package com.example.cloud_task_back.repository;

import com.example.cloud_task_back.entity.Task;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TaskRepository extends JpaRepository<Task, Long> {
}
