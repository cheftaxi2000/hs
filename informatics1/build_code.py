"""Compile and run every code/*.cpp, store stdout in out/NAME.txt (and stdin in out/NAME.in).
err_*.cpp are expected NOT to compile: the compiler message is stored instead."""
import glob, os, subprocess, sys, re
os.chdir(os.path.dirname(os.path.abspath(__file__)))
os.makedirs("out", exist_ok=True)
only = sys.argv[1:]
bad = 0
for f in sorted(glob.glob("code/*.cpp")):
    name = os.path.basename(f)[:-4]
    if only and name not in only: continue
    inf = f"code/{name}.in"
    inp = open(inf).read() if os.path.exists(inf) else ""
    open(f"out/{name}.in", "w").write(inp)
    exe = f"/tmp/inf_{name}"
    std = "-std=c++17"
    r = subprocess.run(["g++", std, "-Wall", "-Wno-unused", "-o", exe, f], capture_output=True, text=True)
    if name.startswith("err_"):
        if r.returncode == 0: print("EXPECTED ERROR BUT COMPILED:", name); bad += 1
        msg = r.stderr.replace("code/" + name + ".cpp", "main.cpp")
        # keep first error block only, strip long tails
        lines = [l for l in msg.splitlines() if "error" in l or l.startswith("  ") or "^" in l or "|" in l]
        errs = []
        cnt = 0
        for l in msg.splitlines():
            if "error:" in l: cnt += 1
            if cnt > 1: break
            errs.append(l)
        txt = "\n".join(errs[:6]); open(f"out/{name}.txt", "w").write(txt + "\n"); continue
    if name.startswith("rt_"):
        p = subprocess.run(["stdbuf", "-o0", exe], input=inp, capture_output=True, text=True, timeout=10)
        txt = (p.stdout + p.stderr).replace(f"inf_{name}", "main").replace("code/" + name + ".cpp", "main.cpp")
        open(f"out/{name}.txt", "w").write(txt); continue
    if r.returncode != 0:
        print("COMPILE FAIL", name); print(r.stderr[:1500]); bad += 1; continue
    if r.stderr.strip(): print("WARN", name, r.stderr[:600])
    try:
        p = subprocess.run([exe], input=inp, capture_output=True, text=True, timeout=10)
    except subprocess.TimeoutExpired:
        print("TIMEOUT", name); bad += 1; continue
    open(f"out/{name}.txt", "w").write(p.stdout)
print("done", bad, "problems")
