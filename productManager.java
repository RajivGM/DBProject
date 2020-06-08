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
import Product.*;

@WebServlet("/productManager")
public class productManager extends HttpServlet {
    public void service(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession ses=request.getSession();
        final String id=(String)ses.getAttribute("id");
        final String sid=(String) ses.getAttribute("temp");
        if(id==null || sid==null){
            response.sendRedirect("index.html");
        }else{
            try {
                ArrayList<Product> arr=getProduct(id);
                ses.setAttribute("product",arr);
            } catch (SQLException e) {
                e.printStackTrace();
            }
            RequestDispatcher rd=request.getRequestDispatcher("productManage.jsp");
            rd.forward(request,response);
//            response.sendRedirect("productManage.jsp");
        }
    }
    public ArrayList<Product> getProduct(String id) throws SQLException {
        Connection conn = null;
        ArrayList<Product> arr=new ArrayList<>();
        Statement stmt = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/learn", "root", "dancebar123");
        }catch(Exception e){
            System.out.println("Exception has Occurred");
        }
        String sql="Select d.name,p.pid from Product p,ProdDesc d where p.pid=d.pid and id='"+id+"'";
        stmt=conn.createStatement();
        ResultSet rs=stmt.executeQuery(sql);
        while (rs.next()){
            arr.add(new Product(rs.getString("name"),rs.getString("pid")));
        }
       return arr;
    }
}


