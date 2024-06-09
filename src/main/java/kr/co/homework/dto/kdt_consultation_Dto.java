package kr.co.homework.dto;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class kdt_consultation_Dto {
	private Long consultation_no; // 상담내역 일련번호
	private Long cust_sn; // 고객 일련번호
	private String pic_sn_vl; // 담당자 일련번호
	private String cons_date; // 상담일자
	private String consultation; // 상담내용
}
