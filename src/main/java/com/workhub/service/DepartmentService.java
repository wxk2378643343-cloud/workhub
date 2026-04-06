package com.workhub.service;

import com.workhub.entity.Department;

import java.util.List;

public interface DepartmentService {
    List<Department> list();

    Department getById(Long id);

    boolean isLeader(Long userId);

    void save(Department department);

    void delete(Long id);
}
