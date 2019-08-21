import glob, os, sys, datetime, time, subprocess, shutil, csv, re

alu = glob.glob("/home/turetsky/cyphert-rfunctions/test/examples/alu/*.smt2")
sprs = glob.glob("/home/turetsky/cyphert-rfunctions/test/examples/sprs/*.smt2")
wbmux = glob.glob("/home/turetsky/cyphert-rfunctions/test/examples/wbmux/*.smt2")

output_root = "/home/turetsky/cyphert-rfunctions/test/output"


tool_cmds = {
  "rsat":["/home/turetsky/cyphert-rfunctions/rsat.native"],
  "stp":["/home/turetsky/stp/build/stp"],
  "boolector":["/home/turetsky/boolector/build/bin/boolector"],
  "z3":["/home/turetsky/z3-z3-4.7.1/build/z3"]
}

timeout = 60.0

timestamp = datetime.datetime.now().strftime("%Y/%m/%d at %H:%M:%S")

def make_dir (dir_path) :
  if not os.path.exists(dir_path):
    os.makedirs(dir_path)
  else :
    shutil.rmtree(dir_path)
    os.makedirs(dir_path)

def run_example (example, logpath, result_writer):
  m = re.split('/', example)
  nicename = m[-1]
  row = [example]
  for tool in tool_cmds:
    logname = logpath +nicename + "."+ tool + ".out"
    tool_time = -1.0
    with open(logname, "w") as logfile:
      cmd = tool_cmds[tool] + [example]
      print (" ".join(cmd), file=logfile)
      print ("", file=logfile)
      logfile.flush()
      child = subprocess.Popen(cmd, stdout=logfile, stderr=subprocess.STDOUT)
      starttime = time.time()
      while True :
        tool_time = time.time() - starttime
        if child.poll() is not None :
          res = "OK"
          break
        if tool_time >= timeout :
          res = "timeout"
          break
    result = "sat"
    with open(logname, "r") as logfile:
      if "unknown" in logfile.read() :
        result = "unknown"
    print (tool + ": " + result + " time: " + str(tool_time))
    row = row + [result]
    row = row + [str(tool_time)]
  result_writer.writerow(row)

result_alu = csv.writer(open("alu.csv", "w"))
result_alu.writerow(['file', 'rsat res', 'rsat time', 'stp res', 'stp time', 'boolector res', 'boolector time', 'z3 res', 'z3 time'])
make_dir(output_root + "/alu/")
for fil in alu:
  with open(fil, "r") as ex:
    if ('Solvable: true' not in ex.read()):
      continue
  run_example(fil, output_root + "/alu/", result_alu)
  
result_sprs = csv.writer(open("sprs.csv", "w"))
result_sprs.writerow(['file', 'rsat res', 'rsat time', 'stp res', 'stp time', 'boolector res', 'boolector time', 'z3 res', 'z3 time'])
make_dir(output_root + "/sprs/")
for fil in sprs:
  with open(fil, "r") as ex:
    if ('Solvable: true' not in ex.read()):
      continue
  run_example(fil, output_root + "/sprs/", result_sprs)
  
result_wbmux = csv.writer(open("wbmux.csv", "w"))
result_wbmux.writerow(['file', 'rsat res', 'rsat time', 'stp res', 'stp time', 'boolector res', 'boolector time', 'z3 res', 'z3 time'])
make_dir(output_root + "/wbmux/")
for fil in wbmux:
  with open(fil, "r") as ex:
    if ('Solvable: true' not in ex.read()):
      continue
  run_example(fil, output_root + "/wbmux/", result_wbmux)
  
