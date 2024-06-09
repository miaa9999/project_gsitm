package kr.co.homework.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.homework.dto.ConsultDto;
import kr.co.homework.mapper.ConsultMapper;

@Service
public class ConsultService {
	@Autowired
	ConsultMapper consultMapper;
	
	public List<ConsultDto> listAll() {
		return consultMapper.listAll();
	}


	public List<ConsultDto> consultFindByCustSn(Long custSn) {
		
		return consultMapper.consultFindByCustSn(custSn);
	}

}
