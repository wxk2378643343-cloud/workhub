package com.workhub.service.impl;

import com.workhub.entity.Department;
import com.workhub.mapper.DepartmentMapper;
import com.workhub.service.DepartmentService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class DepartmentServiceImpl implements DepartmentService {
    @Resource
    private DepartmentMapper departmentMapper;

    @Override
    public List<Department> list() {
        return departmentMapper.findAll();
    }

    @Override
    public Department getById(Long id) {
        return departmentMapper.findById(id);
    }

    @Override
    public boolean isLeader(Long userId) {
        if (userId == null) {
            return false;
        }
        for (Department department : departmentMapper.findAll()) {
            if (userId.equals(department.getLeaderId())) {
                return true;
            }
        }
        return false;
    }

    @Override
    public void save(Department department) {
        if (department.getId() == null) {
            departmentMapper.insert(department);
        } else {
            departmentMapper.update(department);
        }
    }

    @Override
    public void delete(Long id) {
        departmentMapper.deleteById(id);
    }
}
