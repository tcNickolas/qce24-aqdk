from math import sqrt
import pytest
import qsharp

def run_test_prep_multi_qubit(n, a):
  qsharp.init(project_root='.')
  qsharp.eval(f"use qs = Qubit[{n}]; StatePrep.StatePreparation.PrepArbitrary(qs, {a});")
  state = qsharp.dump_machine().as_dense_state()
  assert state == pytest.approx(a)


def test_basis_states():
  for n in range(1, 4):
    for basis in range(2 ** n):
      a = [0.] * 2 ** n
      a[basis] = 1.
    run_test_prep_multi_qubit(n, a)


@pytest.mark.parametrize("a",
    [ [0.5, 0.5, 0.5, 0.5],
      [-0.5, 0.5, 0.5, -0.5],
      [0.5, -0.5, 0.5, 0.5],
      [0.36, 0.48, 0.64, -0.48],
      [1. / sqrt(3.), -1. / sqrt(3.), 1. / sqrt(3.), 0.]
    ])
def test_prep_two_qubits(a):
  run_test_prep_multi_qubit(2, a)