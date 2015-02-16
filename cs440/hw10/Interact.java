package hw10;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Map;

public class Interact extends Helper {

	@Override
	public void run() throws ClassNotFoundException, SQLException {
		super.run();
		before();
		method_1();
		method_2();
		method_3();
		method_5();
		System.out.println();
		method_7();
	}

	private void before() {
		try {
			Statement stmt = conn.createStatement();
			stmt.execute("drop table BASEBALL_TAB");
			stmt.execute("drop type BASEBALL_OBJ");
		} catch (SQLException e) {
			// table is already dropped
		}
	}

	private void method_1() throws SQLException, ClassNotFoundException {
		Map<String, Class<?>> map = conn.getTypeMap();
		map.put("BASEBALL_OBJ", Class.forName("hw10.Baseball"));
		Statement stmt = conn.createStatement();
		try {
			stmt.execute("create type BASEBALL_OBJ as object(Name varchar2(50), Age integer, Yr integer, battingPreference varchar2(2), battingAverage number);");
		} catch (SQLException e) {
			// already exists
		}
	}

	private void method_2() throws SQLException {
		Statement stmt = conn.createStatement();
		try {
			stmt.execute("create table BASEBALL_TAB of baseball_obj");
		} catch (SQLException e) {
			// already exists
		}
	}

	private void method_3() throws SQLException {
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt
				.executeQuery("select battingaverage, year, battingpref, name, age from ramorehead.mlb");
		PreparedStatement ps = conn
				.prepareStatement("insert into baseball_tab values(baseball_obj(?, ?, ?, ?, ?))");
		while (rs.next()) {
			ps.setString(1, rs.getString(4).trim());
			ps.setInt(2, rs.getInt(5));
			ps.setInt(3, rs.getInt(2));
			ps.setString(4, rs.getString(3));
			ps.setDouble(5, rs.getDouble(1));
			ps.executeQuery();
		}
	}

	private Baseball method_4(String name, String year) throws SQLException {
		String sql = "select * from baseball_tab where name = ? and yr = ?";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1, name);
		ps.setInt(2, Integer.parseInt(year));

		ResultSet rs = ps.executeQuery();
		rs.next();
		Baseball bb = new Baseball(rs.getString("NAME"), rs.getInt("AGE"),
				rs.getInt("YR"), rs.getString("BATTINGPREFERENCE"),
				rs.getDouble("BATTINGAVERAGE"));
		return bb;
	}

	private void method_5() throws SQLException {
		Baseball bb = method_4("Ty Cobb", "1922");
		System.out.println(bb.toString());
	}

	private void method_6(int n) throws SQLException {
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt
				.executeQuery("select name, age, yr, battingpreference, battingaverage, rownum from "
						+ "(select name, age, yr, battingpreference, battingaverage from baseball_tab order by battingaverage desc) "
						+ "where rownum <= " + n);
		while (rs.next()) {
			Baseball bb = method_4(rs.getString("NAME"),
					Integer.toString(rs.getInt("YR")));
			System.out.println(bb.toString());
		}
	}

	private void method_7() throws SQLException {
		method_6(10);
	}

	public static void main(String[] args) throws SQLException,
			ClassNotFoundException {
		new Interact().run();

	}

}
