# PrusaSlicer AppData Sync

## Description

These two simple batch scripts help sync PrusaSlicer's configuration files between computers (running Windows). 

The main script (`Update_PrusaSlicer_config.bat`) pulls the configuration files from a GitHub repository and replaces the contents of PrusaSlicer's AppData folder. By default, it doesn't replace the `snapshots` folder.

The second script (`Push_current_config.bat`), is just a shortcut to push any new configuration changes to the main repository.

This is currently used in a school's makerspace to ensure all the computers have the right configuration and options for the students to use our 3D printers. The script runs automatically on login on every computer.

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Installation

In order to run these scripts, Git must be installed on your computer. You can download it here: [https://git-scm.com/download/win](https://git-scm.com/download/win).

You also need to setup a GitHub repository to upload your configuration.

Before running the Push script for the first time, it might be a good idea to set up a `.gitignore` file and put it in PrusaSlicer's AppData folder (a quick way to find it is to hit Ctrl+R and type `%appdata%\prusaslicer`). If you don't have one, the script will make a simple one:
```
*.bak
/snapshots
PrusaSlicerGcodeViewer*
```
This will avoid uploading and/or replacing any backups, or any GcodeViewer files.

You might want to exclude more files, for efficiency and to remove overhead. For example, my `.gitignore` file looks like this:

```
*.bak
/snapshots
/physical_printer
/shapes
/sla_material
/sla_print
PrusaSlicerGcodeViewer*
```

Make sure to set `repoauthor` and `reponame` to your own github usename and repository, or whoever's you might be using for the configuration.

## Usage

After having set up a repository, changed the user variables in the script, and ideally also created a `.gitignore` file, open PrusaSlicer and choose the presets that you want to have appear as default, then close it.

Run the `Push_current_config.bat` by double-clicking it. A security prompt will prevent you from doing it, but you can bypass it by clicking "More Info".

Run `Update_PrusaSlicer_config.bat` on the computers you want to sync the settings to (the same security prompt will appear the first time you run it). Make sure PrusaSlicer is not running when you run the script.

## Contributing

Any suggestions for improvement are welcome!

## License

This project is licensed under the [MIT License](https://opensource.org/licenses/MIT). You are free to use, modify, and distribute this project as per the terms of the MIT License.
