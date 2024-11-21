#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=<database_name> -t --no-align -c"
read USER_INPUT
if [[ -z USER_INPUT ]]
then
echo "Please provide an element as an argument."
else
#dheck if user_input matches anything in atomic_number, symbol, or name
INPUT_SEARCH=$($PSQL "select * from elements where name=(100::varchar) or atomic_number=100 or symbol=(100::varcha
r)")
  #if match 
  if [[ ! -z $INPUT_SEARCH ]]
  #return relevant information: 
  ATOMIC_MASS = $($PSQL "select * from elements where name=(100::varchar) or atomic_number=100 or symbol=(100::varcha
r) left join properties using (atomic_number)")
  #The element with atomic number 1 is Hydrogen (H). It's a nonmetal, with a mass of 1.008 amu. Hydrogen has a melting point of -259.1 celsius and a boiling point of -252.9 celsius.
  echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MP_C celsius and a boiling point of $BP_C celsius.
  else
  #if no matches
  echo "I could not find that element in the database."
fi



