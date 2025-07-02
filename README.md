# python-template
A template repository for python projects in Sevan DWT.

## Setup environment with uv

> [!IMPORTANT]
> You only need to follow the steps in this section if you are setting up an uv environment for the first time. If you already have an uv and credentials to sevan internal packages, you can skip to [Run a script](#run-a-script).

[UV](https://docs.astral.sh/uv/) is a Python package and project manager, which handles Python versions and virtual environments for you.
To install uv, type the following in the PowerShell terminal:

```console
powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
```

This will download and install uv to:

```console
C:\Users\<your-username>\.local\bin
```

You should receive a message that uv has been installed.
To use uv from the terminal window, you need to add it to your system's PATH.
Write the following in the PowerShell terminal:

```console
$env:Path = "C:\Users\<your-username>\.local\bin;$env:Path"
```

After installing uv, you can check that uv is available by running the `uv` command:

```console
uv
```

You should see a help menu listing the available commands.


#### Configure credentials for internal packages

To get access to the internal packages, you need to set up your credentials towards Repoforge.
This is done by running the `setup_credentials.ps1` script from the terminal window:

```console
.\setup_credentials.ps1
```

You might be prompted to enter your Repoforge token. If that happens, request a token from EBG/SLF.
Enter your token when prompted. The credentials should now be saved to:

```console
C:\Users\<your-username>\_netrc
```

Your setup should now be complete.


## Run a script

To test your setup, you can try to run one of your scripts:

```console
uv run .\src\main.py
```

## Develop your own scripts

### Add a new package

To add a new package, you can use the `uv add` command. For example, to add the `numpy` package, you can run:

```console
uv add numpy
```

### Running the tests

To run the tests for the projec:

```console
uv run pytest
```

### Linting and formatting

Pre-commit is used to format and lint the code-base before a commit is done. To install git-hooks:

```console
uv run pre-commit install
```
It will now automatically run on the files changed when trying to commit. To run on all files:

```console
uv run pre-commit run --all-files
```

### Project structure in Pycharm
To get the correct project structure in Pycharm (and get correct import resolution in IDE), you need to set the source root for the `src` folder.

1. Right-click on the `src` folder in the project view.
2. Select "Mark Directory as" from the context menu.
3. Choose "Sources Root" from the submenu.
