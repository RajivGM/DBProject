import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/newProduct")
public class newProduct extends HttpServlet {
    public void service(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String pid=request.getParameter("pid");
        HttpSession ses=request.getSession();
        ResultSet rs=null;
        final String id=(String) ses.getAttribute("id");
        String sid=(String) ses.getAttribute("temp");
        response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
        if(id!=null && sid!=null) {
            response.sendRedirect("newProduct.jsp");
        Connection conn=null;
        PreparedStatement stmt=null,stmt1=null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/learn","root","dancebar123");
            String sql1="delete from deleteHistory where id=? and pid=?";
            stmt=conn.prepareStatement(sql1);
            stmt.setString(1,id);
            stmt.setString(2,pid);
            stmt.execute();
            String sql2="insert into Product values(?,?)";
            stmt1=conn.prepareStatement(sql2);
            stmt1.setString(1,id);
            stmt1.setString(2,pid);
            stmt1.execute();
        } catch (Exception e) {
            e.printStackTrace();
        }
        }else{
            response.sendRedirect("index.html");
        }
    }
}
