package model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

@Entity
@Table(name = "COMMENTS")
public class Comment {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int comment_id;

	@ManyToOne(optional = false)
	@JoinColumn(name = "USER_ID")
	private User user;

	@ManyToOne(optional = false)
	@JoinColumn(name = "PRODUCT_ID")
	private Product product;

	@NotNull
	@Size(max = 100)
	@Column(name = "CONTENTS", nullable = false)
	private String contents;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "POST_DATE", nullable = false)
	private Date post_date;

	public Comment() {
		setPost_date(new Date());
	}
	
	public int getComment_id() {
		return comment_id;
	}
	
	public void setComment_id(int comment_id) {
		this.comment_id = comment_id;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public Date getPost_date() {
		return post_date;
	}

	public void setPost_date(Date post_date) {
		this.post_date = post_date;
	}
}