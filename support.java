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


@WebServlet("/support")
public class support extends HttpServlet {
    public void service(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        HttpSession ses=req.getSession();
        String sid= (String) ses.getAttribute("temp");
        String id=(String) ses.getAttribute("id");
        Connection  conn=null;
        Statement stmt=null;
        ResultSet rs2=null,rs=null,rs1=null,rs0=null;
        CallableStatement stm1=null,stmt2=null,stmt0=null;
        PreparedStatement stmt3=null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/learn","root","dancebar123");
            String sql0="{call sp0(?)}";
            String sql="{call sp1()}";
            String sql2="{call sp2(?)}";
            String sql3="select A.pid,B.name from deleteHistory A,prodDesc B where A.pid=B.pid and A.id=?";
            stmt3=conn.prepareStatement(sql3);
            stmt3.setString(1,id);
            rs2=stmt3.executeQuery();
            stmt0=conn.prepareCall(sql0);
            stmt0.setString(1,id);
            stm1 =conn.prepareCall(sql);
            stmt2=conn.prepareCall(sql2);
            stmt2.setString(1,id);
            rs0=stmt0.executeQuery();
            rs=stm1.executeQuery();
            rs1=stmt2.executeQuery();
//            while(rs0.next()){
//                String email=rs0.getString("email");
//                arr0.add(new managerDetails(email,rs0.getString("password"),rs0.getString("first"),rs0.getString("last"),rs0.getString("address"),rs0.getString("location"),rs0.getString("id")));
//            }
//            while(rs.next()){
//                    arr.add(new supportProduct(rs.getString("Sname"),rs.getString("count"),rs.getString("location")));
//            }
//            while (rs1.next()){
//                    arr2.add(new supportProduct(rs1.getString("Sname"),rs1.getString("count"),rs1.getString("location")));
//            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        if(id==null || sid==null){
            res.sendRedirect("index.html");
        }else{
            RequestDispatcher rd=req.getRequestDispatcher("support.jsp");
            req.setAttribute("rs0",rs0);
            req.setAttribute("rs",rs);
            req.setAttribute("rs1",rs1);
            req.setAttribute("rs2",rs2);
            rd.forward(req,res);
        }
    }
}
