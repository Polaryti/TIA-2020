package vacunas;

import org.opt4j.core.problem.ProblemModule;

public class VacunasModule extends ProblemModule {
	protected void config() {
		bindProblem(VacunasCreator.class, VacunasDecoder.class, VacunasEvaluator.class);
	}
}
