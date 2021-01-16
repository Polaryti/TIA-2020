package vacunas;

import java.util.ArrayList;
import org.opt4j.core.Objectives;
import org.opt4j.core.Objective.Sign;
import org.opt4j.core.problem.Evaluator;

public class VacunasEvaluator implements Evaluator<ArrayList<Integer>> {
	public Objectives evaluate(ArrayList<Integer> phenotype) {
		int coste = 0;
		int n_vol = 0;
		boolean[][] condicionGrupos = new boolean[3][3];

		for (int i = 0; i < phenotype.size(); i++) {
			coste += Data.matrizCostes[phenotype.get(i)][i];
			// Condición 2: Si la vacuna no es un placebo, se suma el número de voluntarios
			if (phenotype.get(i) < 2) {
				n_vol += Data.numeroVoluntarios[i];
			}
			
			// Condición 1: Todas las franjas de edad deben recibir al menos una vacuna de cada tipo
			int aux = 0;
			if (i >= 4 && i < 8) {
				aux = 1;
			} else if (i >= 8) {
				aux = 2;
			}
			condicionGrupos[phenotype.get(i)][aux] = true;
		}

		for (int i = 0; i < condicionGrupos.length; i++) {
			for (int j = 0; j < condicionGrupos[0].length; j++) {
				if (!condicionGrupos[i][j]) {
					coste = 999999;
					break;
				}
			}
		}

		Objectives objectives = new Objectives();
		objectives.add("Número de voluntarios", Sign.MAX, n_vol);
		objectives.add("Coste total", Sign.MIN, coste);
		return objectives;
	}
}