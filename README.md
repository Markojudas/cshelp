#	.NET Framework Helper for vscode in a Linux Environment

I have been using a <a href="https://www.linode.com/">Linode</a> Virtual Machone (Debian 10) for remote work with a ssh connection on <a href="https://code.visualstudio.com/Download">vscode</a>. Development for most languages is quite easy and convinient except for C# (.Net Framework). I found myself
having to run several commands just to set the environment to start coding. That's the birth of this script.

This script simply makes the creation of a <b>console app</b> and a <b>classlib</b> easier so you can start coding faster.
 The script assumes the dotnet binary is located "/usr/bin/dotnet". It will then check all the different 
versions you have and let your choice which one to use. 


#	Installation

```
git clone https://github.com/Markojudas/cshelp.git
cd cshelp/
source csharp.sh
```

If you wish you could set your ~/.bashrc to source the script at boot. 

```
echo "if [ -f <full_path_to_script>/csharp.sh ]; then \
	. <full_path_to_script>/charp.sh \
fi" >> ~/.bashrc
```

#	USAGE

The structure after running the commands:

<img src="./static/structure.png" alt="App Structure"/>

The first command to use will create a new directory (named after the solution) and go into this directory. It will then create the solution and a new console app.
It will then  build the console app and add it to the solution. At this point you can already begin coding! Open the newly created directory (with the solution name) on vscode
and start coding!

If you need to create a class library, then run the second command (<b>must be ran while in the same directory as the solution file</b>).
A classlib will be created (with a stock file called Class1.cs) and it will be added to the project (console app).

The structure will look like this:

<img src="./static/structure.png" alt="App Structure"/>

<h6> I have named the solution App. A directory named App (same as the solution) was created. Inside the directory the console app was created
named MyConsoleApp. I have also named the Class Library MyClass inside the App directory.</h6>

<b>Commands</b>:

```
cshelp console App MyConsoleApp
```

```
cshelp classlib MyClass MyConsoleApp
```

<h6>Keep in mind that each command will search and ask you which .NET version you wish to use</h6>

That's it!


#	Colaboration

Any feedback is appreciated and if you make changes please share. 
