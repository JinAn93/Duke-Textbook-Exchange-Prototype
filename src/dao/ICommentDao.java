package dao;

import java.util.List;

import model.Comment;

/**
 * Data Access Object (DAO) for comment
 * 
 * @author Jin An
 *
 */
public interface ICommentDao {

	/**
	 * Identifies a comment by id (primary key)
	 * @param id
	 * @return
	 */
	Comment findById (int id);
	
	/**
	 * Saves comment to database 
	 * @param comment
	 */
	void saveComment (Comment comment);
	
	/**
	 * Finds all the replies from database
	 * @return
	 */
	List<Comment> findAllComments();
	
	/**
	 * Find all the relevant replies under same product_id from database
	 * @param product_id
	 * @return
	 */
	List<Comment> findByProductId (int product_id);
	
	/**
	 * Deletes comment by looking up the id from database
	 * @param id
	 */
	void deleteCommentById (int id);
}
