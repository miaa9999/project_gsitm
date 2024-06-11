package kr.co.homework.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sun.org.apache.regexp.internal.recompile;

import kr.co.homework.dto.kdt_consultation_Dto;
import kr.co.homework.dto.kdt_cust_info_basc_Dto;
import kr.co.homework.dto.kdt_pic_info_basc_Dto;
import kr.co.homework.mapper.CustomerMapper;

@Service
public class CustomerService {
	@Autowired
	CustomerMapper mapper;

	public List<Map<String, Object>> search(String keyword) {
		return mapper.search(keyword);
	}

	public void deleteCustomer(Long cust_sn) {
		// 일단 상담내역 지우고 -> 고객 정보 삭제
		mapper.deleteCustomerConsultations(cust_sn);
		mapper.deleteCustomer(cust_sn);
	}

	public List<Map<String, Object>> getAllCustomers() {
		return mapper.getAllCustomers();
	}

	public Map<String, Object> getCustomerDetail(Long cust_sn) {
		return mapper.getCustomerDetail(cust_sn);
	}

	public void updateCustomer(kdt_cust_info_basc_Dto customerDto) {
		mapper.updateCustomer(customerDto);
		
	}

	public List<kdt_pic_info_basc_Dto> searchPicName(String new_pic_name) {
		return mapper.searchPicName(new_pic_name);
	}

	public void updatePicInfo(kdt_cust_info_basc_Dto customerDto) {
		mapper.updatePicInfo(customerDto);
		
	}

	public List<kdt_consultation_Dto> consultFindByCustSn(Long cust_sn) {
		return mapper.consultFindByCustSn(cust_sn);
	}

	public int addCustomer(kdt_cust_info_basc_Dto customerDto) {
		return mapper.addCustomer(customerDto);
	}





	

	

}
