package org.zerock.mapper;

import java.util.List;
import java.util.stream.IntStream;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = { org.zerock.config.RootConfig.class })
@Log4j
public class ReplyMapperTests {
	
	@Setter(onMethod_ = { @Autowired })
	private ReplyMapper mapper;

	private Long[] bnoArr = { 59L, 69L, 85L, 91L, 93L };

//	@Test
	public void testCreate() {
		IntStream.rangeClosed(1, 10).forEach(i -> {
			ReplyVO vo = new ReplyVO();
			vo.setBno(bnoArr[i % 5]);
			vo.setReply("댓글 테스트 " + i);
			vo.setReplyer("replyer" + i);
			mapper.insert(vo);
		});
	}

//	@Test
	public void testRead() {
		Long targetRno = 10L;
		ReplyVO vo = mapper.read(targetRno);
		log.info(vo);
	}

//	@Test
	public void testDelete() {
		Long targetRno = 10L;
		mapper.delete(targetRno);
		log.info("-------------DELETE reply--------------");
	}

//	@Test
	public void testUpdate() {
		Long targetRno = 15L;
		ReplyVO vo = mapper.read(targetRno);
		vo.setReply("UPDATE REPLY");
		int count = mapper.update(vo);
		log.info("-------------UPDATE COUNT -------------- " + count);
	}
	
	@Test
	public void testList() {
		Criteria cri = new Criteria();
		List<ReplyVO> replies = mapper.getListWithPaging(cri, bnoArr[0]);
		replies.forEach(reply->log.info(reply));
	}

//	@Test
	public void testMapper() {
		log.info(mapper);
	}
}
