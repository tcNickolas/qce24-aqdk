import Microsoft.Quantum.Diagnostics.DumpMachine;
import Microsoft.Quantum.Unstable.StatePreparation.PreparePureStateD;
import StatePrep.StatePreparation.PrepArbitrary;

operation Main() : Unit {
    use qs = Qubit[2];
    let amps = [0.48, 0.36, -0.64, -0.48];
    // PreparePureStateD(amps, qs);
    PrepArbitrary(qs, amps);
    DumpMachine();
    ResetAll(qs);
}
