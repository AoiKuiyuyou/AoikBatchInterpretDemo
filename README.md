# AoikBatchInterpretDemo
A demo to explain how Batch interprets a code line, involving early and delayed variable expansion, and treatment of special characters.

Tested working with:
- Windows 10
- Python 3.12.3

# Run the demo
Run:
```
SET PATH=D:\Software\Python;%PATH%

CD AoikBatchInterpretDemo\src

aoik_batch_interpret_demo.bat "A^^^^^^^! B"
```

Result:
```
# +++++ STEP: 1O7K5: SETLOCAL DisableDelayedExpansion
# +++++ STEP: 2P8S3: python.exe cmd_args.py %~1
['A^^^!', 'B']
# +++++ STEP: 3H9C5: python.exe cmd_args.py "%~1"
['A^^^^^^^! B']
# +++++ STEP: 4T1N7: SET a1_dde_set_noq=%~1
# +++++ STEP: 5E9M3: python.exe cmd_args.py %a1_dde_set_noq%
['A^!', 'B']
# +++++ STEP: 6R1Z7: python.exe cmd_args.py "%a1_dde_set_noq%"
['A^^^! B']
# +++++ STEP: 7Q4W2: SET "a1_dde_set_quo=%~1"
# +++++ STEP: 8F3X6: python.exe cmd_args.py %a1_dde_set_quo%
['A^^^!', 'B']
# +++++ STEP: 9A7V2: python.exe cmd_args.py "%a1_dde_set_quo%"
['A^^^^^^^! B']
# +++++ STEP: 1G3U6: SETLOCAL EnableDelayedExpansion
# +++++ STEP: 2I9H4: python.exe cmd_args.py %~1
['A^!', 'B']
# +++++ STEP: 3T5P1: python.exe cmd_args.py "%~1"
['A^^^! B']
# +++++ STEP: 4E8O9: SET a1_ede_set_noq=%~1
# +++++ STEP: 5U7E3: python.exe cmd_args.py %a1_ede_set_noq%
['A', 'B']
# +++++ STEP: 6N4C2: python.exe cmd_args.py "%a1_ede_set_noq%"
['A! B']
# +++++ STEP: 7Y9L1: python.exe cmd_args.py !a1_ede_set_noq!
['A^!', 'B']
# +++++ STEP: 8O5W3: python.exe cmd_args.py "!a1_ede_set_noq!"
['A^! B']
# +++++ STEP: 9F6D7: SET "a1_ede_set_quo=%~1"
# +++++ STEP: 1X8M3: python.exe cmd_args.py %a1_ede_set_quo%
['A!', 'B']
# +++++ STEP: 2J4H5: python.exe cmd_args.py "%a1_ede_set_quo%"
['A^! B']
# +++++ STEP: 3G7Z8: python.exe cmd_args.py !a1_ede_set_quo!
['A^^^!', 'B']
# +++++ STEP: 4K6I5: python.exe cmd_args.py "!a1_ede_set_quo!"
['A^^^! B']
```

See the comments in [aoik_batch_interpret_demo.bat](src/aoik_batch_interpret_demo.bat) for the explanation.
