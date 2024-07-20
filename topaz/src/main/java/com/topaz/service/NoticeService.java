package com.topaz.service;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.topaz.dto.Notice;
import com.topaz.dto.NoticeRequest;
import com.topaz.dto.UploadFile;
import com.topaz.mapper.NoticeMapper;
import com.topaz.mapper.UploadFileMapper;
import com.topaz.utill.Debug;

import lombok.extern.slf4j.Slf4j;

@Service
@Transactional
@Slf4j
public class NoticeService {
	
	@Autowired NoticeMapper noticeMapper;
	
	@Autowired UploadFileMapper uploadFilemapper;
	
	@Autowired UploadFileService uploadFileService;
	
	/*
	 * 분류 번호: #10 - 공지 사항 삭제
	 * 시작 날짜: 2024-07-07
	 * 담당자: 김지훈
	*/
	
	public int removeNotice(String newsNo) {
		log.debug(Debug.KJH + "/ service / removeNotice newsNo: " + newsNo);
		return noticeMapper.deleteNotice(newsNo);
	}
	/*
	 * 분류 번호: #10 - 공지 사항 수정
	 * 시작 날짜: 2024-07-07
	 * 담당자: 김지훈
	*/
	public int modifyNotice(NoticeRequest noticeRequest) {
		log.debug(Debug.KJH + "/ service / modifyNotice Notice: " + noticeRequest);
		Notice notice = noticeRequest.toNotice();
		return noticeMapper.updateNotice(notice);
	}
	
	/*
	 * 분류 번호: #10 - 공지 사항 추가
	 * 시작 날짜: 2024-07-07
	 * 담당자: 김지훈
	*/
	
	public int addNotice(NoticeRequest noticeRequest) {
		
		// notice 디버깅
		log.debug(Debug.KIS + "/ service / addNotice noticeRequest: " + noticeRequest);
		
		// 파일 업로드 경로
		String imagePath = System.getProperty("user.dir") + "/src/main/resources/static/upload/";
	    
		log.debug(Debug.KIS + "/ service / addNotice noticeRequest: " + imagePath);
		
		// 업로드 파일 확인
	    log.debug(Debug.KIS + "/ service / addNotice uploadFile: " + noticeRequest.getUploadFile());
	    log.debug(Debug.KIS + "/ service / addNotice uploadFile isEmpty: " + noticeRequest.getUploadFile().isEmpty());
		
		// 업로드 파일 처리
		if(!noticeRequest.getUploadFile().isEmpty()) {
			// 파일의 이름을 UUID를 사용하여 설정
			String prefix = UUID.randomUUID().toString().replace("-", "");
			int p = noticeRequest.getUploadFile().getOriginalFilename().lastIndexOf(".");
			String suffix = noticeRequest.getUploadFile().getOriginalFilename().substring(p);
			String fileName = prefix + suffix;
			
			// noticeRequest 객체 생성 및 저장
			noticeRequest.setFileName(fileName);			
			// uploadFile 객체 생성 및 저장
			UploadFile file = noticeRequest.toUploadFile();
			file.setReferenceNo(noticeRequest.getRegId());
			
			file.setFileName(fileName);
			
			log.debug(Debug.KIS + "/ service / addNotice / file: " + file);
			
			int fileRow = uploadFilemapper.insertUploadFile(file);
			
			log.debug(Debug.KIS + "/ service / addNotice / fileRow: " + fileRow);
			
			if (fileRow != 1) {
				throw new RuntimeException("파일 업로드 실패");
			}
			
			File emptyFile = new File(imagePath + fileName);
			try {
				noticeRequest.getUploadFile().transferTo(emptyFile);
			} catch (Exception e) {
				e.printStackTrace();
				throw new RuntimeException();
			}
		}
		
		// 공지 사항 DTO에 데이터 바인딩
		Notice notice = noticeRequest.toNotice();

		// 공지 사항 정보를 저장
		int row = noticeMapper.insertNotice(notice);
		
		 log.debug(Debug.KJH + "/ service / addNotice / row :" + row); 
		
		 return row;
	}
	
	/*
	 * 분류 번호: #10 - 공지 사항 상세 페이지
	 * 시작 날짜: 2024-07-05
	 * 담당자: 김지훈
	*/
	
	public Map<String, Object> getNoticeDetail(String newsNo) {
		
		log.debug(Debug.KJH + "/ service / getNoticeDetail newsNo: " + newsNo);
		Map<String, Object> noticeDetail = noticeMapper.selectNoticeDetail(newsNo);
		return noticeDetail;
	}
	
	
	/*
	 * 분류 번호: #10 - 공지 사항 목록 페이지
	 * 시작 날짜: 2024-07-05
	 * 담당자: 김지훈
	*/
	public Map<String, Object> getNoticeList(Map<String, Object> paramMap) {
		// paramMap 디버깅
		log.debug(Debug.KJH + " / Service / getNoticeList / paramMap: " + paramMap);
		
		// notice의 개수
		int noticeCnt = noticeMapper.noticeCnt(paramMap);
		log.debug(Debug.KIS + " / Service / getNoticeList / noticeCnt : " + noticeCnt);
		
		// 마지막 페이지 계산하기
		int rowPerPage = (int) paramMap.get("rowPerPage");
		int lastPage = (noticeCnt + rowPerPage - 1 ) / rowPerPage;
		log.debug(Debug.KJH + " / Service / getNoticeList / lastPage: " + lastPage);
		
		// 공지 사항 리스트
		List<Map<String, Object>> noticeList = noticeMapper.selectNoticeList(paramMap);
		log.debug(Debug.KJH + " / service / getNoticeList" + noticeList);
		
		// 결과 맵에 담기
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("noticeList", noticeList);
		resultMap.put("lastPage", lastPage);

		return resultMap;
	}
}
