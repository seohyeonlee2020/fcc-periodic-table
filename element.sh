#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]
then
echo "Please provide an element as an argument."
else
#dheck if user_input matches anything in atomic_number
INPUT_SEARCH=$($PSQL "SELECT * FROM elements LEFT JOIN properties USING (atomic_number) WHERE elements.atomic_number=($1::numeric)")
#if empty
  if [[ -z $INPUT_SEARCH ]]
#retry with name
  then
  INPUT_SEARCH=$($PSQL "SELECT * FROM elements LEFT JOIN properties USING (atomic_number) WHERE elements.name=('$1'::varchar)")
  #if also empty
    if [[ -z $INPUT_SEARCH ]]
    then
  #retry with symbol
    INPUT_SEARCH=$($PSQL "SELECT * FROM elements LEFT JOIN properties USING (atomic_number) WHERE elements.symbol=('$1'::varchar)")
    fi
  fi

  if [[ ! -z $INPUT_SEARCH ]]
  then
  #process input results
  PROCESSED=$(echo "$INPUT_SEARCH" | sed 's/|/ /g')
  ARR=($PROCESSED)
  TYPE=$($PSQL "SELECT type FROM types WHERE type_id=${ARR[6]}::numeric")
  #echo $PROCESSED type $TYPE
  #echo test value: $INPUT_SEARCH processed ${ARR[2]}
  #The element with atomic number 1 is Hydrogen (H). It's a nonmetal, with a mass of 1.008 amu. Hydrogen has a melting point of -259.1 celsius and a boiling point of -252.9 celsius.
  echo "The element with atomic number ${ARR[0]} is ${ARR[1]} (${ARR[2]}). It's a $TYPE, with a mass of ${ARR[3]} amu. ${ARR[1]} has a melting point of ${ARR[4]} celsius and a boiling point of ${ARR[5]} celsius."
  else
  #if no matches
  echo "I could not find that element in the database."
  fi
fi



