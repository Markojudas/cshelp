#!/bin/bash

function cshelp(){
	
	function pick_sdk(){
	
		if ! [[ -f /usr/bin/dotnet ]]; then
			echo ".NET Framework not found"
			return 1
		fi
		IFS=$'\n'
		SDKS=( $(dotnet --list-sdks | grep -o ^[0-9].[0-9]) )

		i=1

		echo "Found the following .NET Frameworks: "
		echo " "
		for sdk in "${SDKS[@]}"
		do
			echo "  "$i\)  net$sdk
			let i++
		done
		echo " "
	
		if [[ $i -eq 2 ]]; then
			read -p "Select the SDK [1]: " choice
		else
			read -p "Select the SDK [1-$((i-1)))]: " choice
		fi

		if ! [[ $choice =~ ^[0-9]+$ ]] || [ $choice -gt $((i-1)) ]; then
			echo "wrong input: Please select from the choices. Try again"
			return 1
		fi
	
		NETVERSION="net"${SDKS[choice-1]}
	}

	function direction(){
	
	echo ".NET CLI helper to set the development environment for VSCode

Usage:	cshelp [command] [arg1] [arg2]

Commands:
console [solution_name] [console app name]		Creates new directory, solution, new console app and adds it to the solution
classlib [classlib name] [existing console app name]	Creates a class library inside the same directory as the solution and adds it to the solution and as a dependency for the project
xunit [name_of_project.Tests] [name_of_project]		Creates an Unit Test inside the same directory as the solution and adds it to the solution and adds the project as a dependency to the test

Created by:
 Markojudas : https://github.com/Markojudas/cshelp"

	}

	function add_to_sln(){
	
		dotnet sln add $TOSLN/$TOSLN.csproj
	}


	function new_console(){
	
		pick_sdk
		
		if [[ $? -ne 1 ]]; then
			mkdir $SLN && cd $SLN
			dotnet new sln
			dotnet new console --framework=$NETVERSION -o $CA
			dotnet build $CA/$CA.csproj
			TOSLN=$CA

			add_to_sln
		else
			return 1
		fi
	
	}

	function add_reference(){
	
		dotnet add $CA/$CA.csproj reference $CL/$CL.csproj
	}

	function new_classlib(){
		
		pick_sdk
	
		if [[ $? -ne 1 ]]; then
			dotnet new classlib --framework=$NETVERSION -o $CL
			TOSLN=$CL
			dotnet build $CL/$CL.csproj		
			add_to_sln
			add_reference		
		else
			return 1
		fi
	}

	function new_xunit(){
		pick_sdk

		if [[ $? -ne 1 ]]; then
			dotnet new xunit --framework=$NETVERSION -o $UT
			TOSLN=$UT
			CL=$CA
			CA=$UT
			add_to_sln
			add_reference
		else
			return 1
		fi
	}
	
	SLN=$2
	CL=$2
	UT=$2
	CA=$3

	case "$1" in
		"console")
			if [[ $# -eq 3 && $# -lt 4 ]]; then
				new_console
			else
				direction
			fi
			;;
		"classlib")
			if [[ $# -eq 3 && $# -lt 4 ]]; then
				if ! [[ -d $CA ]] || ! [[ -f $CA/$CA.csproj ]] || [[ -d $CL ]]; then
					if [[ -d $CL ]]; then
						echo "Choose a different name for your Class Library"
					else
						echo "Console App not found. Try again"
					fi
					echo " "
					direction
				else
					new_classlib
				fi
			else
				direction
			fi
			;;
		"xunit")
			if [[ $# -eq 3 && $# -lt 4 ]]; then
				if ! [[ -d $CA ]] || ! [[ -f $CA/$CA.csproj ]] || [[ -d $UT ]]; then
					if [[ -d $UT ]]; then
						echo "Choose a different name for your Unit Test"
					else
						echo "Project not found. Try again"
					fi
					echo " "
					direction
				else
					new_xunit
				fi
			else
				direction
			fi
			;;
		*)
			direction
			;;
	esac
}
