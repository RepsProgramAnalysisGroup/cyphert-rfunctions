import glob, os, sys, datetime, time, subprocess, shutil, csv, re

root_dir = "/home/turetsky/cyphert-rfunctions"

example_dir = root_dir + "/test/examples/"

dirs = ["alu", "sprs", "wbmux"]

alu = glob.glob(example_dir + "/alu/*.smt2")
sprs = glob.glob(example_dir + "/sprs/*.smt2")
wbmux = glob.glob(example_dir + "/wbmux/*.smt2")

output_root = root_dir + "/test/output"


tool_cmds = {
  "rsat":[root_dir + "/rsat.native"],
  "rsat2":[root_dir + "/rsat2.native"],
  "stp":["/home/turetsky/stp/build/stp"],
  "boolector":["/home/turetsky/boolector/build/bin/boolector"],
  "z3":["/home/turetsky/z3-Z3-4.8.5/build/z3"]
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
  row = [nicename]
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


for direc in dirs:
  with open(direc+".csv", 'w') as csv_out:
    csv_writer = csv.writer(csv_out)
    row = ['file']
    for tool in tool_cmds:
      row = row + [tool + ' res', tool + ' time']
    csv_writer.writerow(row)
    files = glob.glob(example_dir + direc + "/*.smt2")
    for fil in files:
      with open(fil, 'r') as ex:
        if ('Solvable: true' not in ex.read()):
          continue
      run_example(fil, output_root + "/" + direc + "/", csv_writer)

