import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Type;
import java.sql.*;
import java.util.Random;

@WebServlet("/enrollConfirmation")
public class enrollConfirmation extends HttpServlet {
    public void service(HttpServletRequest req, HttpServletResponse res) throws IOException {
        String val=req.getParameter("enrollData");
        System.out.println(val);
        Gson gs=new Gson();
        JsonParser p=new JsonParser();
        JsonObject obj=(JsonObject) p.parse(val);
        boolean check=true;
        String id = null;
        try{
            while(check){
                id=create();
                check=checkP(id);
            }
            obj.addProperty("id",id);
            RealData dbd=gs.fromJson(String.valueOf(obj), (Type) RealData.class);
            sendData(dbd);
        }
        catch(Exception e){
            e.printStackTrace();
        }
        PrintWriter pwrite=res.getWriter();
        pwrite.println(obj);
    }

    public static boolean checkP(String data) throws ClassNotFoundException, SQLException {
        Connection conn=null;
        Statement stmt=null;
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost/learn","root","dancebar123");
        stmt=conn.createStatement();
        String sql="select * from manager where id='"+data+"'";
        ResultSet rs=stmt.executeQuery(sql);
        return rs.next();
    }

    public static String create(){
        Random ran=new Random();
        int i=0;
        char[] randomId=new char[5];
        boolean check=false;
        while(i<5){
            int cha=ran.nextInt(122);
            if(cha>=97 && cha<=122){
                randomId[i++]=(char)cha;
            }
        }
        return new String(randomId);
    }

        public static boolean sendData(RealData a) throws Exception{
            Connection conn = null;
            Statement stmt = null;
            Class.forName("com.mysql.jdbc.Driver");
            System.out.println("connecting:");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/learn","root","dancebar123");
            System.out.println("getting statement:");
            stmt = conn.createStatement();
            String sqlstmt = "insert into manager values('"+a.email+"','"+a.password+"','"+a.first+"','"+a.last+"','"+a.address+"','"+a.location+"','"+a.id+"')";
            return stmt.execute(sqlstmt);

    }
}

class RealData{
    public String email, password,first,last,address,location,id;
}
