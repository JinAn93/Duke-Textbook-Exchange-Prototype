package controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.amazonaws.AmazonClientException;
import com.amazonaws.AmazonServiceException;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3Client;
import com.amazonaws.services.s3.model.CannedAccessControlList;
import com.amazonaws.services.s3.model.PutObjectRequest;
import model.Product;
import service.IProductService;
import service.IUserService;
import utility.SendEmail;

@Controller
@RequestMapping("/")
@SessionAttributes("user_id")
public class DashboardController {

	@Autowired
	IProductService productService;

	@Autowired
	IUserService userService;


	@RequestMapping(value = "/dashboard", method = RequestMethod.GET)
	public String listProducts(ModelMap model) {
		if (model.containsAttribute("user_id")) {
			model.addAttribute("products", productService.findAllProducts());
			model.addAttribute("product", new Product());
			return "dashboard";
		}
		return "redirect:/login";
	}

	@RequestMapping(value = "/dashboard/search-{keyword}", method = RequestMethod.GET)
	public String listSearchedProducts(@PathVariable String keyword, ModelMap model) {
		if (model.containsAttribute("user_id")) {
			model.addAttribute("products" , productService.searchByTitle(keyword));
			model.addAttribute("product", new Product());
			return "dashboard";
		}
		return "redirect:/login";
	}

	@RequestMapping(value = "/newProduct", method = RequestMethod.GET)
	public String newProduct(ModelMap model) {
		if (model.containsAttribute("user_id")) {
			model.addAttribute("product", new Product());
			return "dashboard";
		}
		return "redirect:/login";
	}

	@RequestMapping(value = "/newProduct", method = RequestMethod.POST)
	public String saveProduct(@ModelAttribute("Product") Product product, @RequestParam("file") MultipartFile file, BindingResult resultProduct, ModelMap model) {
		if (resultProduct.hasErrors()) {
			System.out.println("There is an errrrrorrrrr");
			return "redirect:/dashboard";
		}		

		if (!file.isEmpty()) {
			try {
				String path = "/Users/owner/Desktop/workspace/DTE_Storage/";
				// file validation needed
				Files.copy(file.getInputStream(), Paths.get(path, file.getOriginalFilename()));
				uploadImageS3(path, file.getOriginalFilename());
				product.setUser(userService.findById((String) model.get("user_id")));
				product.setImageURL("https://s3.ap-northeast-2.amazonaws.com/duketextbookexchange/" + file.getOriginalFilename());
				System.out.println("test" + product.getName());
				productService.saveProduct(product);
				return "redirect:/dashboard";
			} catch (IOException | RuntimeException e) {
				e.printStackTrace();
			}			
		}
		return "redirect:/dashboard";
	}
	
	@RequestMapping(value = "/editProduct-{product_id}", method = RequestMethod.POST)
	public String editProduct(@ModelAttribute("Product") Product product, @RequestParam("file") MultipartFile file, @PathVariable int product_id, BindingResult resultProduct, ModelMap model) {
		if (resultProduct.hasErrors()) {
			System.out.println("There is an errrrrorrrrr");
			return "redirect:/dashboard";
		}		

		Product Entity = productService.findById(product_id);
		
		try {
			Entity.setName(product.getName());
			Entity.setPrice(product.getPrice());
			Entity.setDescription(product.getDescription());
				
			String path = "TEMP FILE SAVE DIRECTORY";
			// file validation needed
			Files.copy(file.getInputStream(), Paths.get(path, file.getOriginalFilename()));
			uploadImageS3(path, file.getOriginalFilename());
			
			Entity.setUser(userService.findById((String) model.get("user_id")));
			Entity.setImageURL("AMAZON S3 URL" + file.getOriginalFilename());
			System.out.println("test" + product.getName());
			productService.updateProduct(Entity);
			return "redirect:/dashboard";
		} catch (IOException | RuntimeException e) {
			e.printStackTrace();
		}			
		
		return "redirect:/dashboard";
	}

