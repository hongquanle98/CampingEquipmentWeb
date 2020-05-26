package camping.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.concurrent.TimeUnit;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.mail.internet.MimeMessage;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import camping.entity.*;

@Transactional
@Controller
public class MenuController {
	@Autowired
	SessionFactory factory;
	@Autowired
	ServletContext context;
	@Autowired
	JavaMailSender mailer;

	User userLogin = null;
	User adminLogin = null;
	Cart cartUser = null;

	Integer cId, pId, pNum;
	String baseURL;
	String adminBaseURL;

	@ModelAttribute("baseURL")
	public String getBaseURL() {
		return baseURL;
	}
//	@ModelAttribute("adminBaseURL")
//	public String getAdminBaseURL() {
//		return adminBaseURL;
//	}

	@ModelAttribute("adminLogin")
	public User getAdminLogin() {
		return adminLogin;
	}

	@ModelAttribute("userLogin")
	public User getUserLogin() {
		return userLogin;
	}

	@ModelAttribute("users")
	public List<User> getUsers() {
		Session session = factory.getCurrentSession();
		String hql = "FROM User";
		Query query = session.createQuery(hql);
		List<User> list = query.list();
		return list;
	}

	@ModelAttribute("categories")
	public List<Category> getCategories() {
		Session session = factory.getCurrentSession();
		String hql = "FROM Category WHERE display = true ORDER BY cateName";
		Query query = session.createQuery(hql);
		List<Category> list = query.list();
		return list;
	}

	@ModelAttribute("allCategories")
	public List<Category> getAllCategories() {
		Session session = factory.getCurrentSession();
		String hql = "FROM Category ORDER BY cateName";
		Query query = session.createQuery(hql);
		List<Category> list = query.list();
		return list;
	}

	@ModelAttribute("allProducts")
	public List<Product> getAllProducts() {
		Session session = factory.getCurrentSession();
		String hql = "FROM Product ORDER BY name";
		Query query = session.createQuery(hql);
		List<Product> list = query.list();
		return list;
	}

	@ModelAttribute("products")
	public List<Product> getNewProducts() {
		Session session = factory.getCurrentSession();
		String hql = "FROM Product WHERE display = true AND category.display = true ORDER BY id DESC";
		Query query = session.createQuery(hql);
		List<Product> list = query.list();
		return list;
	}

	@ModelAttribute("recommendPros")
	public List<Product> getRecommendProducts() {
		Session session = factory.getCurrentSession();
		String hql = "FROM Product WHERE display = true AND category.display = true";
		Query query = session.createQuery(hql);
		List<Product> list = query.list();
		Collections.shuffle(list);
		return list;
	}

	@ModelAttribute("featurePros")
	public List<CartItem> getFeatureProducts() {
		Session session = factory.getCurrentSession();
		String hql = "FROM CartItem WHERE quantity >= 10 AND product.display = true AND product.category.display = true ORDER BY quantity DESC";
		Query query = session.createQuery(hql);
		List<CartItem> list = query.list();
		return list;
	}

	public List<Cart> getOrder(Integer userId) {
		Session session = factory.openSession();
		Transaction transaction = null;
		try {
			transaction = session.beginTransaction();
			Query query = session
					.createQuery("FROM Cart WHERE user.id = :userId AND buyDate is not null AND status is not null");
			query.setInteger("userId", userId);
			List<Cart> list = query.list();
			Collections.reverse(list);
			transaction.commit();
			return list;
		} catch (Exception ex) {
			if (transaction != null) {
				System.out.println(ex.toString());
				transaction.rollback();
			}
			ex.printStackTrace();
		} finally {
			session.flush();
			session.close();
		}
		return null;
	}

	public Cart getCart(Integer userId) {
		Session session = factory.openSession();
		Transaction transaction = null;
		try {
			transaction = session.beginTransaction();
			Query query = session.createQuery("FROM Cart WHERE user.id = :userId AND buyDate is null");
			query.setInteger("userId", userId);
			Cart obj = (Cart) query.uniqueResult();
			transaction.commit();
			return obj;
		} catch (Exception ex) {
			if (transaction != null) {
				System.out.println(ex.toString());
				transaction.rollback();
			}
			ex.printStackTrace();
		} finally {
			session.flush();
			session.close();
		}
		return null;
	}

	public Long getTotalCartItem(Integer cartId) {
		Session session = factory.openSession();
		Transaction transaction = null;
		try {
			transaction = session.beginTransaction();
			Query query = session.createQuery("SELECT count(*) FROM CartItem WHERE cart.id = :cartId");
			query.setInteger("cartId", cartId);
			Long total = (Long) query.uniqueResult();
			transaction.commit();
			return total;
		} catch (Exception ex) {
			if (transaction != null) {
				System.out.println(ex.toString());
				transaction.rollback();
			}
			ex.printStackTrace();
		} finally {
			session.flush();
			session.close();
		}
		return null;
	}

	public Double getTotalPriceCart(Integer cartId) {
		Session session = factory.openSession();
		Transaction transaction = null;
		try {
			transaction = session.beginTransaction();
			Query query = session.createQuery("SELECT SUM(unitPrice * quantity) FROM CartItem WHERE cart.id = :cartId");
			query.setInteger("cartId", cartId);
			Double total = (Double) query.uniqueResult();
			transaction.commit();
			return total;
		} catch (Exception ex) {
			if (transaction != null) {
				System.out.println(ex.toString());
				transaction.rollback();
			}
			ex.printStackTrace();
		} finally {
			session.flush();
			session.close();
		}
		return null;
	}

	public List<Product> getSimilarPro(Integer cateId, Product pro) {
		Session session = factory.openSession();
		Transaction transaction = null;
		try {
			transaction = session.beginTransaction();
			Query query = session.createQuery(
					"FROM Product WHERE category.cateId = :cateId AND display = true AND category.display = true");
			query.setInteger("cateId", cateId);
			List<Product> list = query.list();

			for (int i = 0; i < list.size(); i++) {
				if (list.get(i).getId() == pro.getId()) {
					list.remove(i);
				}
			}
			transaction.commit();
			return list;
		} catch (Exception ex) {
			if (transaction != null) {
				System.out.println(ex.toString());
				transaction.rollback();
			}
			ex.printStackTrace();
		} finally {
			session.flush();
			session.close();
		}
		return null;
	}

	public List<CartItem> getCartItems(Integer cartId) {
		Session session = factory.openSession();
		Transaction transaction = null;
		try {
			transaction = session.beginTransaction();
			Query query = session.createQuery("FROM CartItem WHERE cart.id = :cartId");
			query.setInteger("cartId", cartId);
			List<CartItem> list = query.list();
			transaction.commit();
			return list;
		} catch (Exception ex) {
			if (transaction != null) {
				System.out.println(ex.toString());
				transaction.rollback();
			}
			ex.printStackTrace();
		} finally {
			session.flush();
			session.close();
		}
		return null;
	}

	@ResponseBody
	@RequestMapping(value = "addCartItem", method = RequestMethod.GET)
	public ModelAndView addCartItem(ModelMap model, @ModelAttribute("cartItem") CartItem ci) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			CartItem ci_temp = checkExistCartItem(cartUser.getId(), ci.getProduct().getId());
			if (ci_temp != null) {
				ci_temp.setQuantity(ci_temp.getQuantity() + ci.getQuantity());
				session.merge(ci_temp);
				t.commit();
			} else {
				session.save(ci);
				t.commit();
			}
		} catch (Exception e) {
			System.out.println(e.toString());
			t.rollback();
		} finally {
			session.flush();
			session.close();
		}
