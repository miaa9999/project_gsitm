package kr.co.homework.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.homework.dto.ConsultDto;
import kr.co.homework.service.ConsultService;

@Controller
@RequestMapping("/cus")
public class ConsultController {
	@Autowired
	ConsultService consultService;
	
	@GetMapping("/cus_management")
	public String cusManagement(Model model) {
		
		List<ConsultDto> listAll = consultService.listAll();
		model.addAttribute("consultList",listAll);
		return "/cus/management_main";
	}
	
	@GetMapping("/consult_list")
	public String consultList(Model model,@RequestParam("custSn")Long custSn) {
		List<ConsultDto> consultList = consultService.consultFindByCustSn(custSn);

		model.addAttribute("consultList",consultList);
		return "/cus/management_main";
	}

}
