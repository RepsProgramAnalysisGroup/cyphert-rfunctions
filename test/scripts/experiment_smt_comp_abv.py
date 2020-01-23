import glob, os, sys, datetime, time, subprocess, shutil, csv, re
from random import shuffle

root_dir = "/home/turetsky/cyphert-rfunctions"

example_dir = "/home/turetsky/QF_ABV/"

#dirs = ["2018-Mann", "2019-Mann", "2019-Wolf-fmbench","bench_ab", "bmc-arrays", "brummayerbiere", "brummayerbiere2", "brummayerbiere3", "btfnt", "calc2", "dwp_formulas", "ecc", "egt", "jager", "klee-selected-smt2", "pipe", "platania", "sharing-is-caring", "stp", "stp_samples"]

dirs = ["ecc", "egt", "jager", "sharing-is-caring", "stp", "stp_samples", "2018-Mann", "2019-Mann", "bench_ab", "bmc-arrays", "brummayerbiere", "brummayerbiere2", "brummayerbiere3", "btfnt", "calc2", "dwp_formulas"]

output_root = root_dir + "/test/output"

tool_cmds = {
  "rsatlosslist":[root_dir + "/lossList.native"],
  "stp":["/home/turetsky/stp/build/stp"],
  "boolector":["/home/turetsky/boolector/build/bin/boolector"],
  "z3":["/home/turetsky/z3-Z3-4.8.5/build/z3"]
}

timeout = 300.0

timestamp = datetime.datetime.now().strftime("%Y/%m/%d at %H:%M:%S")

def make_dir (dir_path) :
  if not os.path.exists(dir_path):
    os.makedirs(dir_path)
  else :
    shutil.rmtree(dir_path)
    os.makedirs(dir_path)

def run_example (example, logpath, result_writer, row):
  m = re.split('/', example)
  nicename = m[-1]
  for tool in tool_cmds:
    if tool == "z3":
      continue
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
          child.kill()
          break
      logfile.flush()
    result = "unknown"
    if res == "timeout" :
      result = "timeout"
    with open(logname, "r") as logfile:
      output_str = logfile.read()
      if "unknown" in output_str :
        result = "unknown"
      elif "unsat" in output_str :
        result = "unsat"
      elif "Out of memory" in output_str :
        result = "OOM"
      elif "sat" in output_str:
        result = "sat"
    print (tool + ": " + result + " time: " + str(tool_time))
    row = row + [result]
    row = row + [str(tool_time)]
  result_writer.writerow(row)

def check_solvable (example, logpath, result_writer):
  m = re.split('/', example)
  nicename = m[-1]
  row = [nicename]
  tool = "z3"
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
        child.kill()
        break
    logfile.flush()
  result = "unknown"
  if res == "timeout" :
    result = "timeout"
  else :
    with open(logname, "r") as logfile:
      output_str = logfile.read()
      if "unknown" in output_str :
        result = "unknown"
      elif "unsat" in output_str :
        result = "unsat"
      elif "Out of memory" in output_str :
        result = "OOM"
      elif "sat" in output_str:
        result = "sat"
  print (tool + ": " + result + " time: " + str(tool_time))
  if not result == "unsat":
    row = row + [result]
    row = row + [str(tool_time)]
  return result, row


for direc in dirs:
  with open(direc+".csv", 'w') as csv_out:
    csv_writer = csv.writer(csv_out)
    row = ['file']
    row = row + ['z3' + ' res', 'z3' + ' time']
    for tool in tool_cmds:
      if not tool == "z3":
        row = row + [tool + ' res', tool + ' time']
    csv_writer.writerow(row)
    files = glob.glob(example_dir + direc + "/*.smt2")
    #shuffle(files)
    for fil in files:#[:100]:
      #with open(fil, 'r') as ex:
      #  if ('Solvable: true' not in ex.read()):
      #    continue
      make_dir(output_root + "/" + direc + "/")
      solv = check_solvable(fil, output_root + "/" + direc + "/", csv_writer)
      if not solv[0] == "unsat":
        run_example(fil, output_root + "/" + direc + "/", csv_writer, solv[1])

