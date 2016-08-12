package dao;

import java.util.List;

import model.Product;

public interface IProductDao {

	/**
	 * Identifies Product by id number
	 * @param id
	 * @return
	 */
	Product findById(int id);
	
	/**
	 * Saves product information to database by receiving product object
	 * @param product
	 */
	void saveProduct(Product product);
	
	/**
	 * Update product information
	 * @param product
	 */
	void updateProduct(Product product);
	/** 
	 * Find all products in products table
	 * @return
	 */
	List<Product> findAllProducts();
	
	/**
	 * Identify and delete product by id
	 * @param id
	 */
	void deleteProductById(int id);
	
	/**
	 * Returns all products registered by the logged in user
	 * @param user_id
	 * @return
	 */
	List<Product> findMyProducts(String user_id);
	
	/**
	 * Returns a list of product where its title contains the keyword
	 * @param keyword
	 * @return
	 */
	List<Product> searchByTitle(String keyword);
	
	/**
	 * Change status (SELLING or SOLD) of the product of particular id
	 * @param id
	 * @param status
	 */
	void changeStatus(int id, String status);
	
	/**
	 * sort product entries by retrieved column (price, post_date, etc)
	 * @param column
	 * @return
	 */
	List<Product> sortByColumns(String index);
}
