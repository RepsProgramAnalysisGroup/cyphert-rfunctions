import glob, os, sys, datetime, time, subprocess, shutil, csv, re

root_dir = "/home/turetsky/cyphert-rfunctions"

alu = glob.glob(root_dir + "/test/examples/alu/*.smt2")
sprs = glob.glob(root_dir + "/test/examples/sprs/*.smt2")
wbmux = glob.glob(root_dir + "/test/examples/wbmux/*.smt2")

files = alu + sprs + wbmux

test = root_dir + "/rsat.native"

num_passed_rewrite = 0
num_passed_assign = 0
num_tested = 0

def run_example (example) :
  m = re.split('/', example)
  nicename = m[-1]
  res = subprocess.check_output([test] +['-test'] + ['rewrite']+ [example])
  if ("PASS" in res.decode("utf-8")):
    global num_passed_rewrite
    num_passed_rewrite = num_passed_rewrite + 1
  else :
    print ("Failed rewrite on: " + example)
  res = subprocess.check_output([test] +['-test'] + ['assign']+ [example])
  if ("PASS" in res.decode("utf-8")):
    global num_passed_assign
    num_passed_assign = num_passed_assign + 1
  else :
    print ("Failed assign on: " + example)
  global num_tested
  num_tested = num_tested + 1



for fil in files:
  with open(fil, "r") as ex:
    if ('Solvable: true' not in ex.read()):
      continue
  run_example(fil)

print("Number passed rewrite: " + str(num_passed_rewrite)) 
print("Number passed assign: " + str(num_passed_assign)) 
print("Number tested: " + str(num_tested)) 
