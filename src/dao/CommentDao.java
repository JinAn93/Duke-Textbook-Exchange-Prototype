package dao;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import model.Comment;

@Repository("commentDao")
public class CommentDao extends AbstractDao<Integer, Comment> implements ICommentDao {

	public Comment findById(int id) {
		return getByKey(id);
	}

	public void saveComment(Comment comment) {
		persist(comment);
	}

	@SuppressWarnings("unchecked")
	public List<Comment> findAllComments() {
		Criteria criteria = createEntityCriteria();
		return (List<Comment>) criteria.list();
	}

	@SuppressWarnings("unchecked")
	public List<Comment> findByProductId(int product_id) {
		return createEntityCriteria().add(
				Restrictions.eqOrIsNull("product_id", product_id)).list();
	}

	public void deleteCommentById(int comment_id) {
		Query query = getSession().createSQLQuery(
				"delete from Comments where comment_id = :comment_id");
		query.setInteger("comment_id", comment_id);
		query.executeUpdate();
	}
}