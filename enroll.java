import com.google.gson.Gson;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.*;
import java.util.Scanner;

@WebServlet("/enroll")
public class enroll extends HttpServlet {
    static final String USER = "root";
    static final String PASS = "dancebar123";
    public void service(HttpServletRequest req, HttpServletResponse res) throws IOException {
            PrintWriter pwrite=res.getWriter();
            InputStream istream = req.getInputStream();
            StringBuffer indata = new StringBuffer();
            Scanner in = new Scanner(istream);
            while (in.hasNext()) {
                indata.append(in.nextLine());
            }
            Gson gson = new Gson();
            dataObj a = gson.fromJson(String.valueOf(indata), dataObj.class);
            try{
                if (verification(a)) {
                    if(!email(a.email)) {
//                        sendData(a);
                        pwrite.println("SUCCESSFUL");
                    }else{
                        pwrite.println("Invalid EMAIL");
                    }
                }else{
                    pwrite.println("PLEASE CHECK THE DETAILS");
                }
            }catch (Exception e){
                e.printStackTrace();
            }
        }

    static boolean verification(dataObj a) throws SQLException, ClassNotFoundException {
        int Nflag = 0, Pflag = 0, Eflag=0;
            if (a.first.matches("^[a-zA-Z]*$")) Nflag =1;
            if(strongPass(a.password)) Pflag =1;
        return (Nflag == 1) && (Pflag == 1);
        }

    static boolean email(String email) throws ClassNotFoundException, SQLException {
        Connection conn=null;
        Statement stmt=null;
        Class.forName("com.mysql.jdbc.Driver");
        System.out.println("email connecting");
        conn=DriverManager.getConnection("jdbc:mysql://localhost/learn","root","dancebar123");
        stmt=conn.createStatement();
        String sql="select first from manager where email='"+email+"'";
        ResultSet rs=stmt.executeQuery(sql);
        return rs.next();
    }

    static boolean strongPass(String ps) {
        boolean hasUppercase = false;
        boolean hasLowercase = false;
        boolean hasDigit = false;
        boolean hasSymbol = false;
        if (ps.length() >= 8) {
            for (int i = 0; i < ps.length(); i++) {
                char x = ps.charAt(i);
                if (Character.isLowerCase(x)) hasLowercase = true;
                else if (Character.isUpperCase(x)) hasUppercase = true;
                else if (Character.isDigit(x)) hasDigit = true;
                else if (Character.isDefined(x)) hasSymbol = true;
                if (hasDigit && hasLowercase && hasSymbol && hasUppercase) return true;
            }
        }
            return false;
    }

//    public static boolean sendData(dataObj a) throws SQLException,Exception{
//            Connection conn = null;
//            Statement stmt = null;
//            String user,pass;
//            Class.forName("com.mysql.jdbc.Driver");
//            System.out.println("connecting:");
//            conn = DriverManager.getConnection("jdbc:mysql://localhost/learn",USER,PASS);
//            System.out.println("getting statement:");
//            stmt = conn.createStatement();
//            String sqlstmt = "insert into emp values('"+a.first+"','"+a.last+"')";
//            stmt.execute(sqlstmt);
//        return true;
//    }
}

class dataObj{
    public String id,email, password,first,last,address,location;
}