package microcobol;

import java.util.*;

public class WorkingSect {
	public WorkingSect(List<Data> ld) {
		datas = ld;
	}

	public String toString() {
		String s = "WORKING-STORAGE SECTION.\n";
		for (Data d : datas) {
			s.concat(d.toString());
		}
		return s;
	}

	private List<Data> datas;
}
