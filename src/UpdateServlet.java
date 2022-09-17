

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class UpdateServlet
 */
@WebServlet("/UpdateServlet")
public class UpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateServlet() {
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
		try {
			Class.forName("com.mysql.jdbc.Driver");
			String name = request.getParameter("title");
			String tag = request.getParameter("tag");
			String code = request.getParameter("content");
			int docId = Integer.parseInt(request.getParameter("docId"));
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "root");

			PreparedStatement ps = con.prepareStatement("update document set name= ? , tag= ? , code= ? where id = ?");
			ps.setString(1, name);
			ps.setString(2, tag);
			ps.setString(3, code);
			ps.setInt(4, docId);
			ps.execute();
			con.close();
			response.sendRedirect("ViewDocument.jsp?id="+docId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

}
