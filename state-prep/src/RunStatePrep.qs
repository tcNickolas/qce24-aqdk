import Microsoft.Quantum.Math.Sqrt;
import Microsoft.Quantum.Arrays.Mapped;
import Microsoft.Quantum.Diagnostics.DumpMachine;
import Microsoft.Quantum.Unstable.StatePreparation.PreparePureStateD;
import StatePrep.StatePreparation.PrepArbitrary;

operation Main() : Unit {
    use qs = Qubit[2];
    let amps = [0.48, 0.36, -0.64, -0.48];
    PreparePureStateD(amps, qs);
    DumpMachine();
    ResetAll(qs);
}


operation GenerateRandomBits(n : Int, probs : Double[]) : Result[] {
    let amps = Mapped(Sqrt, probs);
    use qs = Qubit[n];
    PreparePureStateD(amps, qs);
    return MResetEachZ(qs);
}