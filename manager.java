import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.Enumeration;


@WebServlet("/manager")
public class manager extends HttpServlet {
    public void service(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        res.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
        String id=req.getParameter("id").trim();
        String password=req.getParameter("password");
        HttpSession ses=req.getSession();
        boolean check=false;
        try{
           check=checkDB(id,password);
        }catch(Exception e){
            e.printStackTrace();
        }
        if(check){
            ses.setAttribute("id",id);
            res.sendRedirect("product.jsp");
        }else{
            res.sendRedirect("manager.jsp");
        }
    }

    public static boolean checkDB(String id,String password) throws ClassNotFoundException, SQLException,NullPointerException {
        Connection con=null;
        Statement stmt=null;
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost/learn","root","dancebar123");
        String sql="select id,password from manager where (id='"+id+"'and password='"+password+"')";
        stmt=con.createStatement();
        ResultSet rs=stmt.executeQuery(sql);
        return rs.next();
    }
}

class ManagerInfo{
    String id;
    String password;

    public ManagerInfo(String id, String password) {
        this.id = id;
        this.password = password;
    }
}
