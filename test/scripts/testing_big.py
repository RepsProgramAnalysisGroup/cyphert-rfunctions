import glob, os, sys, datetime, time, subprocess, shutil, csv, re

root_dir = "/home/turetsky/cyphert-rfunctions"

alu = glob.glob(root_dir + "/test/examples/alu/*.smt2")
sprs = glob.glob(root_dir + "/test/examples/sprs/*.smt2")
wbmux = glob.glob(root_dir + "/test/examples/wbmux/*.smt2")

files = alu + sprs + wbmux

test = root_dir + "/rsat.native"

num_passed = 0
num_okayed = 0
num_tested = 0

def run_example (example, is_sat) :
  m = re.split('/', example)
  nicename = m[-1]
  res = subprocess.check_output([test] +["-wen_list"] + [example])
  if ("unknown" in res.decode("utf-8")):
    print ("OKAY on: " + example)
    global num_okayed
    num_okayed = num_okayed + 1
  elif (("sat" in res.decode("utf-8") and (not "unsat" in res.decode("utf-8")) and is_sat) or ("unsat" in res.decode("utf-8") and not is_sat)):
    global num_passed
    num_passed = num_passed + 1
    print ("PASS on: " + example)
  elif ("sat" in res.decode("utf-8") and not is_sat) :
    print ("UNSOUND on: " + example)
  else :
    print ("OKAY on: " + example)
    global num_okayed
    num_okayed = num_okayed + 1
  global num_tested
  num_tested = num_tested + 1



for fil in files:
  example_sat = True
  with open(fil, "r") as ex:
    if ('Solvable: true' not in ex.read()):
      example_sat = False
  run_example(fil, example_sat)

print("Number passed: " + str(num_passed)) 
print("Number okayed: " + str(num_okayed)) 
print("Number tested: " + str(num_tested)) 
