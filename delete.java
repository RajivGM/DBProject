import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;


@WebServlet("/delete")
public class delete extends HttpServlet {
    public void service(HttpServletRequest req, HttpServletResponse res) throws IOException {
        HttpSession ses = req.getSession();
        String sid = (String) ses.getAttribute("temp");
        final String id = (String) ses.getAttribute("id");
        final String pid = req.getParameter("pid");
        System.out.println(pid);
        boolean check = false;
        Connection conn = null;
        Statement stmt = null;
        if (id != null && sid != null) {
            try {
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost/learn", "root", "dancebar123");
            } catch (Exception e) {
                System.out.println("Exception has Occurred");
            }
            String sql = "delete from Product where id='" + id + "' and pid='" + pid + "'";
            try {
                assert conn != null;
                stmt = conn.createStatement();
                check = stmt.execute(sql);
            } catch (SQLException e) {
                e.printStackTrace();
            }
            res.sendRedirect("productManager");
        } else {
                res.sendRedirect("index.html");
        }
    }
}
