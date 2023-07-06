package com.kim.medication.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.kim.medication.models.Medication;
import com.kim.medication.models.User;

@Repository
public interface MedicationRepository extends CrudRepository<Medication, Long> {
	List<Medication> findAll();
	Medication findByIdIs(Long id);
	List<Medication> findAllByUsers(User user);
	List<Medication> findByUsersNotContains(User user);
	Medication findByName(String name);
}