	@RequestMapping(value = "/aboutPage", method = RequestMethod.GET)
	public String aboutPage(ModelMap model) {
		return "aboutPage";
	}

	@RequestMapping(value = { "/edit-{product_id}-product" }, method = RequestMethod.GET)
	public String editProduct(@PathVariable int product_id, ModelMap model) {
		if (model.containsAttribute("user_id")) {
			model.addAttribute("product", productService.findById(product_id));
			model.addAttribute("edit", true);
			return "redirect:/dashboard";
		}
		return "redirect:/login";
	}

	@RequestMapping(value = { "/delete-{product_id}-product" }, method = RequestMethod.GET)
	public String deletePost(@PathVariable int product_id, ModelMap model) {
		if (model.containsAttribute("user_id")) {
			productService.deleteProductByID(product_id);
			return "redirect:/dashboard";
		}
		return "redirect:/login";
	}

	@RequestMapping(value = { "/view-{user_id}-my-products" }, method = RequestMethod.GET)
	public String viewYourProducts(@PathVariable String user_id, ModelMap model) {
		if (model.containsAttribute("user_id")) {
			model.addAttribute("myProducts", productService.findMyProducts(user_id));
			model.addAttribute("product", new Product());
			return "myProducts";
		}
		return "redirect:/login";
	}

	@RequestMapping(value = { "/email-{user_id}-{product_id}" }, method = RequestMethod.GET)
	public String emailToUser(@PathVariable String user_id,
			@PathVariable int product_id, ModelMap model) {
		if (model.containsAttribute("user_id")) {
			String from_email = userService.findById(user_id).getEmail();
			String to_email = productService.findById(product_id).getUser().getEmail();
			String product_name = productService.findById(product_id).getName();

			try {
				SendEmail.generateAndSendEmail(from_email, to_email,
						product_name);
				return "redirect:/dashboard";
			} catch (AddressException e) {
				System.out.println("Address Exception");
			} catch (MessagingException e) {
				System.out.println("Messaging Exception");
			}
		}
		return "redirect:/login";
	}

	@RequestMapping(value = { "/update" }, method = RequestMethod.POST, consumes = "application/json")
	public @ResponseBody
	String updateStatus(@RequestBody String obj, ModelMap model) {
		if (model.containsAttribute("user_id")) {
			try {
				JSONParser parser = new JSONParser();
				JSONObject json = (JSONObject) parser.parse(obj);

				int product_id = ((Long) json.get("id")).intValue();
				String status = (String) json.get("status");

				productService.changeStatus(product_id, status);

				return "{\"success\":1}";
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return "redirect:/login";
	}

	public void uploadImageS3(String directory_path, String filename) {
		// Security risk
		BasicAWSCredentials basicAWSCredentials=new BasicAWSCredentials("access","secret");
		AmazonS3 s3Client = new AmazonS3Client(basicAWSCredentials);
		try {
			System.out.println("Uploading a new object to S3 from a file\n");
			File file_ = new File(directory_path + filename);
			s3Client.putObject(new PutObjectRequest("BUCKET NAME", filename, file_).withCannedAcl(CannedAccessControlList.PublicRead));
			System.out.println("success");
			file_.delete();
		} catch (AmazonServiceException ase) {
			System.out.println("Caught an AmazonServiceException, which "
					+ "means your request made it "
					+ "to Amazon S3, but was rejected with an error response"
					+ " for some reason.");
			System.out.println("Error Message:    " + ase.getMessage());
			System.out.println("HTTP Status Code: " + ase.getStatusCode());
			System.out.println("AWS Error Code:   " + ase.getErrorCode());
			System.out.println("Error Type:       " + ase.getErrorType());
			System.out.println("Request ID:       " + ase.getRequestId());
		} catch (AmazonClientException ace) {
			System.out.println("Caught an AmazonClientException, which "
					+ "means the client encountered "
					+ "an internal error while trying to "
					+ "communicate with S3, "
					+ "such as not being able to access the network.");
			System.out.println("Error Message: " + ace.getMessage());
		}
	}
}
