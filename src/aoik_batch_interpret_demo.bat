@ECHO off

REM # +++++ Batch code line interpretation steps +++++
REM # 1. Early-expansion is performed, which
REM # replaces `%%` with a literal `%`,
REM # replaces `%_VAR_%` with the variable's earliest value.
REM # replaces `%_NUM_` with the variable's latest value.
REM # It is the latest value because `%_NUM_` variable may be changed by `SHIFT` command.
REM #
REM # 2. Early-interpr is performed, which treats characters like `"`, ` `, `^` specially.
REM # `"` not following an opening `"` is treated as an opening `"`.
REM # `"` following an opening `"` is treated as a closing `"`.
REM # ` ` and `^` following an opening `"` are treated literally.
REM # ` ` not following an opening `"` is treated as command fields delimiter.
REM # `^` not following an opening `"` replaces `^^` with a literal `^`, replaces `^"` with a literal `"`.
REM #
REM # If delayed expansion is enabled and the result after early-interpr contains `!`,
REM # no matter the `!` is in quotes or not, no matter the `!` is escaped or not,
REM # then delayed-expansion and delayed-interpr are applied on the result of early-interpr.
REM #
REM # 3. Delayed-expansion is performed, which
REM # replaces `^^` with a literal `^`,
REM # replaces `^!` with a literal `!`,
REM # replaces `!_VAR_!` with the variable's latest value.
REM #
REM # 4. Delayed-interpr is performed, which treats characters like `"`, ` ` specially. `^` and `!` are no longer special.
REM # `"` not following an opening `"` is treated as an opening `"`.
REM # `"` following an opening `"` is treated as a closing `"`.
REM # ` ` following an opening `"` is treated literally.
REM # ` ` not following an opening `"` is treated as command fields delimiter.
REM # ===== Batch code line interpretation steps =====


ECHO # +++++ STEP: 1O7K5: SETLOCAL DisableDelayedExpansion
SETLOCAL DisableDelayedExpansion


ECHO # +++++ STEP: 2P8S3: python.exe cmd_args.py %%~1
"python.exe" "%~dp0cmd_args.py" %~1
REM # -----
REM # `%~1` -> `A^^^^^^^! B`, early-expansion.
REM # `A^^^^^^^! B` -> `['A^^^!', 'B']`, early-interpr.
REM # =====


ECHO # +++++ STEP: 3H9C5: python.exe cmd_args.py "%%~1"
"python.exe" "%~dp0cmd_args.py" "%~1"
REM # -----
REM # `"%~1"` -> `"A^^^^^^^! B"`, early-expansion.
REM # `"A^^^^^^^! B"` -> `['A^^^^^^^! B']`, early-interpr.
REM # =====


ECHO # +++++ STEP: 4T1N7: SET a1_dde_set_noq=%%~1
SET a1_dde_set_noq=%~1
REM # -----
REM # `SET a1_dde_set_noq=%~1` -> `SET a1_dde_set_noq=A^^^^^^^! B`, early-expansion.
REM # `SET a1_dde_set_noq=A^^^^^^^! B` -> `SET a1_dde_set_noq=A^^^! B`, early-interpr.
REM # `A^^^! B` -> `a1_dde_set_noq`, early-interpr.
REM # =====


ECHO # +++++ STEP: 5E9M3: python.exe cmd_args.py %%a1_dde_set_noq%%
"python.exe" "%~dp0cmd_args.py" %a1_dde_set_noq%
REM # -----
REM # `%a1_dde_set_noq%` -> `A^^^! B`, early-expansion.
REM # `A^^^! B` -> `['A^!', 'B']`, early-interpr.
REM # =====


ECHO # +++++ STEP: 6R1Z7: python.exe cmd_args.py "%%a1_dde_set_noq%%"
"python.exe" "%~dp0cmd_args.py" "%a1_dde_set_noq%"
REM # -----
REM # `"%a1_dde_set_noq%"` -> `"A^^^! B"`, early-expansion.
REM # `"A^^^! B"` -> `['A^^^! B']`, early-interpr.
REM # =====


ECHO # +++++ STEP: 7Q4W2: SET "a1_dde_set_quo=%%~1"
SET "a1_dde_set_quo=%~1"
REM # -----
REM # `SET "a1_dde_set_quo=%%~1"` -> `"SET a1_dde_set_quo=A^^^^^^^! B"`, early-expansion.
REM # `"SET a1_dde_set_quo=A^^^^^^^! B"` -> `"SET a1_dde_set_quo=A^^^^^^^! B"`, early-interpr.
REM # `A^^^^^^^! B` -> `a1_dde_set_quo`, early-interpr.
REM # =====


