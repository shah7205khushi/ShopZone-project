package project;
import java.sql.Connection;
import java.sql.DriverManager;
public class connection {
	public static Connection getcon()
	{
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/shop_zone","root","");
			return con;
		}catch(Exception e)
		{
			System.out.print(e);
			return null;
		}
	}
}
