from collections import defaultdict
import qsharp

qsharp.init(project_root=".")

n = 1
probs = [0.36, 0.64]

freqs = defaultdict(int)
for _ in range(100):
    res = qsharp.eval(f"RunStatePrep.GenerateRandomBits({n}, {probs})")
    bits = ['1' if r == qsharp.Result.One else '0' for r in res]
    num = int("".join(bits), 2)
    freqs[num] += 1
print(freqs)