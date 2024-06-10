package kr.co.homework.dto;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class kdt_pic_info_basc_Dto {
	private String pic_sn_vl;  //관리자 일렬번호
	private String pic_name;   //관리자 이름
 	private String tkcg_dept_nm;  //담당부서명
	private String pic_phone;  //관리자 전화번호
	private String pic_position; //관리자 직위

}
