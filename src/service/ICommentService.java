package service;

import java.util.List;

import model.Comment;

public interface ICommentService {

	Comment findById(int id);
	
	void saveComment(Comment comment);
	
	void updateComment(Comment comment);
	
	void deleteCommentByID(int id);
	
	List<Comment> findAllComments();
	
	List<Comment> findByProductId(int product_id);
}