//		model.addAttribute("totalItem", getTotalCartItem(cartUser.getId()));
//		model.addAttribute("totalPrice", getTotalPriceCart(cartUser.getId()));
//		model.addAttribute("listCartItem", getCartItems(cartUser.getId()));

		if (baseURL.equals("category")) {

			return new ModelAndView("redirect:/category/" + cId + "/" + pNum + ".html");
		}
		if (baseURL.equals("shop")) {
			return new ModelAndView("redirect:/shop/" + pNum + ".html");
		}
		if (baseURL.equals("single")) {
			return new ModelAndView("redirect:/single/" + pId + ".html");
		}
		if (baseURL.equals("checkout")) {
			return new ModelAndView("redirect:/checkout.html");
		}
		if (baseURL.equals("payment")) {
			return new ModelAndView("redirect:/payment.html");
		}
		if (baseURL.equals("order")) {
			return new ModelAndView("redirect:/order.html");
		} else {
			return new ModelAndView("redirect:/index.html");
		}
	}

	@ResponseBody
	@RequestMapping(value = "deleteCartItem", method = RequestMethod.GET)
	public ModelAndView deleteCartItem(ModelMap model, @RequestParam("id") Integer id) {
		Session session = factory.openSession();
		CartItem ci = (CartItem) session.get(CartItem.class, id);
		Transaction t = session.beginTransaction();
		try {
			session.delete(ci);
			t.commit();
		} catch (Exception e) {
			System.out.println(e.toString());
			t.rollback();
		} finally {
			session.close();
		}

		if (baseURL.equals("category")) {
			return new ModelAndView("redirect:/category/" + cId + "/" + pNum + ".html");
		}
		if (baseURL.equals("shop")) {
			return new ModelAndView("redirect:/shop/" + pNum + ".html");
		}
		if (baseURL.equals("single")) {
			return new ModelAndView("redirect:/single/" + pId + ".html");
		}
		if (baseURL.equals("checkout")) {
			return new ModelAndView("redirect:/checkout.html");
		}
		if (baseURL.equals("payment")) {
			return new ModelAndView("redirect:/payment.html");
		}
		if (baseURL.equals("order")) {
			return new ModelAndView("redirect:/order.html");
		} else {
			return new ModelAndView("redirect:/index.html");
		}
	}

	@RequestMapping(value = "index", method = RequestMethod.GET)
	public String showIndex(ModelMap model) {
		baseURL = "index";

		// model.addAttribute("baseURL", baseURL);

		model.addAttribute("cartItem", new CartItem());
		// model.addAttribute("userLogin", userLogin);

		if (userLogin != null) {
			model.addAttribute("orders", getOrder(userLogin.getId()));
			Cart cart = getCart(userLogin.getId());
			if (cart == null) {

			} else {
				cartUser = cart;
				model.addAttribute("cart", cart);
				List<CartItem> list = getCartItems(cart.getId());
				if (list == null) {

				} else {
					model.addAttribute("totalItem", getTotalCartItem(cart.getId()));
					model.addAttribute("totalPrice", getTotalPriceCart(cart.getId()));
					model.addAttribute("listCartItem", list);
				}
			}
		}

		return "user/index";
	}

	public boolean existUserName(String uname) {
		Session session = factory.openSession();
		Transaction transaction = null;
		try {
			transaction = session.beginTransaction();
			Query query = session.createQuery("SELECT COUNT(*) FROM User WHERE username = :uname");
			query.setString("uname", uname);
			Long obj = (Long) query.uniqueResult();
			transaction.commit();
			if (obj > 0) {
				return true;
			}
		} catch (Exception ex) {
			if (transaction != null) {
				System.out.println(ex.toString());
				transaction.rollback();
			}
			ex.printStackTrace();
		} finally {
			session.flush();
			session.close();
		}
		return false;
	}

	public boolean existEmail(String email) {
		Session session = factory.openSession();
		Transaction transaction = null;
		try {
			transaction = session.beginTransaction();
			Query query = session.createQuery("SELECT COUNT(*) FROM User WHERE email = :email");
			query.setString("email", email);
			Long obj = (Long) query.uniqueResult();
			transaction.commit();
			if (obj > 0) {
				return true;
			}
		} catch (Exception ex) {
			if (transaction != null) {
				System.out.println(ex.toString());
				transaction.rollback();
			}
			ex.printStackTrace();
		} finally {
			session.flush();
			session.close();
		}
		return false;
	}

	public boolean duplicateEmail(Integer userId, String email) {
		Session session = factory.openSession();
		Transaction transaction = null;
		try {
			transaction = session.beginTransaction();
			Query query = session.createQuery("SELECT COUNT(*) FROM User WHERE id != :userId AND email = :email");
			query.setInteger("userId", userId);
			query.setString("email", email);
			Long obj = (Long) query.uniqueResult();
			transaction.commit();
			if (obj > 0) {
				return true;
			}
		} catch (Exception ex) {
			if (transaction != null) {
				System.out.println(ex.toString());
				transaction.rollback();
			}
			ex.printStackTrace();
		} finally {
			session.flush();
			session.close();
		}
		return false;
	}

	public Integer getUserIdFromEmail(String email) {
		Session session = factory.openSession();
		Transaction transaction = null;
		try {
			transaction = session.beginTransaction();
			Query query = session.createQuery("SELECT id FROM User WHERE email = :email");
			query.setString("email", email);
			Integer obj = (Integer) query.uniqueResult();
			transaction.commit();
			return obj;
		} catch (Exception ex) {
			if (transaction != null) {
				System.out.println(ex.toString());
				transaction.rollback();
			}
			ex.printStackTrace();
		} finally {
			session.flush();
			session.close();
		}
		return null;
	}

	public User login(String uname, String passwd) {
		Session session = factory.openSession();
		Transaction transaction = null;
		try {
			transaction = session.beginTransaction();
			Query query = session
					.createQuery("FROM User WHERE password = :passwd AND (username = :uname OR email = :uname)");
			query.setString("uname", uname);
			query.setString("passwd", passwd);
			User obj = (User) query.uniqueResult();
			transaction.commit();
			return obj;
		} catch (Exception ex) {
			if (transaction != null) {
				System.out.println(ex.toString());
				transaction.rollback();
			}
			ex.printStackTrace();
		} finally {
			session.flush();
			session.close();
		}
		return null;
	}

	// function to generate a random string of length n
	public String getAlphaNumericString(int n) {

		// chose a Character random from this String
		String AlphaNumericString = "ABCDEFGHIJKLMNOPQRSTUVWXYZ" + "0123456789" + "abcdefghijklmnopqrstuvxyz";

		// create StringBuffer size of AlphaNumericString
		StringBuilder sb = new StringBuilder(n);

		for (int i = 0; i < n; i++) {

			// generate a random number between
			// 0 to AlphaNumericString variable length
			int index = (int) (AlphaNumericString.length() * Math.random());

			// add Character one by one in end of sb
			sb.append(AlphaNumericString.charAt(index));
		}

		return sb.toString();
	}

	@RequestMapping(value = "signout", method = RequestMethod.GET)
	public String signOut(ModelMap model) {
		userLogin = null;
		return "redirect:/index.html";
	}

	@RequestMapping(value = "forgetPass", method = RequestMethod.GET)
	public String forgetPassForm(ModelMap model) {
		return "user/forgetPass";
	}

	@RequestMapping(value = "forgetPass", method = RequestMethod.POST)
	public String forgetPass(ModelMap model, @RequestParam("email") String email) {
		if (!existEmail(email)) {
			model.addAttribute("mess0", "Email không tồn tại!");
		} else {
			try {
				// Tạo mail
				MimeMessage mail = mailer.createMimeMessage();
				// Sử dụng lớp trợ giúp
				MimeMessageHelper helper = new MimeMessageHelper(mail);

				String newPass = getAlphaNumericString(8);

				Session session = factory.openSession();
				Transaction t = session.beginTransaction();
				try {
					User user = (User) session.get(User.class, getUserIdFromEmail(email));
					user.setPassword(newPass);
					session.merge(user);

					t.commit();
				} catch (Exception e) {
					e.printStackTrace();
					t.rollback();
				} finally {
					session.close();
				}

				helper.setTo(email);
				helper.setSubject("Quên mật khẩu!");
				helper.setText("Mật khẩu mới của bạn là: " + newPass
						+ "\n <a href='http://localhost:9999/CampingEquipmentWebsite/signin.html'>Đăng nhập ngay tại đây</a>",
						true);
				// Gửi mail
				mailer.send(mail);
				model.addAttribute("message", "Gửi email thành công. Vui lòng kiểm tra email!");
			} catch (Exception ex) {
				ex.printStackTrace();
				model.addAttribute("msg", "Gửi email thất bại!");
			}
		}

		return "user/forgetPass";
	}

	@RequestMapping(value = "signin", method = RequestMethod.GET)
	public String showLogin(ModelMap model) {
		model.addAttribute("user", new User());
		return "user/signin";
	}

	@RequestMapping(value = "signin", method = RequestMethod.POST)
	public String signIn(ModelMap model, @ModelAttribute("user") User user, BindingResult errors) {
		User tempUser;
		if (user.getUsername().trim().length() == 0) {
			errors.rejectValue("username", "user", "Vui lòng nhập tên đăng nhập!");
		}
		if (user.getPassword().trim().length() == 0) {
			errors.rejectValue("password", "user", "Vui lòng nhập mật khẩu!");
		}
		if (errors.hasErrors()) {
			return "user/signin";
		} else {
			System.out.println(user.getUsername() + " - " + user.getPassword());
			tempUser = login(user.getUsername(), user.getPassword());
			if (tempUser == null) {
				model.addAttribute("user", new User());
				model.addAttribute("msg", "Tên tài khoản/Email hoặc mật khẩu không chính xác !");
				// model.addAttribute("result", false);
				return "user/signin";
			} else {
				if (tempUser.isLock()) {
					model.addAttribute("user", new User());
					model.addAttribute("msg", "Tài khoản đã bị khoá vui lòng liên hệ với admin !");
					// model.addAttribute("result", false);
					return "user/signin";
				} else {
					if (tempUser.getRoleId() == 1) {
						adminLogin = tempUser;
//						userLogin = tempUser;
					} else {
						userLogin = tempUser;
					}
					// model.addAttribute("result", true);
				}
			}
		}

		if (tempUser.getRoleId() == 1) {
			return "redirect:/admin/user.html";
		} else {
			if (baseURL.equals("category")) {
				return "redirect:/category/" + cId + "/" + pNum + ".html";
			}
			if (baseURL.equals("shop")) {
				return "redirect:/shop/" + pNum + ".html";
			}
			if (baseURL.equals("single")) {
				return "redirect:/single/" + pId + ".html";
			}
			if (baseURL.equals("checkout")) {
				return "redirect:/checkout.html";
			}
			if (baseURL.equals("payment")) {
				return "redirect:/payment.html";
			}
			if (baseURL.equals("order")) {
				return "redirect:/order.html";
			} else {
				return "redirect:/index.html";
			}
		}

	}

	@RequestMapping(value = "signup", method = RequestMethod.GET)
	public String showRegister(ModelMap model) {
		model.addAttribute("user", new User());
		return "user/signup";
	}

	public boolean validPhoneNumber(String number) {
		Pattern pattern = Pattern.compile("^[0-9]*$");
		Matcher matcher = pattern.matcher(number);
		if (!matcher.matches()) {
			return false;
		} else {
			if (number.length() != 10) {
				return false;
			} else {
				if (!number.startsWith("03") && !number.startsWith("05") && !number.startsWith("07")
						&& !number.startsWith("08") && !number.startsWith("09")) {
					return false;
				}
			}
		}
		return true;
	}

	@RequestMapping(value = "signup", method = RequestMethod.POST)
	public String signUp(ModelMap model, @ModelAttribute("user") User user, BindingResult errors) {
		if (!validPhoneNumber(user.getPhone())) {
			errors.rejectValue("phone", "user", "Số điện thoại sai định dạng");
		}
//		if (user.getUsername().isEmpty()) {
//			errors.rejectValue("username", "user", "Vui lòng nhập tên đăng nhập!");
//		}
		if (existUserName(user.getUsername())) {
			errors.rejectValue("username", "user", "Tên đăng nhập đã tồn tại!");
		}
		if (existEmail(user.getEmail())) {
			errors.rejectValue("email", "user", "Email đã có người sử dụng!");
		}
//		if (user.getPassword().isEmpty()) {
//			errors.rejectValue("password", "user", "Vui lòng nhập mật khẩu!");
//		}
//		if (user.getName().isEmpty()) {
//			errors.rejectValue("name", "user", "Vui lòng nhập họ tên!");
//		}
//		if (user.getEmail().isEmpty()) {
//			errors.rejectValue("email", "user", "Vui lòng nhập email!");
//		}
		if (!errors.hasErrors()) {
			Session session = factory.openSession();
			Transaction t = session.beginTransaction();
			try {
				session.save(user);
				model.addAttribute("message", "Đăng ký thành công !");

				userLogin = user;
				Cart cart = new Cart();
				cart.setUser(user);
				session.save(cart);

				t.commit();
			} catch (Exception e) {
				System.out.println(e.toString());
				t.rollback();
				model.addAttribute("msg", "Đăng ký thất bại !\n" + e.toString());
			} finally {
				session.close();
			}
		}
		return "user/signup";
	}

	@RequestMapping(value = "profile", method = RequestMethod.GET)
	public String showProfile(ModelMap model) {

		return "user/profile";
	}

	@RequestMapping(value = "user/edit/{id}", method = RequestMethod.GET)
	public String showProfile(@PathVariable("id") Integer id, ModelMap model) {
		model.addAttribute("user", userLogin);
		return "user/profile";
	}

	@RequestMapping(value = "user/edit/{id}", method = RequestMethod.POST)
	public String edit(ModelMap model, @ModelAttribute("user") User user, @RequestParam("photo") MultipartFile photo,
			BindingResult errors, HttpServletRequest request) {
		String pass = "", newPass = "", confirmNewPass = "";

		pass = request.getParameter("pass");
		newPass = request.getParameter("newPassword");
		confirmNewPass = request.getParameter("confirmNewPass");
		if (duplicateEmail(user.getId(), user.getEmail())) {
			errors.rejectValue("email", "user", "Email đã có người sử dụng!");
		}
		if (pass.isEmpty()) {
			model.addAttribute("mess0", "Vui lòng nhập mật khẩu cũ!");
			return "user/profile";
		}
		if (newPass.isEmpty() && !confirmNewPass.isEmpty()) {
			model.addAttribute("mess1", "Vui lòng nhập mật khẩu mới!");
			return "user/profile";
		}
		if (!newPass.equals(confirmNewPass)) {
			model.addAttribute("mess2", "Xác nhận mật khẩu mới không khớp !");
			return "user/profile";
		}
		if (!pass.equals(user.getPassword())) {
			errors.rejectValue("password", "user", "Mật khẩu cũ không chính xác!");
			return "user/profile";
		}
		if (!pass.isEmpty() && newPass.isEmpty() && confirmNewPass.isEmpty()) {
			pass = user.getPassword();
			System.out.println(user.getPassword());
		}
		if (!pass.isEmpty() && !newPass.isEmpty() && !confirmNewPass.isEmpty()) {
			pass = newPass;
		}
		if (!errors.hasErrors()) {
//		} else {

			Session session = factory.openSession();
			Transaction t = session.beginTransaction();

			context = request.getSession().getServletContext();

			try {

				if (!photo.isEmpty()) {
					String photoPath = context.getRealPath("/images/avatar/" + photo.getOriginalFilename());
					photo.transferTo(new File(photoPath));

					user.setAvatar("images/avatar/" + photo.getOriginalFilename());
				}

				user.setPassword(pass);
				session.update(user);
				t.commit();

				TimeUnit.SECONDS.sleep(5);

				model.addAttribute("message", "Sửa thành công !");
				if (user.getRoleId() == 1) {
					adminLogin = user;
				} else {
					userLogin = user;
				}
			} catch (Exception e) {
				System.out.println(e.toString());
				t.rollback();
				model.addAttribute("msg", "Sửa thất bại !\n" + e.toString());
			} finally {
				session.close();
			}
		}

		return "user/profile";
	}

	public List<Product> getListNav(int start, int limit) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			Query query = session
					.createQuery("FROM Product WHERE display = true AND category.display = true ORDER BY id DESC");
			query.setFirstResult(start);
			query.setMaxResults(limit);
			List<Product> list = query.list();
			t.commit();
			return list;
		} catch (Exception ex) {
			if (t != null) {
				System.out.println(ex.toString());
				t.rollback();
			}
			ex.printStackTrace();
		} finally {
			session.flush();
			session.close();
		}
		return null;
	}

	public int totalItem() {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			Query query = session
					.createQuery("SELECT count(*) FROM Product WHERE display = true AND category.display = true");
			Long obj = (Long) query.uniqueResult();
			t.commit();
			return obj.intValue();
		} catch (Exception ex) {
			if (t != null) {
				System.out.println(ex.toString());
				t.rollback();
			}
			ex.printStackTrace();
		} finally {
			session.flush();
			session.close();
		}
		return 0;
	}

	public List<Product> getListNavByCate(int start, int limit, int id) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			Query query = session.createQuery(
					"FROM Product WHERE category.cateId =:id AND display = true AND category.display = true ORDER BY id DESC");
			query.setParameter("id", id);
			query.setFirstResult(start);
			query.setMaxResults(limit);
			List<Product> list = query.list();
			t.commit();
			return list;
		} catch (Exception ex) {
			if (t != null) {
				System.out.println(ex.toString());
				t.rollback();
			}
			ex.printStackTrace();
		} finally {
			session.flush();
			session.close();
		}
		return null;
	}

	public int totalItemByCate(int id) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			Query query = session.createQuery(
					"SELECT count(*) FROM Product WHERE category.cateId =:id AND display = true AND category.display = true");
			query.setParameter("id", id);
			Long obj = (Long) query.uniqueResult();
			t.commit();
			return obj.intValue();
		} catch (Exception ex) {
			if (t != null) {
				System.out.println(ex.toString());
				t.rollback();
			}
			ex.printStackTrace();
		} finally {
			session.flush();
			session.close();
		}
		return 0;
	}

	@ResponseBody
	@RequestMapping(value = "shop/pagination", method = RequestMethod.GET)
	public ModelAndView shopPagination(ModelMap model, @RequestParam("pageNum") Integer page) {
		pNum = page;
		return new ModelAndView("redirect:/shop/" + pNum + ".html");
	}

	@RequestMapping(value = "shop/{page}", method = RequestMethod.GET)
	public String viewProductListByPage(ModelMap model, @PathVariable("page") int page) {

		baseURL = "shop";

		pNum = page;

		int productCountPerPage = 12;

		// model.addAttribute("baseURL", baseURL);

		model.addAttribute("listProduct", getListNav((page - 1) * productCountPerPage, productCountPerPage));
		model.addAttribute("totalPage", (totalItem() % productCountPerPage == 0) ? totalItem() / productCountPerPage
				: totalItem() / productCountPerPage + 1);
		model.addAttribute("currentPage", page);
		model.addAttribute("isCate", 0);

		model.addAttribute("cartItem", new CartItem());
		// model.addAttribute("userLogin", userLogin);

		if (userLogin != null) {
			model.addAttribute("orders", getOrder(userLogin.getId()));
			Cart cart = getCart(userLogin.getId());
			if (cart == null) {

			} else {
				cartUser = cart;
				model.addAttribute("cart", cart);
				List<CartItem> list = getCartItems(cart.getId());
				if (list == null) {

				} else {
					model.addAttribute("totalItem", getTotalCartItem(cart.getId()));
					model.addAttribute("totalPrice", getTotalPriceCart(cart.getId()));
					model.addAttribute("listCartItem", list);
				}
			}
		}

		return "user/shop";
	}

	@ResponseBody
	@RequestMapping(value = "category/pagination", method = RequestMethod.GET)
	public ModelAndView categoryPagination(ModelMap model, @RequestParam("pageNum") Integer page,
			@RequestParam("cateId") Integer cateId) {
		cId = cateId;
		pNum = page;
		return new ModelAndView("redirect:/category/" + cId + "/" + pNum + ".html");
	}

	@RequestMapping(value = "category/{id}/{page}", method = RequestMethod.GET)
	public String viewProductListByPageAndCate(ModelMap model, @PathVariable("id") int id,
			@PathVariable("page") int page) {

		baseURL = "category";

		pNum = page;
		cId = id;

		int productCountPerPage = 12;

		Session session = factory.getCurrentSession();

		// model.addAttribute("baseURL", baseURL);

		model.addAttribute("listProduct", getListNavByCate((page - 1) * productCountPerPage, productCountPerPage, id));
		model.addAttribute("totalPage",
				(totalItemByCate(id) % productCountPerPage == 0) ? totalItemByCate(id) / productCountPerPage
						: totalItemByCate(id) / productCountPerPage + 1);
		model.addAttribute("currentPage", page);
		model.addAttribute("isCate", 1);
		model.addAttribute("cateId", id);

		Category category = (Category) session.get(Category.class, id);
		model.addAttribute("category", category);

		model.addAttribute("cartItem", new CartItem());
		// model.addAttribute("userLogin", userLogin);

		if (userLogin != null) {
			model.addAttribute("orders", getOrder(userLogin.getId()));
			Cart cart = getCart(userLogin.getId());
			if (cart == null) {

			} else {
				cartUser = cart;
				model.addAttribute("cart", cart);
				List<CartItem> list = getCartItems(cart.getId());
				if (list == null) {

				} else {
					model.addAttribute("totalItem", getTotalCartItem(cart.getId()));
					model.addAttribute("totalPrice", getTotalPriceCart(cart.getId()));
					model.addAttribute("listCartItem", list);
				}
			}
		}

		return "user/shop";
	}

	@RequestMapping(value = "single/{id}", method = RequestMethod.GET)
	public String productDetail(ModelMap model, @PathVariable("id") int id) {

		baseURL = "single";

		pId = id;

		Session session = factory.getCurrentSession();

		// model.addAttribute("baseURL", baseURL);

		Product product = (Product) session.get(Product.class, id);

		model.addAttribute("product", product);

		model.addAttribute("similarPros", getSimilarPro(product.getCategory().getCateId(), product));

		model.addAttribute("cartItem", new CartItem());
		// model.addAttribute("userLogin", userLogin);

		if (userLogin != null) {
			model.addAttribute("orders", getOrder(userLogin.getId()));
			Cart cart = getCart(userLogin.getId());
			if (cart == null) {

			} else {
				cartUser = cart;
				model.addAttribute("cart", cart);
				List<CartItem> list = getCartItems(cart.getId());
				if (list == null) {

				} else {
					model.addAttribute("totalItem", getTotalCartItem(cart.getId()));
					model.addAttribute("totalPrice", getTotalPriceCart(cart.getId()));
					model.addAttribute("listCartItem", list);
				}
			}
		}

		return "user/single";
	}

	public CartItem checkExistCartItem(Integer cartId, Integer proId) {
		Session session = factory.openSession();
		Transaction transaction = null;
		try {
			transaction = session.beginTransaction();
			Query query = session.createQuery("FROM CartItem WHERE cartId = :cartId AND proId = :proId");
			query.setInteger("cartId", cartId);
			query.setInteger("proId", proId);
			CartItem obj = (CartItem) query.uniqueResult();
			transaction.commit();
			return obj;
		} catch (Exception ex) {
			if (transaction != null) {
				System.out.println(ex.toString());
				transaction.rollback();
			}
			ex.printStackTrace();
		} finally {
			session.flush();
			session.close();
		}
		return null;
	}

	@RequestMapping(value = "checkout", method = RequestMethod.GET)
	public String checkout(ModelMap model) {
		baseURL = "checkout";

		if (userLogin != null) {
			model.addAttribute("orders", getOrder(userLogin.getId()));
			Cart cart = getCart(userLogin.getId());
			if (cart == null) {

			} else {
				cart.setName(userLogin.getName());
				cart.setPhone(userLogin.getPhone());
				cart.setAddress(userLogin.getAddress());
				cart.setEmail(userLogin.getEmail());
				cartUser = cart;
				List<CartItem> list = getCartItems(cart.getId());
				model.addAttribute("cart", cart);

				if (list == null) {

				} else {
					model.addAttribute("totalItem", getTotalCartItem(cart.getId()));
					model.addAttribute("totalPrice", getTotalPriceCart(cart.getId()));
					model.addAttribute("listCartItem", cart.getCartItems());
				}
			}
		}
		return "user/checkout";
	}

	@RequestMapping(value = "checkout", method = RequestMethod.POST)
	public String checkout(ModelMap model, @ModelAttribute("cart") Cart cart, BindingResult errors) {
		if (!validPhoneNumber(cart.getPhone())) {
			errors.rejectValue("phone", "cart", "Số điện thoại sai định dạng");
		}
		if (errors.hasErrors()) {
			return "redirect:/checkout.html";
		} else {
			Session session = factory.openSession();
			Transaction t = session.beginTransaction();

			try {
				session.update(cart);

//				for (CartItem ci : getCartItems(cart.getId())) {
//					session.delete(ci);
//				}
				for (CartItem ci : cart.getCartItems()) {
					session.update(ci);
				}

				t.commit();
			} catch (Exception e) {
				System.out.println(e.toString());
				t.rollback();
			} finally {
//				session.flush();
				session.close();
			}
			return "redirect:/payment.html";
		}

	}

	@RequestMapping(value = "payment", method = RequestMethod.GET)
	public String payment(ModelMap model) {
		baseURL = "payment";

		if (userLogin != null) {
			model.addAttribute("orders", getOrder(userLogin.getId()));
			Cart cart = getCart(userLogin.getId());
			if (cart == null) {

			} else {
				cartUser = cart;
				model.addAttribute("cart", cart);
				List<CartItem> list = getCartItems(cart.getId());
				if (list == null) {

				} else {
					model.addAttribute("totalItem", getTotalCartItem(cart.getId()));
					model.addAttribute("totalPrice", getTotalPriceCart(cart.getId()));
					model.addAttribute("listCartItem", list);
				}
			}
		}
		return "user/payment";
	}

	@RequestMapping(value = "payment", method = RequestMethod.POST)
	public String payment(ModelMap model, @ModelAttribute("cart") Cart c) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			c.setBuyDate(new Date());
			session.saveOrUpdate(c);

			Cart cart = new Cart();
			cart.setUser(userLogin);
			session.save(cart);

			t.commit();
		} catch (Exception e) {
			System.out.println(e.toString());
			t.rollback();
		} finally {
			session.flush();
			session.close();
		}
		return "redirect:/index.html";
	}

	@RequestMapping(value = "order", method = RequestMethod.GET)
	public String order(ModelMap model) {
		baseURL = "order";

		if (userLogin != null) {
			model.addAttribute("orders", getOrder(userLogin.getId()));

			Cart cart = getCart(userLogin.getId());
			if (cart == null) {

			} else {
				cartUser = cart;
				model.addAttribute("cart", cart);
				List<CartItem> list = getCartItems(cart.getId());
				if (list == null) {

				} else {
					model.addAttribute("totalItem", getTotalCartItem(cart.getId()));
					model.addAttribute("totalPrice", getTotalPriceCart(cart.getId()));
					model.addAttribute("listCartItem", list);
				}
			}
		}
		return "user/order";
	}

	@RequestMapping(value = "order/{action}/{id}", method = RequestMethod.GET)
	public String cancelOrder(ModelMap model, @PathVariable String action, @PathVariable Integer id) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		Cart cart = (Cart) session.get(Cart.class, id);
		try {
			if (action.equals("cancel")) {
				cart.setStatus(3);
			}
			if (action.equals("received")) {
				cart.setStatus(2);
			}
			if (action.equals("repurchase")) {
				cart.setStatus(0);
			}
			session.update(cart);
			t.commit();
		} catch (Exception e) {
			System.out.println(e.toString());
			t.rollback();
		} finally {
			session.flush();
			session.close();
		}
		return "redirect:/order.html";
	}

	@RequestMapping("about")
	public String aboutUs() {
		return "user/about";
	}

	@RequestMapping("error")
	public String error() {
		return "user/404";
	}

	@RequestMapping("contact")
	public String contact() {
		return "user/contact";
	}

	@RequestMapping("customer")
	public String customer() {
		return "user/customer";
	}

	// admin
	// product
	@RequestMapping(value = "admin/{id}", method = RequestMethod.GET)
	public String admin(ModelMap model, @PathVariable Integer id) {
		Session session = factory.getCurrentSession();
		User admin = (User) session.get(User.class, id);
		adminLogin = admin;
		return "redirect:/admin/user.html";
	}

	@ModelAttribute("adminProducts")
	public List<Product> getAdminProducts() {
		Session session = factory.getCurrentSession();
		String hql = "FROM Product ORDER BY id DESC";
		Query query = session.createQuery(hql);
		List<Product> list = query.list();
		return list;
	}

	@RequestMapping(value = "admin/product", method = RequestMethod.GET)
	public String productConfig(ModelMap model) {
		adminBaseURL = "admin/product";

		model.addAttribute("adminBaseURL", adminBaseURL);

		return "admin/product/index";
	}

	@RequestMapping(value = "admin/product/insert", method = RequestMethod.GET)
	public String insertProduct(ModelMap model) {
		adminBaseURL = "admin/product/insert";
		model.addAttribute("adminBaseURL", adminBaseURL);

		model.addAttribute("product", new Product());
		return "admin/product/insert";
	}

	@RequestMapping(value = "admin/product/insert", method = RequestMethod.POST)
	public String insertProduct(ModelMap model, @ModelAttribute("product") Product product,
			@RequestParam("photo") MultipartFile photo, BindingResult errors, HttpServletRequest request) {
		model.addAttribute("adminBaseURL", adminBaseURL);
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();

		context = request.getSession().getServletContext();

		try {

			if (!photo.isEmpty()) {
				String photoPath = context.getRealPath("/images/product-image/" + photo.getOriginalFilename());
				photo.transferTo(new File(photoPath));

				product.setImage("images/product-image/" + photo.getOriginalFilename());
			}

			session.save(product);
			t.commit();

			TimeUnit.SECONDS.sleep(5);

			model.addAttribute("message", "Thêm mới thành công !");
		} catch (Exception e) {
			t.rollback();
			model.addAttribute("msg", "Thêm mới thất bại !\n" + e.toString());
		} finally {
			session.close();
		}

		return "admin/product/insert";
	}

	@RequestMapping(value = "admin/product/edit/{id}", method = RequestMethod.GET)
	public String editProduct(ModelMap model, @PathVariable("id") Integer id) {
		adminBaseURL = "admin/product/edit";
		model.addAttribute("adminBaseURL", adminBaseURL);

		Session session = factory.getCurrentSession();
		Product product = (Product) session.get(Product.class, id);

		model.addAttribute("product", product);
		return "admin/product/edit";
	}

	@RequestMapping(value = "admin/product/edit/{id}", method = RequestMethod.POST)
	public String editProduct(ModelMap model, @ModelAttribute("product") Product product,
			@RequestParam("photo") MultipartFile photo, BindingResult errors, HttpServletRequest request) {
		model.addAttribute("adminBaseURL", adminBaseURL);
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();

		context = request.getSession().getServletContext();

		try {

			if (!photo.isEmpty()) {
				String photoPath = context.getRealPath("/images/product-image/" + photo.getOriginalFilename());
				photo.transferTo(new File(photoPath));

				product.setImage("images/product-image/" + photo.getOriginalFilename());
			}

			session.update(product);
			t.commit();

			TimeUnit.SECONDS.sleep(5);

			model.addAttribute("message", "Sửa thành công !");
		} catch (Exception e) {
			t.rollback();
			model.addAttribute("msg", "Sửa thất bại !\n" + e.toString());
		} finally {
			session.close();
		}

		return "admin/product/edit";
	}

	@ResponseBody
	@RequestMapping(value = "admin/product/delete", method = RequestMethod.GET)
	public ModelAndView deleteProduct(ModelMap model, @RequestParam("id") Integer id) {

		Session session = factory.openSession();
		Product product = (Product) session.get(Product.class, id);
		Transaction t = session.beginTransaction();
		try {
			session.delete(product);
			t.commit();
		} catch (Exception e) {
			t.rollback();
		} finally {
			session.close();
		}
		return new ModelAndView("redirect:/admin/product.html");
	}

	@ResponseBody
	@RequestMapping(value = "admin/product/display", method = RequestMethod.GET)
	public ModelAndView displayProduct(ModelMap model, @RequestParam("id") Integer id) {

		Session session = factory.openSession();
		Product product = (Product) session.get(Product.class, id);
		Transaction t = session.beginTransaction();
		try {
			if (product.isDisplay()) {
				product.setDisplay(false);
			} else {
				product.setDisplay(true);
			}
			session.update(product);
			t.commit();
		} catch (Exception e) {
			t.rollback();
		} finally {
			session.close();
		}
		return new ModelAndView("redirect:/admin/product.html");
	}

	// category

	@ModelAttribute("adminCategories")
	public List<Category> getAdminCategories() {
		Session session = factory.getCurrentSession();
		String hql = "FROM Category ORDER BY cateId DESC";
		Query query = session.createQuery(hql);
		List<Category> list = query.list();
		return list;
	}

	@RequestMapping(value = "admin/category", method = RequestMethod.GET)
	public String categoryConfig(ModelMap model) {
		adminBaseURL = "admin/category";

		model.addAttribute("adminBaseURL", adminBaseURL);

		return "admin/category/index";
	}

	@RequestMapping(value = "admin/category/insert", method = RequestMethod.GET)
	public String insertCategory(ModelMap model) {
		adminBaseURL = "admin/category/insert";
		model.addAttribute("adminBaseURL", adminBaseURL);

		model.addAttribute("category", new Category());
		return "admin/category/insert";
	}

	@RequestMapping(value = "admin/category/insert", method = RequestMethod.POST)
	public String insertCategory(ModelMap model, @ModelAttribute("category") Category category,
			@RequestParam("photo") MultipartFile photo, BindingResult errors, HttpServletRequest request) {
		model.addAttribute("adminBaseURL", adminBaseURL);
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();

		context = request.getSession().getServletContext();

		try {

			if (!photo.isEmpty()) {
				String photoPath = context.getRealPath("/images/category-image/" + photo.getOriginalFilename());
				photo.transferTo(new File(photoPath));

				category.setCateImage("images/category-image/" + photo.getOriginalFilename());
			}

			session.save(category);
			t.commit();

			TimeUnit.SECONDS.sleep(5);

			model.addAttribute("message", "Thêm mới thành công !");
		} catch (Exception e) {
			t.rollback();
			model.addAttribute("msg", "Thêm mới thất bại !\n" + e.toString());
		} finally {
			session.close();
		}

		return "admin/category/insert";
	}

	@RequestMapping(value = "admin/category/edit/{id}", method = RequestMethod.GET)
	public String editCategory(ModelMap model, @PathVariable("id") Integer id) {
		adminBaseURL = "admin/category/edit";
		model.addAttribute("adminBaseURL", adminBaseURL);

		Session session = factory.getCurrentSession();
		Category category = (Category) session.get(Category.class, id);

		model.addAttribute("category", category);
		return "admin/category/edit";
	}

	@RequestMapping(value = "admin/category/edit/{id}", method = RequestMethod.POST)
	public String editProduct(ModelMap model, @ModelAttribute("category") Category category,
			@RequestParam("photo") MultipartFile photo, BindingResult errors, HttpServletRequest request) {
		model.addAttribute("adminBaseURL", adminBaseURL);
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();

		context = request.getSession().getServletContext();

		try {

			if (!photo.isEmpty()) {
				String photoPath = context.getRealPath("/images/category-image/" + photo.getOriginalFilename());
				photo.transferTo(new File(photoPath));

				category.setCateImage("images/category-image/" + photo.getOriginalFilename());
			}

			session.update(category);
			t.commit();

			TimeUnit.SECONDS.sleep(5);

			model.addAttribute("message", "Sửa thành công !");
		} catch (Exception e) {
			t.rollback();
			model.addAttribute("msg", "Sửa thất bại !\n" + e.toString());
		} finally {
			session.close();
		}

		return "admin/category/edit";
	}

	@ResponseBody
	@RequestMapping(value = "admin/category/delete", method = RequestMethod.GET)
	public ModelAndView deleteCategory(ModelMap model, @RequestParam("id") Integer id) {

		Session session = factory.openSession();
		Category category = (Category) session.get(Category.class, id);
		Transaction t = session.beginTransaction();
		try {
			session.delete(category);
			t.commit();
		} catch (Exception e) {
			t.rollback();
		} finally {
			session.close();
		}
		return new ModelAndView("redirect:/admin/category.html");
	}

	@ResponseBody
	@RequestMapping(value = "admin/category/display", method = RequestMethod.GET)
	public ModelAndView displayCategory(ModelMap model, @RequestParam("id") Integer id) {

		Session session = factory.openSession();
		Category category = (Category) session.get(Category.class, id);
		Transaction t = session.beginTransaction();
		try {
			if (category.isDisplay()) {
				category.setDisplay(false);
			} else {
				category.setDisplay(true);
			}
			session.update(category);
			t.commit();
		} catch (Exception e) {
			t.rollback();
		} finally {
			session.close();
		}
		return new ModelAndView("redirect:/admin/category.html");
	}

	// user
	@ModelAttribute("adminUsers")
	public List<User> getAadminUsers() {
		Session session = factory.getCurrentSession();
		String hql = "FROM User ORDER BY id DESC";
		Query query = session.createQuery(hql);
		List<User> list = query.list();
		return list;
	}

	@RequestMapping(value = "admin/user", method = RequestMethod.GET)
	public String userConfig(ModelMap model) {
		adminBaseURL = "admin/user";

		model.addAttribute("adminBaseURL", adminBaseURL);

		return "admin/user/index";
	}

	@RequestMapping(value = "admin/user/insert", method = RequestMethod.GET)
	public String insertUser(ModelMap model) {
		adminBaseURL = "admin/user/insert";
		model.addAttribute("adminBaseURL", adminBaseURL);

		model.addAttribute("user", new User());
		return "admin/user/insert";
	}

	@RequestMapping(value = "admin/user/insert", method = RequestMethod.POST)
	public String insertUser(ModelMap model, @ModelAttribute("user") User user,
			@RequestParam("photo") MultipartFile photo, BindingResult errors, HttpServletRequest request) {
		model.addAttribute("adminBaseURL", adminBaseURL);
		if (!validPhoneNumber(user.getPhone())) {
			errors.rejectValue("phone", "user", "Số điện thoại sai định dạng");
		}

		if (existUserName(user.getUsername())) {
			errors.rejectValue("username", "user", "Tên đăng nhập đã tồn tại!");
		}
		if (existEmail(user.getEmail())) {
			errors.rejectValue("email", "user", "Email đã có người sử dụng!");
		}

		if (!errors.hasErrors()) {
			Session session = factory.openSession();
			Transaction t = session.beginTransaction();

			context = request.getSession().getServletContext();

			try {

				if (!photo.isEmpty()) {
					String photoPath = context.getRealPath("/images/avatar/" + photo.getOriginalFilename());
					photo.transferTo(new File(photoPath));

					user.setAvatar("images/avatar/" + photo.getOriginalFilename());
				} else {
					user.setAvatar("images/avatar/profile-pic.jpg");
				}

				session.save(user);

				Cart cart = new Cart();
				cart.setUser(user);
				session.save(cart);

				t.commit();

				TimeUnit.SECONDS.sleep(5);

				model.addAttribute("message", "Thêm mới thành công !");
			} catch (Exception e) {
				t.rollback();
				model.addAttribute("msg", "Thêm mới thất bại !\n" + e.toString());
			} finally {
				session.close();
			}
		}

		return "admin/user/insert";
	}

	@RequestMapping(value = "admin/user/edit/{id}", method = RequestMethod.GET)
	public String editUser(ModelMap model, @PathVariable("id") Integer id) {
		adminBaseURL = "admin/user/edit";
		model.addAttribute("adminBaseURL", adminBaseURL);

		Session session = factory.getCurrentSession();
		User user = (User) session.get(User.class, id);

		model.addAttribute("user", user);
		return "admin/user/edit";
	}

	@RequestMapping(value = "admin/user/edit/{id}", method = RequestMethod.POST)
	public String editProduct(ModelMap model, @ModelAttribute("user") User user,
			@RequestParam("photo") MultipartFile photo, BindingResult errors, HttpServletRequest request) {
		model.addAttribute("adminBaseURL", adminBaseURL);

		if (duplicateEmail(user.getId(), user.getEmail())) {
			errors.rejectValue("email", "user", "Email đã có người sử dụng!");
		}
		if (!errors.hasErrors()) {
			Session session = factory.getCurrentSession();
//			Transaction t = session.beginTransaction();

			context = request.getSession().getServletContext();

			try {

				if (!photo.isEmpty()) {
					String photoPath = context.getRealPath("/images/avatar/" + photo.getOriginalFilename());
					photo.transferTo(new File(photoPath));
					user.setAvatar("images/avatar/" + photo.getOriginalFilename());
				}

				session.update(user);
//				t.commit();
				    
				TimeUnit.SECONDS.sleep(5);

				model.addAttribute("message", "Sửa thành công !");
				if (user.getId() == adminLogin.getId()) {
					adminLogin = user;
				} else {
					if (userLogin.getId() == user.getId()) {
						userLogin = user;
					}
				}
			} catch (Exception e) {
//				t.rollback();
//				model.addAttribute("msg", "Sửa thất bại !\n" + e.toString());
			} finally {
//				session.close();
			}
		}

		return "admin/user/edit";
	}

	@RequestMapping(value = "admin/user/delete/{id}", method = RequestMethod.GET)
	public String deleteUser(ModelMap model, @PathVariable("id") Integer id) {

		Session session = factory.openSession();
		User user = (User) session.get(User.class, id);
		Transaction t = session.beginTransaction();
		try {
			session.delete(user);
			t.commit();
		} catch (Exception e) {
			t.rollback();
		} finally {
			session.close();
		}
		return "redirect:/admin/user.html";
	}

	@ResponseBody
	@RequestMapping(value = "admin/user/lock", method = RequestMethod.GET)
	public ModelAndView lockUser(ModelMap model, @RequestParam("id") Integer id) {

		Session session = factory.openSession();
		User user = (User) session.get(User.class, id);
		Transaction t = session.beginTransaction();
		try {
			if (user.isLock()) {
				user.setLock(false);
			} else {
				user.setLock(true);
			}
			session.update(user);
			t.commit();

		} catch (Exception e) {
			t.rollback();
		} finally {
			session.close();
		}
		return new ModelAndView("redirect:/admin/user.html");
	}

	// order
	@ModelAttribute("adminOrders")
	public List<Cart> getAdminOrders() {
		Session session = factory.getCurrentSession();
		String hql = "FROM Cart WHERE buyDate IS NOT NULL ORDER BY id DESC";
		Query query = session.createQuery(hql);
		List<Cart> list = query.list();
		return list;
	}

	public List<Cart> getUserOrders(Integer userId) {
		Session session = factory.getCurrentSession();
		String hql = "FROM Cart WHERE buyDate IS NOT NULL AND user.id = :userId ORDER BY id DESC";
		Query query = session.createQuery(hql);
		query.setInteger("userId", userId);
		List<Cart> list = query.list();
		return list;
	}

	@RequestMapping(value = "admin/user/order/{userId}", method = RequestMethod.GET)
	public String userOrderConfig(ModelMap model, @PathVariable("userId") Integer userId) {
		Session session = factory.getCurrentSession();
		adminBaseURL = "admin/user/order";
		User user = (User) session.get(User.class, userId);
		model.addAttribute("adminBaseURL", adminBaseURL);
		model.addAttribute("user", user);
		model.addAttribute("userOrders", getUserOrders(userId));

		return "admin/order/index";
	}

	@RequestMapping(value = "admin/order", method = RequestMethod.GET)
	public String orderConfig(ModelMap model) {
		adminBaseURL = "admin/order";

		model.addAttribute("adminBaseURL", adminBaseURL);

//		model.addAttribute("adminOrders", getAdminOrders());

		return "admin/order/index";
	}

	List<CartItem> listOrderItem;
	Integer orderId;

	public CartItem checkExistOrderItem(Integer proId) {
		for (CartItem ci : listOrderItem) {
			if (ci.getProduct().getId() == proId) {
				return ci;
			}
		}
		return null;
	}

	@RequestMapping(value = "admin/order/insert", method = RequestMethod.GET)
	public String insertOrder(ModelMap model) {
		// model.addAttribute("order", new Cart());

		adminBaseURL = "admin/order/insert";
		model.addAttribute("adminBaseURL", adminBaseURL);

		Session session = factory.getCurrentSession();
//		Cart order = (Cart) session.get(Cart.class, id);
//		orderId = order.getId();
		Cart order = getCart(adminLogin.getId());
		CartItem ci = new CartItem();
		ci.setCart(order);
		listOrderItem = new ArrayList<CartItem>();
		model.addAttribute("order", order);
		model.addAttribute("listOrderItem", listOrderItem);
		model.addAttribute("orderItem", ci);
//		System.out.println("test");
		return "admin/order/insert";
	}

	@RequestMapping(value = "admin/order/insert", method = RequestMethod.POST)
	public String insertOrder(ModelMap model, @ModelAttribute("order") Cart order) {
		model.addAttribute("adminBaseURL", adminBaseURL);
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();

		try {
			if (listOrderItem.size() == 0) {
				model.addAttribute("msg", "Giỏ hàng trống!");
				CartItem ci = new CartItem();
				ci.setCart(order);
				model.addAttribute("listOrderItem", listOrderItem);
				model.addAttribute("orderItem", ci);
				model.addAttribute("adminBaseURL", adminBaseURL);
				return "admin/order/insert";
			}

			order.setBuyDate(new Date());
			session.update(order);

			for (CartItem ci : listOrderItem) {
				session.save(ci);
			}

			Cart cart = new Cart();
			cart.setUser(adminLogin);
			session.save(cart);

			t.commit();

			CartItem ci = new CartItem();
			ci.setCart(order);
			model.addAttribute("listOrderItem", listOrderItem);
			model.addAttribute("orderItem", ci);
			model.addAttribute("message", "Thêm thành công !");
		} catch (Exception e) {
			t.rollback();
			model.addAttribute("msg", "Thêm thất bại !\n" + e.toString());
		} finally {
			session.close();
		}

		return "redirect:/admin/order.html";
	}

	@RequestMapping(value = "admin/order/insert/insertItem", method = RequestMethod.POST)
	public String insertOrderItem(ModelMap model, @ModelAttribute("orderItem") CartItem orderItem) {

		Session session = factory.getCurrentSession();

		Product pro = (Product) session.get(Product.class, orderItem.getProduct().getId());

		CartItem ci_temp = checkExistOrderItem(orderItem.getProduct().getId());
		if (ci_temp != null) {
			ci_temp.setQuantity(ci_temp.getQuantity() + orderItem.getQuantity());
			for (int i = 0; i < listOrderItem.size(); i++) {
				if (listOrderItem.get(i).getProduct().getId() == ci_temp.getProduct().getId()) {
					orderItem.setProduct(pro);
					listOrderItem.set(i, ci_temp);
				}
			}
		} else {
			orderItem.setProduct(pro);
			listOrderItem.add(orderItem);
		}

		Cart order = getCart(adminLogin.getId());
		CartItem ci = new CartItem();
		ci.setCart(order);
		model.addAttribute("order", order);
		model.addAttribute("listOrderItem", listOrderItem);
		model.addAttribute("orderItem", ci);
		model.addAttribute("adminBaseURL", adminBaseURL);

		return "admin/order/insert";
	}

	@RequestMapping(value = "admin/order/insert/deleteItem/{id}", method = RequestMethod.GET)
	public String insertOrderItem(ModelMap model, @PathVariable("id") Integer id) {

		Session session = factory.getCurrentSession();

		for (int i = 0; i < listOrderItem.size(); i++) {
			if (listOrderItem.get(i).getProduct().getId() == id) {
				listOrderItem.remove(i);
			}
		}
		Cart order = getCart(adminLogin.getId());
		CartItem ci = new CartItem();
		ci.setCart(order);
		model.addAttribute("order", order);
		model.addAttribute("listOrderItem", listOrderItem);
		model.addAttribute("orderItem", ci);
		model.addAttribute("adminBaseURL", adminBaseURL);

		return "admin/order/insert";
	}

	@RequestMapping(value = "admin/order/edit/{id}", method = RequestMethod.GET)
	public String editOrder(ModelMap model, @PathVariable("id") Integer id) {
		adminBaseURL = "admin/order/edit";
		model.addAttribute("adminBaseURL", adminBaseURL);

		Session session = factory.getCurrentSession();
		Cart order = (Cart) session.get(Cart.class, id);
		orderId = order.getId();
		CartItem ci = new CartItem();
		ci.setCart(order);
		model.addAttribute("order", order);
		listOrderItem = getCartItems(id);
		model.addAttribute("listOrderItem", listOrderItem);
		model.addAttribute("orderItem", ci);
		return "admin/order/edit";
	}

	@RequestMapping(value = "admin/order/edit/{id}", method = RequestMethod.POST)
	public String editOrder(ModelMap model, @ModelAttribute("order") Cart order) {
		model.addAttribute("adminBaseURL", adminBaseURL);
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();

		try {
			if (listOrderItem.size() == 0) {
				model.addAttribute("msg", "Giỏ hàng trống!");
				CartItem ci = new CartItem();
				ci.setCart(order);
				model.addAttribute("listOrderItem", listOrderItem);
				model.addAttribute("orderItem", ci);
				return "admin/order/edit";
			}
			session.update(order);

			for (CartItem ci : getCartItems(orderId)) {
				session.delete(ci);
			}

			for (CartItem ci : listOrderItem) {
				session.save(ci);
			}
			t.commit();

			CartItem ci = new CartItem();
			ci.setCart(order);
			model.addAttribute("listOrderItem", listOrderItem);
			model.addAttribute("orderItem", ci);
			model.addAttribute("message", "Sửa thành công !");
		} catch (Exception e) {
			t.rollback();
			model.addAttribute("msg", "Sửa thất bại !\n" + e.toString());
		} finally {
			session.close();
		}

		return "admin/order/edit";
	}

	@ResponseBody
	@RequestMapping(value = "admin/order/action", method = RequestMethod.GET)
	public ModelAndView submitOrder(ModelMap model, @RequestParam("action") String action,
			@RequestParam("id") Integer id) {

		Session session = factory.openSession();
		Cart order = (Cart) session.get(Cart.class, id);
		Transaction t = session.beginTransaction();
		try {
			if (action.equals("submit")) {
				order.setStatus(1);
			}
			if (action.equals("cancel")) {
				order.setStatus(3);
			}
			if (action.equals("delivered")) {
				order.setStatus(2);
			}
			session.update(order);
			t.commit();

		} catch (Exception e) {
			t.rollback();
		} finally {
			session.close();
		}
		return new ModelAndView("redirect:/admin/order.html");
	}

	@ResponseBody
	@RequestMapping(value = "addOrderItem", method = RequestMethod.GET)
	public ModelAndView addOrderItem(ModelMap model, @ModelAttribute("orderItem") CartItem orderItem) {
		Session session = factory.getCurrentSession();
		Product pro = (Product) session.get(Product.class, orderItem.getProduct().getId());
		CartItem ci_temp = checkExistOrderItem(orderItem.getProduct().getId());
		if (ci_temp != null) {
			ci_temp.setQuantity(ci_temp.getQuantity() + orderItem.getQuantity());
			for (int i = 0; i < listOrderItem.size(); i++) {
				if (listOrderItem.get(i).getProduct().getId() == ci_temp.getProduct().getId()) {
					orderItem.setProduct(pro);
					listOrderItem.set(i, ci_temp);
				}
			}
		} else {
			orderItem.setProduct(pro);
			listOrderItem.add(orderItem);
		}
		Cart order;
		if (adminBaseURL.equals("admin/order/insert")) {
			order = getCart(adminLogin.getId());
		} else {
			order = (Cart) session.get(Cart.class, orderId);
		}

		CartItem ci = new CartItem();
		ci.setCart(order);
		model.addAttribute("order", order);
		model.addAttribute("listOrderItem", listOrderItem);
		model.addAttribute("orderItem", ci);
		model.addAttribute("adminBaseURL", adminBaseURL);

		if (adminBaseURL.equals("admin/order/insert")) {
			return new ModelAndView("admin/order/insert");
		} else {
			return new ModelAndView("admin/order/edit");
		}

	}

	@ResponseBody
	@RequestMapping(value = "deleteOrderItem", method = RequestMethod.GET)
	public ModelAndView deleteOrderItem(ModelMap model, @RequestParam("id") Integer id) {
		Session session = factory.getCurrentSession();

		for (int i = 0; i < listOrderItem.size(); i++) {
			if (listOrderItem.get(i).getProduct().getId() == id) {
				listOrderItem.remove(i);
			}
		}
		Cart order;
		if (adminBaseURL.equals("admin/order/insert")) {
			order = getCart(adminLogin.getId());
		} else {
			order = (Cart) session.get(Cart.class, orderId);
		}
		CartItem ci = new CartItem();
		ci.setCart(order);
		model.addAttribute("order", order);
		model.addAttribute("listOrderItem", listOrderItem);
		model.addAttribute("orderItem", ci);
		model.addAttribute("adminBaseURL", adminBaseURL);

		if (adminBaseURL.equals("admin/order/insert")) {
			return new ModelAndView("admin/order/insert");
		} else {
			return new ModelAndView("admin/order/edit");
		}
	}

	// test controller
	public List<String> getAllProductName() {
		Session session = factory.getCurrentSession();
		String hql = "SELECT name FROM Product ORDER BY name";
		Query query = session.createQuery(hql);
		List<String> list = query.list();
		return list;
	}

	@RequestMapping(value = "searchForm", method = RequestMethod.GET)
	public String showSearch() {
		return "admin/test";
	}

//	@RequestMapping(value = "search", method = RequestMethod.GET, headers = "Accept=*/*")
//	public
//	@ResponseBody
//	List<String> search(@RequestParam("term") String query) {
//		System.out.println(query);
//	    List<String> result = new ArrayList<String>();
//
//	    for (String pro : getAllProductName()) {
//	    	if(pro.contains(query)) {
//	    		result.add(pro);
//	    	}    
//	    }
//	    System.out.println(result);
//	    return result;
//	}

	@Transactional
	@RequestMapping(value = "search", method = RequestMethod.GET)
	public @ResponseBody List<String> field1() {
		System.out.println(factory.openSession().createQuery("from Product").list());
		return getAllProductName();
	}
}