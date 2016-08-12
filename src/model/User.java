package model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotEmpty;

@Entity
@Table(name = "USERS")
public class User {

	@Id
	@Size(min = 3, max = 30)
	@Column(name = "USER_ID", unique = true, nullable = false)
	private String user_id;

	@NotEmpty
	@Size(min = 6, max = 64)
	@Column(name = "PASSWORD", nullable = false) 	
	private String password;

	@NotEmpty
	@Size(max = 50)
	@Column(name = "FIRST_NAME", nullable = false)
	private String first_name;

	@NotEmpty
	@Size(max = 50)
	@Column(name = "LAST_NAME", nullable = false)
	private String last_name;
	
	@NotEmpty
	@Size(max = 254)
	@Column(name = "EMAIL", nullable = false)
	@Email
	private String email;

	@NotEmpty
	@Size(max = 15)
	@Column(name = "PHONE_NUMBER", nullable = false)
	private String phone_number;
	
	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getFirst_name() {
		return first_name;
	}

	public void setFirst_name(String first_name) {
		this.first_name = first_name;
	}

	public String getLast_name() {
		return last_name;
	}

	public void setLast_name(String last_name) {
		this.last_name = last_name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone_number() {
		return phone_number;
	}

	public void setPhone_number(String phone_number) {
		this.phone_number = phone_number;
	}
}