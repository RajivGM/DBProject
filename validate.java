import javax.servlet.RequestDispatcher;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Statement;

@WebServlet("/validate")
public class validate extends HttpServlet {
    public void service(HttpServletRequest req, HttpServletResponse res){
        HttpSession ses=req.getSession();
        ses.setAttribute("temp","A");
        String id=(String)ses.getAttribute("id");
        String password=req.getParameter("password");
        String page=req.getParameter("page");
        Connection conn=null;
        PreparedStatement stmt=null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/learn", "root", "dancebar123");
            String sql="Select * from manager where id=? and password=?";
            stmt=conn.prepareStatement(sql);
            stmt.setString(1,id);
            stmt.setString(2,password);
            if(id==null){
                res.sendRedirect("index.html");
            }else {
                if (stmt.executeQuery().next()) {
                    if(page.equalsIgnoreCase("S")){
                        RequestDispatcher rd=req.getRequestDispatcher("support");
                        rd.forward(req,res);
                    }else if(page.equalsIgnoreCase("PM")){
                        RequestDispatcher rd=req.getRequestDispatcher("productManager");
                        rd.forward(req,res);
                    }
                }else{
                    res.sendRedirect("product.jsp");
                }
            }
        }catch(Exception e){
                e.printStackTrace();
        }
    }
}
