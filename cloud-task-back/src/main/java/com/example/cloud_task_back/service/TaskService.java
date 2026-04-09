package com.example.cloud_task_back.service;

import com.example.cloud_task_back.entity.Task;
import com.example.cloud_task_back.repository.TaskRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TaskService {
    private final TaskRepository repository;

    public TaskService(TaskRepository repository) {
        this.repository = repository;
    }

    public Task create(Task task) {
        return repository.save(task);
    }

    public List<Task> getAll() {
        return repository.findAll();
    }

    public Task update(Long id, Task updatedTask) {
        Task task = repository.findById(id).orElseThrow();
        task.setTitle(updatedTask.getTitle());
        task.setDescription(updatedTask.getDescription());
        task.setStatus(updatedTask.getStatus());
        return repository.save(task);
    }

    public void delete(Long id) {
        repository.deleteById(id);
    }
}