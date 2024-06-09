package kr.co.homework.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ConsultDto {
	private Long consultation_no;
	private Long cust_sn;
	private String pic_sn_vl;
	private String cons_date;
	private String consultation;
	
}
