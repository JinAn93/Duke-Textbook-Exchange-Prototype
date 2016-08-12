package service;

import java.util.List;

import model.Product;

public interface IProductService {

	Product findById(int id);

	void saveProduct(Product product);

	void updateProduct(Product product);

	void deleteProductByID(int id);
	
	void changeStatus(int id, String status);

	List<Product> findAllProducts();	
	
	List<Product> findMyProducts(String user_id);
	
	List<Product> searchByTitle(String keyword);
	
	List<Product> sortByColumns(String index);
}
