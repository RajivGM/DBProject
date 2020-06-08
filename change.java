import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Statement;

@WebServlet("/change")
public class change extends HttpServlet {
    public void service(HttpServletRequest req, HttpServletResponse res) throws IOException {
        HttpSession ses=req.getSession();
        final String id= (String) ses.getAttribute("id");
        final String pid=(String) req.getParameter("pid");
        String sid=(String) ses.getAttribute("temp");
        String name=req.getParameter("name");
        String color=req.getParameter("color");
        String connection=req.getParameter("connection");
        String type=req.getParameter("type");
        String desc=req.getParameter("desc");
        Connection conn = null;
        PreparedStatement stmt=null;
        if(id!=null && sid!=null){
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/learn","root","dancebar123");
            String sql="update prodDesc set name=?,color=?,connection=?,type=?,Description=? where pid='"+pid+"'";
            stmt=conn.prepareStatement(sql);
            stmt.setString(1,name);
            stmt.setString(2,color);
            stmt.setString(3,connection);
            stmt.setString(4,type);
            stmt.setString(5,desc);
            stmt.execute();
        } catch (Exception e) {
            e.printStackTrace();
        }
            res.sendRedirect("productManager");
        }else{
            res.sendRedirect("index.html");
        }
    }
}
