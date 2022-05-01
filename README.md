#	.NET Framework Helper for vscode in a Linux Environment

I have been using a <a href="https://www.linode.com/">Linode</a> Virtual Machine (Debian 10) for remote work with a ssh connection on <a href="https://code.visualstudio.com/Download">vscode</a>. Development for most languages is quite easy and convinient except for C# (.Net Framework). I found myself
having to run several commands just to set the environment to start coding. That's the birth of this script.

This script simply makes the creation of a <b>console app</b> and a <b>classlib</b> easier so you can start coding faster.
 The script assumes the dotnet binary is located "/usr/bin/dotnet". It will then check all the different 
versions you have and let your choice which one to use. 

(update#1)
The script now also handles the creation of Unit Tests (using <a href="https://xunit.net/">xUnit</a>). 


#	Installation

```
git clone https://github.com/Markojudas/cshelp.git
cd cshelp/
source csharp.sh
```

If you wish you could set your ~/.bashrc to source the script at boot. 

```
echo "if [ -f <full_path_to_script>/csharp.sh ]; then 
	. <full_path_to_script>/csharp.sh
fi" >> ~/.bashrc
```

#	Usage

The structure after running the commands:

<img src="./static/structure.png" alt="App Structure"/>

<h5>Start by creating a Console App </h5>
The first command to use (ran in your project folder) will create a new directory (named after the solution) and go into this directory. It will then create the solution and a new console app.
It will then  build the console app and add it to the solution. At this point you can already begin coding! Open the newly created directory (with the solution name) on vscode
and start coding!

<h5>Create A Class library</h5>
If you need to create a class library, then run the second command (<b>must be ran while in the same directory as the solution file</b>).
A classlib will be created (with a stock file called Class1.cs) and it will be added to the solution and project (console app).

<h6> I have named the solution App. A directory named App (same as the solution) was created. Inside the directory the console app was created
named MyConsoleApp. I have also named the Class Library MyClass inside the App directory.</h6>

(update#1)
<h5>Create a Unit Test</h5>
If you want to create an unit test, then ran the 3rd command. It will be added to the solution and chosen project.

<b>Commands</b>:

<h2>First Command</h2>
```
cshelp console App MyConsoleApp
```

<h2>Second Command</h2>
```
cshelp classlib MyClass MyConsoleApp
```

(update#1)
<h2>Thrid Command</h2>
```
cshelp xunit MyConsoleApp.Tests MyconsoleApp
```

<h6>Keep in mind that each command will search and ask you which .NET version you wish to use</h6>

That's it!


#	Collab

Any feedback is appreciated and if you make changes please share. 