ECHO # +++++ STEP: 8F3X6: python.exe cmd_args.py %%a1_dde_set_quo%%
"python.exe" "%~dp0cmd_args.py" %a1_dde_set_quo%
REM # -----
REM # `%a1_dde_set_quo%` -> `A^^^^^^^! B`, early-expansion.
REM # `A^^^^^^^! B` -> `['A^^^!', 'B']`, early-interpr.
REM # =====


ECHO # +++++ STEP: 9A7V2: python.exe cmd_args.py "%%a1_dde_set_quo%%"
"python.exe" "%~dp0cmd_args.py" "%a1_dde_set_quo%"
REM # -----
REM # `"%a1_dde_set_quo%"` -> `"A^^^^^^^! B"`, early-expansion.
REM # `"A^^^^^^^! B"` -> `['A^^^^^^^! B']`, early-interpr.
REM # =====


ECHO # +++++ STEP: 1G3U6: SETLOCAL EnableDelayedExpansion
SETLOCAL EnableDelayedExpansion


ECHO # +++++ STEP: 2I9H4: python.exe cmd_args.py %%~1
"python.exe" "%~dp0cmd_args.py" %~1
REM # -----
REM # `%~1` -> `A^^^^^^^! B`, early-expansion.
REM # `A^^^^^^^! B` -> `A^^^! B`, early-interpr.
REM # `!` triggers delayed-expansion and delayed-interpr.
REM # `A^^^! B` -> `A^! B`, delayed-expansion.
REM # `A^! B` -> ['A^!', 'B'], delayed-interpr.
REM # =====


ECHO # +++++ STEP: 3T5P1: python.exe cmd_args.py "%%~1"
"python.exe" "%~dp0cmd_args.py" "%~1"
REM # -----
REM # `"%~1"` -> `"A^^^^^^^! B"`, early-expansion.
REM # `"A^^^^^^^! B"` -> `"A^^^^^^^! B"`, early-interpr.
REM # `!` triggers delayed-expansion and delayed-interpr.
REM # `"A^^^^^^^! B"` -> `"A^^^! B"`, delayed-expansion.
REM # `"A^^^! B"` -> ['A^^^! B'], delayed-interpr.
REM # =====


ECHO # +++++ STEP: 4E8O9: SET a1_ede_set_noq=%%~1
SET a1_ede_set_noq=%~1
REM # -----
REM # `SET a1_ede_set_noq=%~1` -> `SET a1_ede_set_noq=A^^^^^^^! B`, early-expansion.
REM # `SET a1_ede_set_noq=A^^^^^^^! B` -> `SET a1_ede_set_noq=A^^^! B`, early-interpr.
REM # `!` triggers delayed-expansion and delayed-interpr.
REM # `SET a1_ede_set_noq=A^^^! B` -> `SET a1_ede_set_noq=A^! B`, delayed-expansion.
REM # `A^! B` -> `a1_ede_set_noq`, delayed-interpr.
REM # =====


ECHO # +++++ STEP: 5U7E3: python.exe cmd_args.py %%a1_ede_set_noq%%
"python.exe" "%~dp0cmd_args.py" %a1_ede_set_noq%
REM # -----
REM # `%a1_ede_set_noq%` -> `A^! B`, early-expansion.
REM # `A^! B` -> `A! B`, early-interpr.
REM # `!` triggers delayed-expansion and delayed-interpr.
REM # `A! B` -> `A B`, delayed-expansion.
REM # `A B` -> ['A', 'B'], delayed-interpr.
REM # =====


ECHO # +++++ STEP: 6N4C2: python.exe cmd_args.py "%%a1_ede_set_noq%%"
"python.exe" "%~dp0cmd_args.py" "%a1_ede_set_noq%"
REM # -----
REM # `"%a1_ede_set_noq%"` -> `"A^! B"`, early-expansion.
REM # `"A^! B"` -> `"A^! B"`, early-interpr.
REM # `!` triggers delayed-expansion and delayed-interpr.
REM # `"A^! B"` -> `"A! B"`, delayed-expansion.
REM # `"A! B"` -> ['A! B'], delayed-interpr.
REM # =====


