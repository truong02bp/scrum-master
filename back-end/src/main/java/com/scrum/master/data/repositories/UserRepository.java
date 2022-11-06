package com.scrum.master.data.repositories;

import com.scrum.master.data.entities.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Long> {

    Optional<User> findByEmail(String email);

    @Modifying
    @Query(value = "UPDATE User SET name = ?1,address = ?2, phone = ?3 where id = ?4 ")
    int update(String name, String address, String phone, Long userId);
    @Query(value = "SELECT user FROM User user WHERE user.isActive = false AND user.email = ?1")
    Optional<User> findInactiveUserByEmail(String email);

    @Query(value = "SELECT user FROM User user WHERE user.organization.id = ?1 AND user.isActive = true")
    List<User> findByOrganization(Long organizationId);
}
