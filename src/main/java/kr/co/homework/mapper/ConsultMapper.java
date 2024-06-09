package kr.co.homework.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.co.homework.dto.ConsultDto;

@Mapper
public interface ConsultMapper {

	List<ConsultDto> listAll();

	List<ConsultDto> consultFindByCustSn(@Param("custSn") Long custSn);

}