ECHO # +++++ STEP: 7Y9L1: python.exe cmd_args.py ^^!a1_ede_set_noq%^^!
"python.exe" "%~dp0cmd_args.py" !a1_ede_set_noq!
REM # -----
REM # `!a1_ede_set_noq!` -> `!a1_ede_set_noq!`, early-expansion.
REM # `!a1_ede_set_noq!` -> `!a1_ede_set_noq!`, early-interpr.
REM # `!` triggers delayed-expansion and delayed-interpr.
REM # `!a1_ede_set_noq!` -> `A^! B`, delayed-expansion.
REM # `A^! B` -> `['A^!', 'B']`, delayed-interpr.
REM # =====


ECHO # +++++ STEP: 8O5W3: python.exe cmd_args.py "^!a1_ede_set_noq%^!"
"python.exe" "%~dp0cmd_args.py" "!a1_ede_set_noq!"
REM # -----
REM # `"!a1_ede_set_noq!"` -> `"!a1_ede_set_noq!"`, early-expansion.
REM # `"!a1_ede_set_noq!"` -> `"!a1_ede_set_noq!"`, early-interpr.
REM # `!` triggers delayed-expansion and delayed-interpr.
REM # `"!a1_ede_set_noq!"` -> `"A^! B"`, delayed-expansion.
REM # `"A^! B"` -> ['A^! B'], delayed-interpr.
REM # =====


ECHO # +++++ STEP: 9F6D7: SET "a1_ede_set_quo=%%~1"
SET "a1_ede_set_quo=%~1"
REM # -----
REM # `SET "a1_ede_set_quo=%~1"` -> `SET "a1_ede_set_quo=A^^^^^^^! B"`,early-expansion.
REM # `SET "a1_ede_set_quo=A^^^^^^^! B"` -> `SET "a1_ede_set_quo=A^^^^^^^! B"`,early-interpr.
REM # `!` triggers delayed-expansion and delayed-interpr.
REM # `SET "a1_ede_set_quo=A^^^^^^^! B"` -> `SET "a1_ede_set_quo=A^^^! B"`, delayed-expansion.
REM # `A^^^! B` -> `a1_ede_set_quo`, delayed-interpr.
REM # =====


ECHO # +++++ STEP: 1X8M3: python.exe cmd_args.py %%a1_ede_set_quo%%
"python.exe" "%~dp0cmd_args.py" %a1_ede_set_quo%
REM # -----
REM # `%a1_ede_set_quo%` -> `A^^^! B`, early-expansion.
REM # `A^^^! B` -> `A^! B`, early-interpr.
REM # `!` triggers delayed-expansion and delayed-interpr.
REM # `A^! B` -> `A! B`, delayed-expansion.
REM # `A! B` -> `['A!', 'B']`, delayed-interpr.
REM # =====


ECHO # +++++ STEP: 2J4H5: python.exe cmd_args.py "%%a1_ede_set_quo%%"
"python.exe" "%~dp0cmd_args.py" "%a1_ede_set_quo%"
REM # -----
REM # `"%a1_ede_set_quo%"` -> `"A^^^! B"`, early-expansion.
REM # `"A^^^! B"` -> `"A^^^! B"`, early-interpr.
REM # `!` triggers delayed-expansion and delayed-interpr.
REM # `"A^^^! B"` -> `"A^! B"`, delayed-expansion.
REM # `"A^! B"` -> `['A^! B']`, delayed-interpr.
REM # =====


ECHO # +++++ STEP: 3G7Z8: python.exe cmd_args.py ^^!a1_ede_set_quo%^^!
"python.exe" "%~dp0cmd_args.py" !a1_ede_set_quo!
REM # -----
REM # `!a1_ede_set_quo!` -> `!a1_ede_set_quo!`, early-expansion.
REM # `!a1_ede_set_quo!` -> `!a1_ede_set_quo!`, early-interpr.
REM # `!` triggers delayed-expansion and delayed-interpr.
REM # `!a1_ede_set_quo!` -> `A^^^! B`, delayed-expansion.
REM # `A^^^! B` -> `['A^^^!', 'B']`, delayed-interpr.
REM # =====


ECHO # +++++ STEP: 4K6I5: python.exe cmd_args.py "^!a1_ede_set_quo%^!"
"python.exe" "%~dp0cmd_args.py" "!a1_ede_set_quo!"
REM # -----
REM # `"!a1_ede_set_quo!"` -> `"!a1_ede_set_quo!"`, early-expansion.
REM # `"!a1_ede_set_quo!"` -> `"!a1_ede_set_quo!"`, early-interpr.
REM # `!` triggers delayed-expansion and delayed-interpr.
REM # `"!a1_ede_set_quo!"` -> `"A^^^! B"`, delayed-expansion.
REM # `"A^^^! B"` -> `['A^^^! B']`, delayed-interpr.
REM # =====
