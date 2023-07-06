package com.kim.medication.controllers;

import java.util.Comparator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;

import com.kim.medication.models.LoginUser;
import com.kim.medication.models.Medication;
import com.kim.medication.models.User;
import com.kim.medication.services.MedicationService;
import com.kim.medication.services.UserService;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class MainController {
	@Autowired
	private UserService userService;

	@Autowired
	private MedicationService medicationService;

	@GetMapping("/")
	public String main() {
		return "main.jsp";
	}

	// ----------- LOGIN & REGISTERATION ---------
	@GetMapping("/logreg")
	public String index(Model model, HttpSession session) {
		if (session.getAttribute("user_id") != null) {
			return "redirect:/";
		}
		model.addAttribute("newUser", new User());
		model.addAttribute("newLogin", new LoginUser());
		return "index.jsp";
	}

	@PostMapping("/register")
	public String processRegister(@Valid @ModelAttribute("newUser") User newUser, BindingResult result, Model model,
			HttpSession session) {

		User registeredUser = userService.register(newUser, result);

		if (result.hasErrors() || registeredUser == null) {
			model.addAttribute("newLogin", new LoginUser());
			return "index.jsp";
		} else {
			session.setAttribute("userId", registeredUser.getId());
			session.setAttribute("userName", registeredUser.getUserName());
			return "redirect:/dashboard";
		}
	}

	@PostMapping("/login")
	public String processLogin(@Valid @ModelAttribute("newLogin") LoginUser newLogin, BindingResult result, Model model,
			HttpSession session) {

		User loginUser = userService.login(newLogin, result);
		if (result.hasErrors() || loginUser == null) {
			model.addAttribute("newUser", new User());
			return "index.jsp";
		} else {
			session.setAttribute("userId", loginUser.getId());
			session.setAttribute("userName", loginUser.getUserName());
			return "redirect:/dashboard";
		}
	}

	@GetMapping("/logout")
	public String logout(HttpSession session) {
		if (session.getAttribute("userId") == null) {
			return "redirect:/";
		}
		session.invalidate();
		System.out.println("***Logout!!");
		return "redirect:/";
	}

	// --------- Display
	@GetMapping("/dashboard")
	public String dashboard(Model model, HttpSession session) {
		if (session.getAttribute("userId") == null) {
			System.out.println("***protected");
			return "redirect:/logout";
		}
		User loggedUser = userService.findUser((Long) session.getAttribute("userId"));

		List<Medication> untakenMedications = medicationService.getUntakenMedications(loggedUser);
		untakenMedications.sort(Comparator.comparing(Medication::getDate));

		List<Medication> takenMedications = medicationService.getTakenMedications(loggedUser);
		takenMedications.sort(Comparator.comparing(Medication::getDate));

		List<Medication> medicationList = medicationService.allMedications();
		medicationList.sort(Comparator.comparing(Medication::getDate));

		model.addAttribute("loggedUser", loggedUser);
		model.addAttribute("untakenMedications", untakenMedications);
		model.addAttribute("takenMedications", takenMedications);
		model.addAttribute("medicationList", medicationList);

		return "dashboard.jsp";
	}

	// ------------ Display myMedicaions
	@GetMapping("/medications/mymed")
	public String mymedicationList(Model model, HttpSession session) {
		if (session.getAttribute("userId") == null) {
			System.out.println("***protected");
			return "redirect:/logout";
		}
		User loggedUser = userService.findUser((Long) session.getAttribute("userId"));

		List<Medication> untakenMedications = medicationService.getUntakenMedications(loggedUser);
		untakenMedications.sort(Comparator.comparing(Medication::getDate));

		List<Medication> takenMedications = medicationService.getTakenMedications(loggedUser);
		takenMedications.sort(Comparator.comparing(Medication::getDate));

		List<Medication> medicationList = medicationService.allMedications();
		medicationList.sort(Comparator.comparing(Medication::getDate));

		model.addAttribute("loggedUser", loggedUser);
		model.addAttribute("untakenMedications", untakenMedications);
		model.addAttribute("takenMedications", takenMedications);
		model.addAttribute("medicationList", medicationList);
		return "myMedication.jsp";
	}

	// ------------ Create
	@GetMapping("/medications/new")
	public String renderCreateForm(@ModelAttribute("newMedication") Medication newMedication, HttpSession session,
			Model model) {
		if (session.getAttribute("userId") == null) {
			System.out.println("***protected");
			return "redirect:/logout";
		}
		Long userId = (Long) session.getAttribute("userId");
		model.addAttribute("userId", userId);
		return "create.jsp";
	}

	@PostMapping("/medications/new")
	public String processCreateForm(@Valid @ModelAttribute("newMedication") Medication newMedication,
			BindingResult result, Model model, HttpSession session) {
		if (session.getAttribute("userId") == null) {
			System.out.println("***protected");
			return "redirect:/logout";
		}
		if (result.hasErrors()) {
			return "create.jsp";
		}
		if (medicationService.findMedicationByName(newMedication.getName()) != null) {
			result.rejectValue("name", "error.medication", "Medication with this name already exists");
			return "create.jsp";
		} else {

			medicationService.createMedication(newMedication);
			Long userId = (Long) session.getAttribute("userId");
			User user = userService.findUser(userId);
			user.getMedications().add(newMedication);
			userService.updateUser(user);
			return "redirect:/dashboard";
		}
	}

	// -----------DETAIL
	@GetMapping("/medications/{id}")
	public String projectDetails(@PathVariable("id") Long id, Model model, HttpSession session) {
		if (session.getAttribute("userId") == null) {
			System.out.println("***protected");
			return "redirect:/logout";
		}
		Medication oneMedication = medicationService.findOneMedication(id);
		model.addAttribute("oneMedication", oneMedication);
		return "detail.jsp";
	}

	// ------------- Edit
	@GetMapping("/medications/edit/{id}")
	public String renderEditFrom(@PathVariable("id") Long id, Model model, HttpSession session) {
		Medication oneMedication = medicationService.findOneMedication(id);
		Long editingUserId = oneMedication.getUser().getId();
		if (!editingUserId.equals(session.getAttribute("userId"))) {
			System.out.println("***protected");
			return "redirect:/logout";
		}
		if (session.getAttribute("userId") == null) {
			System.out.println("***protected");
			return "redirect:/logout";
		}
		User loggedUser = userService.findUser((Long) session.getAttribute("userId"));
		model.addAttribute("loggedUser", loggedUser);
		model.addAttribute("oneMedication", oneMedication);
		return "edit.jsp";
	}

	@PutMapping("/medications/edit/{id}")
	public String processEditForm(@PathVariable("id") Long id,
			@Valid @ModelAttribute("oneMedication") Medication oneMedication, BindingResult result, Model model,
			HttpSession session) {
		if (session.getAttribute("userId") == null) {
			System.out.println("***protected");
			return "redirect:/logout";
		}
		if (result.hasErrors()) {
			return "edit.jsp";
		} else {
			User oneUser = userService.findUser((Long) session.getAttribute("userId"));
			Medication thisMedication = medicationService.findOneMedication(id);
			oneMedication.setUsers(thisMedication.getUsers());
			oneMedication.setUser(oneUser);
			medicationService.updateMedication(oneMedication);
			return "redirect:/dashboard";
		}
	}

	// --------- Delete
	@DeleteMapping("/medications/delete/{id}")
	public String deleteProject(@PathVariable("id") Long id, HttpSession session) {
		if (session.getAttribute("userId") == null) {
			System.out.println("***protected");
			return "redirect:/logout";
		}
		medicationService.removeMedication(id);
		System.out.println("***Deleted!");
		return "redirect:/dashboard";
	}

	@GetMapping("/dashboard/take/{id}")
	public String takeMedi(@PathVariable("id") Long id, HttpSession session, Model model) {
		if (session.getAttribute("userId") == null) {
			return "redirect:/logout";
		}
		User oneUser = userService.findUser((Long) session.getAttribute("userId"));
		Medication thisMedication = medicationService.findOneMedication(id);
		oneUser.getMedications().add(thisMedication);
		userService.updateUser(oneUser);

		model.addAttribute("oneUser", oneUser);
		model.addAttribute("unTakenMedications", medicationService.getUntakenMedications(oneUser));
		model.addAttribute("takenMedications", medicationService.getTakenMedications(oneUser));
		return "redirect:/dashboard";
	}

	@GetMapping("/dashboard/undo/{id}")
	public String undeMedi(@PathVariable("id") Long id, HttpSession session, Model model) {
		if (session.getAttribute("userId") == null) {
			return "redirect:/logout";
		}
		User oneUser = userService.findUser((Long) session.getAttribute("userId"));
		Medication thisMedication = medicationService.findOneMedication(id);
		oneUser.getMedications().remove(thisMedication);
		userService.updateUser(oneUser);

		model.addAttribute("oneUser", oneUser);
		model.addAttribute("unTakenMedications", medicationService.getUntakenMedications(oneUser));
		model.addAttribute("takenMedications", medicationService.getTakenMedications(oneUser));
		return "redirect:/dashboard";
	}

	@GetMapping("/medications/search")
	public String searchMed() {
		return "search.jsp";
	}

}
