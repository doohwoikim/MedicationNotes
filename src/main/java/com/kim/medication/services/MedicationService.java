package com.kim.medication.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kim.medication.models.Medication;
import com.kim.medication.models.User;
import com.kim.medication.repositories.MedicationRepository;

@Service
public class MedicationService {
	@Autowired
	private MedicationRepository medicationRepository;

	// ---------Find All
	public List<Medication> allMedications() {
		return medicationRepository.findAll();
	}

	// ------------------FIND ONE---------------
	public Medication findOneMedication(Long id) {
		Optional<Medication> optionalMedication = medicationRepository.findById(id);
		if (optionalMedication.isPresent()) {
			return optionalMedication.get();
		} else {
			return null;
		}
	}

	// -------- Create
	public Medication createMedication(Medication newMedication) {
		return medicationRepository.save(newMedication);
	}

	// -----------------UPDATE --------------
	public Medication updateMedication(Medication oneMedication) {
		return medicationRepository.save(oneMedication);
	}

	// --------------DELETE----------------
	public void removeMedication(Long id) {
		medicationRepository.deleteById(id);
	}

	// ----------------- Additional Features ---------------
	public List<Medication> getTakenMedications(User user) {
		return medicationRepository.findAllByUsers(user);
	}

	public List<Medication> getUntakenMedications(User user) {
		return medicationRepository.findByUsersNotContains(user);
	}
	
	public Medication findMedicationByName(String name) {
        return medicationRepository.findByName(name);
    }
}
