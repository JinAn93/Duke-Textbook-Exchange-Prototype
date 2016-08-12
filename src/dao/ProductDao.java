package dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.springframework.stereotype.Repository;

import model.Product;

@Repository("productDao")
public class ProductDao extends AbstractDao<Integer, Product> implements IProductDao {

	public Product findById(int id) {
		return getByKey(id);
	}

	public void saveProduct(Product product) {
		persist(product);
	}
	
	public void updateProduct(Product product) {
		update(product);
	}

	@SuppressWarnings("unchecked")
	public List<Product> findAllProducts() {
		Criteria criteria = createEntityCriteria();
		return (List<Product>) criteria.list();
	}

	public void deleteProductById(int product_id) {
		Query query = getSession().createSQLQuery("delete from Products where product_id = :product_id");
		query.setInteger("product_id", product_id)
			 .executeUpdate();
	}
	
	@SuppressWarnings("unchecked")
	public List<Product> findMyProducts(String user_id) {
		SQLQuery query = getSession().createSQLQuery("select * from Products where user_id = :user_id");
		query.addEntity(Product.class)
			 .setString("user_id", user_id);
		return (List<Product>) query.list();
	}

	@SuppressWarnings("unchecked")
	public List<Product> searchByTitle(String keyword) {
		SQLQuery query = getSession().createSQLQuery("select * from Products where name like '%" + keyword + "%'");
		query.addEntity(Product.class);		
		return (List<Product>) query.list();
	}
	
	public void changeStatus(int product_id, String status) {
		Query query = getSession().createSQLQuery("update Products set status = :status where product_id = :product_id");
		query.setInteger("product_id",  product_id)
			 .setString("status",  status)
			 .executeUpdate();
	}
	
	@SuppressWarnings("unchecked")
	public List<Product> sortByColumns(String index){
		SQLQuery query = (index.equals("ASC")? getSession().createSQLQuery("select * from Products ORDER BY name ASC")
											 : getSession().createSQLQuery("select * from Products ORDER BY name DESC"));
		query.addEntity(Product.class);				 
		return (List<Product>) query.list();
	}
}
