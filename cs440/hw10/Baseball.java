package hw10;

import java.sql.SQLException;

import oracle.jdbc.driver.OracleConnection;
import oracle.sql.CustomDatum;
import oracle.sql.CustomDatumFactory;
import oracle.sql.Datum;
import oracle.sql.STRUCT;
import oracle.sql.StructDescriptor;

public class Baseball implements CustomDatum, CustomDatumFactory {
	String name, battingPreference;
	int age, year;
	double battingAverage;

	public Baseball(String name, int age, int year, String battingPreference,
			double battingAverage) {
		super();
		this.name = name;
		this.age = age;
		this.year = year;
		this.battingPreference = battingPreference;
		this.battingAverage = battingAverage;

	}

	public Object[] getObjArray() {
		return new Object[] { name, age, year, battingPreference,
				battingAverage };

	}

	@Override
	public Datum toDatum(OracleConnection arg0) throws SQLException {
		StructDescriptor descriptor = new StructDescriptor(
				"JRILE.BASEBALL_OBJ", arg0);
		return new STRUCT(descriptor, arg0, getObjArray());
	}

	@Override
	public CustomDatum create(Datum arg0, int arg1) throws SQLException {
		Object[] attributes = ((STRUCT) arg0).getAttributes();
		return new Baseball((String) attributes[0], (int) attributes[1],
				(int) attributes[2], (String) attributes[3],
				(Double) attributes[4]);

	}

	@Override
	public String toString() {
		return String.format("%s\t%d\t%d\t%S\t%e", name, age, year, battingPreference, battingAverage);
	}

}
