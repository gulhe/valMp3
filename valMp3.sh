#!/bin/bash


# Installation des dépendances ...
installed=0
for dependency in figlet cowsay sl lolcat
do
	command -v $dependency >/dev/null 2>&1 || {
		echo "\e[32m[INFO]\e[0m Ha ... T'as pas $dependency ... Tkt je te l'installe.";
		brew install $dependency;
		installed=1;
	};
done

# pour le lol
sl -e

# Disclaimer dépendances
if [ "$installed" -eq  "1" ]
then
	echo "C'est pas super utile mais ça me permet de te faire un programme plus FUN ... Et puis je le fais qu'une fois ..."
fi


# Le programme à proprement parler
while true
do
	echo "Drag n' Drop tes fichiers ici : (et après tu appui sur enter/return/entrée, tu valide quoi ...)"
	read -a files
	for file in "${files[@]}"
	do
		figlet treating $file | lolcat
		if [[ "$file" =~ ' ' ]]
		then
			cowsay 'Argh, tu mets des espaces dans les noms de tes fichiers, CHIEN ! (c'"'"'est pas grave mais c'"'"'est un poil plus chiant)' | lolcat
		fi
		if [[ "$file" =~ '.wav' ]]
		then
			newFile=${file/.wav/.mp3}
			lame -h "$file" "$newFile" && figlet $newFile ready | lolcat && rm -f "$file"
		else
			echo -e '\e[31m[ERREUR]\e[0m Je ne sais pas gérer ton format de fichier pour '"$file"
			echo "c'est probablement pas compliqué mais j'ai pas pris ce cas en compte. Passe moi un coup de phone et je te regle ça "'!'
			echo "profite pour prendre une photo de ton écran, pour diagnostiguer ça me facilitera la life gros."
		fi
	done
	cowsay "Quand tu veux arreter ce programme, ferme la fenêtre ou appuies sur [Ctrl]+[C] ... voilà ..."|lolcat
done
