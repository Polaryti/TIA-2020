package vacunas;

import java.util.Random;
import org.opt4j.core.genotype.IntegerGenotype;
import org.opt4j.core.problem.Creator;

public class VacunasCreator implements Creator<IntegerGenotype> {
	public IntegerGenotype create() {

		IntegerGenotype genotype = new IntegerGenotype(0, Data.NUM_VACUNAS - 1);
		genotype.init(new Random(), Data.NUM_GRUPOS);

		return genotype;
	}
}
