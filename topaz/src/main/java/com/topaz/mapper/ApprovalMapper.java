package com.topaz.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.topaz.dto.ApprovalTemplate;

@Mapper
public interface ApprovalMapper {
	/*  분류 번호: #11 - 결재 리스트 - 페이징 */
	int approvalListCnt();
	/*  분류 번호: #11 - 결재 사항 목록 */
	List<Map<String, Object>> selectApprovalHistory(Map<String, Object> paramMap);
	
	/*  분류 번호: #11 - 템플릿 상세 보기  */
	Map<String, Object> selectTemplateDetail(String templateNo);

	/*  분류 번호: #11 - 템플릿 등록 */
	int insertTemplate(ApprovalTemplate appTemlplate);
	
	/*  분류 번호: #11 - 템플릿 리스트 */
	List<Map<String, Object>> selectTemplateList(Map<String, Object> paramMap);
}
