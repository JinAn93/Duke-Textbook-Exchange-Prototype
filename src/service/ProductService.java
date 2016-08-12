package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import dao.IProductDao;
import model.Product;

@Service("productService")
@Transactional
public class ProductService implements IProductService {

	@Autowired
	private IProductDao dao;
	
	public Product findById(int id) {
		return dao.findById(id);
	}

	public void saveProduct(Product product) {
		dao.saveProduct(product);
	}

	public void updateProduct(Product product) {
		dao.updateProduct(product);
	}

	public void deleteProductByID(int id) {
		dao.deleteProductById(id);
	}
	
	public void changeStatus(int id, String status) {
		dao.changeStatus(id, status);		
	}

	public List<Product> findAllProducts() {
		return dao.findAllProducts();
	}
	
	public List<Product> findMyProducts(String user_id) {
		return dao.findMyProducts(user_id);
	}

	public List<Product> searchByTitle(String keyword) {
		return dao.searchByTitle(keyword);
	}
	
	public List<Product> sortByColumns(String index) {
		return dao.sortByColumns(index);
	}
}
