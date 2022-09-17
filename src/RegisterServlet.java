	
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
//import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public RegisterServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out = response.getWriter();
		out.println("<script type=\"text/javascript\">");
		String email = request.getParameter("email");
		String pass = request.getParameter("ps");
		String conpass = request.getParameter("cps");
		String name = request.getParameter("name");
		String question = request.getParameter("question");
		String answer = request.getParameter("answer");
		if (email.equals("") || pass.equals("") || question.equals("") || answer.equals("")){
			out.println("alert('Fill all the form fields');");
			out.println("location='Register.html';");

		}
		else if (!pass.equals(conpass)) {
			out.println("alert('password or confirmation password does not match');");
			out.println("location='Register.html';");
		}
		else {
			try {
				Class.forName("com.mysql.jdbc.Driver");
				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "root");

				PreparedStatement ps = con.prepareStatement("insert into user (email,pass,name,question,answer) values (?,hex(aes_encrypt(?,'mini-project')),?,?,hex(aes_encrypt(?,'mini-project')))");
				ps.setString(1, email);
				ps.setString(2, pass);
				ps.setString(3, name);
				ps.setString(4, question);
				ps.setString(5, answer);
				ps.execute();
				con.close();
				out.println("alert('Account Created Successfully.');");
				out.println("location='index.jsp';");
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		out.println("</script>");
//		response.sendRedirect("index.jsp");

	}
}
