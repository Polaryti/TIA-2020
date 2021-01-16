package vacunas;

import java.util.ArrayList;

import org.opt4j.core.genotype.IntegerGenotype;
import org.opt4j.core.problem.Decoder;

public class VacunasDecoder implements Decoder<IntegerGenotype, ArrayList<Integer>> {
	public ArrayList<Integer> decode(IntegerGenotype genotype) {
		ArrayList<Integer> phenotype = new ArrayList<Integer>();

		// IMPORTANTE: Aqui se podría poner código para validar que el fenotipo cumpla
		// con ciertas restricciones
		for (int i = 0; i < genotype.size(); i++) {
			phenotype.add(genotype.get(i));
		}
		return phenotype;
	}
}
