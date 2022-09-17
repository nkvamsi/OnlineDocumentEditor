

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/ResetServlet")
public class ResetServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ResetServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
			String email=request.getParameter("email");
			String answer=request.getParameter("answer");
			String new_password=request.getParameter("new_password");
			String confirm_password=request.getParameter("confirm_password");
			if (!new_password.equals(confirm_password)) {
				PrintWriter out = response.getWriter();
				out.println("<script type=\"text/javascript\">");
				out.println("alert('password or confirmation password does not match');");
				out.println("location='verify.html';");
				out.println("</script>");
			}
			try {
				PrintWriter out = response.getWriter();
				out.println("<script type=\"text/javascript\">");
				int user_id = Reset.check(email,answer);
				if(user_id>0) {
				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "root");
	
				PreparedStatement ps = con.prepareStatement("update user set pass = hex(aes_encrypt(?,'mini-project')) where email = ?");
				ps.setString(1, new_password);
				ps.setString(2, email);
				ps.execute();
				con.close();
				ps.close();
				out.println("alert('Password Changed Successfully.');");
				out.println("location='index.jsp';");
				}
				else {
				out.println("alert('Security Answer is incorrect. try again.');");
				out.println("location='verify.html';");

				}
				out.println("</script>");
			}
				catch (Exception e) {
					e.printStackTrace();
				}
	}

}
