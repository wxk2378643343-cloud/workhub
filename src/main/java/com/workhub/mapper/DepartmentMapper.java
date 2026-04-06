package com.workhub.mapper;

import com.workhub.entity.Department;

import java.util.List;

public interface DepartmentMapper {
    List<Department> findAll();

    Department findById(Long id);

    int insert(Department department);

    int update(Department department);

    int deleteById(Long id);
}
