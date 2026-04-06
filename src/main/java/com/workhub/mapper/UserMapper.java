package com.workhub.mapper;

import com.workhub.entity.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserMapper {
    User findByUsername(@Param("username") String username);

    List<User> findAll();

    List<User> findByRoleCode(@Param("roleCode") String roleCode);

    User findById(@Param("id") Long id);

    int insert(User user);

    int update(User user);

    int updatePassword(@Param("id") Long id, @Param("password") String password);

    int deleteById(@Param("id") Long id);

    int insertUserRole(@Param("userId") Long userId, @Param("roleCode") String roleCode);

    int deleteUserRole(@Param("userId") Long userId);
}
