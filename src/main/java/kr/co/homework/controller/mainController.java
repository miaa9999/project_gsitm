package kr.co.homework.controller;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.homework.dto.kdt_consultation_Dto;
import kr.co.homework.dto.kdt_cust_info_basc_Dto;
import kr.co.homework.dto.kdt_pic_info_basc_Dto;
import kr.co.homework.service.CustomerService;

@Controller
public class mainController {

	@Autowired
	CustomerService customerService;

	@GetMapping("/main")
	public String TestMain() {
		return "/mainPage";
	}

	@GetMapping("customerInfoPage")
	public String customerInfoPage() {
		return "customer/customerInfoPage";
	}

	//  검색(이름으로만 검색)

	@GetMapping("customer/searchCustomerConfirm")
	public String searchCustomerConfirm(@RequestParam("keyword") String keyword, Model model) {
		List<Map<String, Object>> customerList = customerService.search(keyword);
		model.addAttribute("customerList", customerList);
		return "customer/customerInfoPage";
	}

	// 전체검색
	@GetMapping("customer/allCustomers")
	public String getAllCustomers(Model model) {
		List<Map<String, Object>> customerList = customerService.getAllCustomers();
		model.addAttribute("customerList", customerList);
		return "customer/customerInfoPage";
	}

	@GetMapping("customer/detail/{cust_sn}")
	public String getCustomerDetail(@PathVariable("cust_sn") Long cust_sn, Model model) {
		// 고객 상세 정보 조회 메서드 호출
		Map<String, Object> customerDetail = customerService.getCustomerDetail(cust_sn);
		List<kdt_consultation_Dto> consultList = customerService.consultFindByCustSn(cust_sn);
		System.out.println(consultList);
		// 상담내역 조회하기
		model.addAttribute("consultList", consultList);
		// 조회된 고객 정보를 모델에 추가
		model.addAttribute("customer", customerDetail);

		return "customer/customerInfoPage";
	}

	// 고객정보 변경
	@PostMapping("customer/updateCustomerInfo")
	public String updateCustomerInfo(kdt_cust_info_basc_Dto customerDto, RedirectAttributes redirectAttributes) {
		customerService.updateCustomer(customerDto);
		redirectAttributes.addFlashAttribute("message", "[고객] 정보가 성공적으로 업데이트되었습니다.");
		return "redirect:/customer/detail/" + customerDto.getCust_sn();
	}

	// 관리자 정보 변경
	@PostMapping("customer/updatePicInfo")
	public String updatePicInfo(kdt_cust_info_basc_Dto customerDto, RedirectAttributes redirectAttributes) {
		customerService.updatePicInfo(customerDto);
		redirectAttributes.addFlashAttribute("message", "[관리자] 정보가 성공적으로 업데이트되었습니다.");
		return "redirect:/customer/detail/" + customerDto.getCust_sn();
	}

	@GetMapping("customer/delete/{cust_sn}")
	public String deleteCustomer(@PathVariable("cust_sn") Long cust_sn) {
		// 고객 정보를 삭제
		customerService.deleteCustomer(cust_sn);
		return "/mainPage";
	}

	// 관리자 신규 등록
	@PostMapping("customer/addCustomer")
	public String addCustomer(@RequestParam("new_cust_nm") String new_cust_nm,
			@RequestParam("new_pridtf_no") String new_pridtf_no, @RequestParam("new_eml_addr") String new_eml_addr,
			@RequestParam("new_home_telno") String new_home_telno, @RequestParam("new_mbl_telno") String new_mbl_telno,

			@RequestParam("new_cr_nm") String new_cr_nm, @RequestParam("new_road_nm_addr") String new_road_nm_addr) {

		kdt_cust_info_basc_Dto customerDto = new kdt_cust_info_basc_Dto();
		customerDto.setCust_nm(new_cust_nm);
		customerDto.setPridtf_no(new_pridtf_no);
		customerDto.setEml_addr(new_eml_addr);
		customerDto.setHome_telno(new_home_telno);
		customerDto.setMbl_telno(new_mbl_telno);
		customerDto.setCr_nm(new_cr_nm);
		customerDto.setRoad_nm_addr(new_road_nm_addr);

		System.out.println(customerDto.getBrdt());
		// System.out.println("등독된 새 사용자: " + customerDto.toString());
		customerService.addCustomer(customerDto);
		return "redirect:/customerInfoPage";
	}

}
