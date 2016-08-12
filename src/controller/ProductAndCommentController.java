package controller;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;

import model.Comment;
import model.Product;
import service.ICommentService;
import service.IProductService;
import service.IUserService;

@Controller
@RequestMapping("/")
@SessionAttributes("user_id")
public class ProductAndCommentController {

	@Autowired
	IProductService productService;
	
	@Autowired
	ICommentService commentService;
	
	@Autowired
	IUserService userService;
	
	private Product myCurrentlyWorkingProduct;
	private boolean myActionStatus;
	
	private static final boolean VIEW_PRODUCT_STATUS = false;
	private static final boolean EDIT_COMMENT_STATUS = true;
	
	@RequestMapping(value = { "/view-{product_id}-product" }, method = RequestMethod.GET)
	public String viewProduct(@PathVariable int product_id, ModelMap model) {
		if (model.containsAttribute("user_id")) {
			myCurrentlyWorkingProduct = productService.findById(product_id);
			myActionStatus = VIEW_PRODUCT_STATUS;
			return "redirect:/detailedProduct";
		}
		return "redirect:/login";
	}

	@RequestMapping(value = { "/edit-{product_id}-{comment_id}-comment" }, method = RequestMethod.GET)
	public String editComment(@PathVariable int product_id, @PathVariable int comment_id, ModelMap model) {
		if (model.containsAttribute("user_id")) {
			model.addAttribute("editComment", commentService.findById(comment_id));
			myActionStatus = EDIT_COMMENT_STATUS;
			return "redirect:/detailedProduct";
		}
		return "redirect:/login";
	}

	@RequestMapping(value = { "/delete-{product_id}-{comment_id}-comment" }, method = RequestMethod.GET)
	public String deleteComment(@PathVariable int product_id, @PathVariable int comment_id, ModelMap model) {
		if (model.containsAttribute("user_id")) {
			commentService.deleteCommentByID(comment_id);
			return "redirect:/detailedProduct";
		}
		return "redirect:/login";
	}

	@RequestMapping(value = { "/detailedProduct" }, method = { RequestMethod.GET })
	public String redirectToDetailedProdut(ModelMap model) {
		if (model.containsAttribute("user_id"))
			return detailedProductSetup(model);
		return "redirect:/login";
	}

	@RequestMapping(value = { "/detailedProduct" }, method = RequestMethod.POST)
	public String saveReply(@Valid Comment comment, BindingResult result, ModelMap model) {
		if (model.containsAttribute("user_id")) {
			if (result.hasErrors()) {
				return "detailedProduct";
			}
			
			comment.setUser(userService.findById((String) model.get("user_id")));
			comment.setProduct(myCurrentlyWorkingProduct);
			
			if (myActionStatus == EDIT_COMMENT_STATUS)
				commentService.updateComment(comment);
			else
				commentService.saveComment(comment);
		
			model.addAttribute("comments", commentService.findAllComments());
			model.addAttribute("product", myCurrentlyWorkingProduct);
			return "redirect:/detailedProduct";
		}
		return "redirect:/login";
	}
	
	private String detailedProductSetup(ModelMap model){
		model.addAttribute("product", myCurrentlyWorkingProduct);
		model.addAttribute("comments", commentService.findAllComments());
		model.addAttribute("comment", new Comment());
		model.addAttribute("editComment", new Comment());
		model.addAttribute("editCommentPressed", myActionStatus);
		return "detailedProduct";
	}
}
