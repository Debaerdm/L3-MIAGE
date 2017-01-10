package microcobol;

import java.util.*;

public class IfInst extends Instruction {
	public IfInst(Condition c, List<Instruction> ti, List<Instruction> ei) {
		condition = c;
		theninst = ti;
		elseinst = ei;
	}

	public String toString() {
		String s = "IF " + condition.toString() + " THEN\n";
		for (Instruction i : theninst) {
			s += i.toString() + "\n";
		}
		if (elseinst != null) {
			s+="ELSE\n";
			for (Instruction i : theninst) {
				s += i.toString() + "\n";
			}
		}
		return s;
	}

	private Condition condition;
	private List<Instruction> theninst;
	private List<Instruction> elseinst;
}
