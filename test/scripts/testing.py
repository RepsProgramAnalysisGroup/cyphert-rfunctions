import glob, os, sys, datetime, time, subprocess, shutil, csv, re

alu = glob.glob("/home/turetsky/cyphert-rfunctions/test/examples/alu/*.smt2")
sprs = glob.glob("/home/turetsky/cyphert-rfunctions/test/examples/sprs/*.smt2")
wbmux = glob.glob("/home/turetsky/cyphert-rfunctions/test/examples/wbmux/*.smt2")

files = alu + sprs + wbmux

test = "/home/turetsky/cyphert-rfunctions/test.native"

num_tested = 0
num_passed = 0

def run_example (example) :
  m = re.split('/', example)
  nicename = m[-1]
  res = subprocess.check_output([test] + [example])
  if ("PASS" in res.decode("utf-8")):
    global num_passed
    num_passed = num_passed + 1
  global num_tested
  num_tested = num_tested + 1


for fil in files:
  with open(fil, "r") as ex:
    if ('Solvable: true' not in ex.read()):
      continue
  run_example(fil)

print("Number passed: " + str(num_passed)) 
print("Number tested: " + str(num_tested)) 
