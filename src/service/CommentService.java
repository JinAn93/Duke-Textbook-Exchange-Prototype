package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import dao.ICommentDao;
import model.Comment;

@Service("commentService")
@Transactional
public class CommentService implements ICommentService {

	@Autowired
	private ICommentDao dao;
	
	public Comment findById(int id) {
		return dao.findById(id);
	}

	public void saveComment(Comment comment) {
		dao.saveComment(comment);
	}

	public void updateComment(Comment comment) {
		Comment entity = dao.findById(comment.getComment_id());
		if(entity != null){
			entity.setContents(comment.getContents());
			entity.setPost_date(comment.getPost_date());
		}
	}

	public void deleteCommentByID(int id) {
		dao.deleteCommentById(id);
	}

	public List<Comment> findAllComments() {
		return dao.findAllComments();
	}

	public List<Comment> findByProductId(int product_id) {
		return dao.findByProductId(product_id);
	}
}
