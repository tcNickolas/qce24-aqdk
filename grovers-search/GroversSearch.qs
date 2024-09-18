import Microsoft.Quantum.Convert.IntAsDouble;
import Microsoft.Quantum.Math.*;

operation AlternatingBitPairsOracle(qs : Qubit[]) : Unit {
    use minus = Qubit();
    within {
        X(minus);
        H(minus);
    } apply {
        within {
            for q in qs[0..2...] {
                X(q);
            }
        } apply {
            Controlled X(qs, minus);
        }
        within {
            for q in qs[1..2...] {
                X(q);
            }
        } apply {
            Controlled X(qs, minus);
        }
    }
}

operation AlternatingBitPairsOracle2(qs : Qubit[]) : Unit {
    within {
        for q in qs[0..2...] {
            X(q);
        }
    } apply {
        Controlled Z(qs[1...], qs[0]);
    }
    within {
        for q in qs[1..2...] {
            X(q);
        }
    } apply {
        Controlled Z(qs[1...], qs[0]);
    }
}

operation AlternatingBitPairsOracle3(qs : Qubit[]) : Unit {
    within {
        for i in 0 .. Length(qs) - 2 {
            CNOT(qs[i], qs[i + 1]);
        }
    } apply {
        Controlled Z(qs[2...], qs[1]);
    }
}

operation GroversSearch(
    n : Int, 
    oracle : Qubit[] => Unit, 
    statePrep : Qubit[] => Unit is Adj,
    iterations : Int
) : Result[] {
    use qs = Qubit[n];
    // Prepare initial state: an even superposition of all basis states.
    statePrep(qs);

    for i in 1 .. iterations {
        // Apply the oracle.
        oracle(qs);
        
        // Reflect about the mean.
        within {
            Adjoint statePrep(qs);
            ApplyToEachA(X, qs);
        } apply {
            Controlled Z(qs[...n - 2], qs[n - 1]);
        }
    }
    return MResetEachZ(qs);
}

operation Main() : Result[] {
    let n = 3;
    let oracle = AlternatingBitPairsOracle3;
    let statePrep = ApplyToEachA(H, _);
    let iter = Round(PI() / 4.0 / ArcSin(2.0 / Sqrt(2.0^IntAsDouble(n))) - 0.5);
    return GroversSearch(n, oracle, statePrep, iter);
}