package kr.co.homework.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.co.homework.dto.kdt_consultation_Dto;
import kr.co.homework.dto.kdt_cust_info_basc_Dto;
import kr.co.homework.dto.kdt_pic_info_basc_Dto;

@Mapper
public interface CustomerMapper {

	List<Map<String, Object>> search(@Param("keyword") String keyword);

	void deleteCustomer(@Param("cust_sn") Long cust_sn);

	void deleteCustomerConsultations(@Param("cust_sn") Long cust_sn);

	List<Map<String, Object>> getAllCustomers();

	Map<String, Object> getCustomerDetail(@Param("cust_sn") Long cust_sn);

	void updateCustomer(@Param("customerDto") kdt_cust_info_basc_Dto customerDto);

	List<kdt_pic_info_basc_Dto> searchPicName(@Param("new_pic_name") String new_pic_name);

	void updatePicInfo(@Param("customerDto") kdt_cust_info_basc_Dto customerDto);

	List<kdt_consultation_Dto> consultFindByCustSn(@Param("cust_sn")Long cust_sn);



}
