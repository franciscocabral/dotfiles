
export DC_KEYCAR_DIR="/mnt/d/__keycar"
export DC_MACHINEAIR_DIR="/mnt/d/__machineair"
export DC_BARBASCODING_DIR="/mnt/d/__barbascoding"
export DC_MOBLAB_DIR="/mnt/d/__moblab"

_dc()
{
  if [ "${#COMP_WORDS[@]}" != "1" ]; then
    return
  fi
  local dir="DC_$(echo $1 | tr '[:lower:]' '[:upper:]')_DIR"
  local suggestions=($(compgen -W  "$(ls --color=never "${(P)dir}" | sed 's/\///')" -- "${COMP_WORDS[1]}"))

  if [ "${#suggestions[@]}" == "1" ]; then
    local number=$(echo ${suggestions[0]/%\ */})
    COMPREPLY=("$number")
  else
    COMPREPLY=("${suggestions[@]}")
  fi
}


# function keycar(){
#   if [ -f "$DC_KEYCAR_DIR/$1" ] 
#   then 
#     $EDITOR $1
#   else
#     cd $DC_KEYCAR_DIR/$1
#   fi
# }

# function machineair(){
#   cd /mnt/d/__machine/$1
# }

# function barbascoding(){
#   cd /mnt/d/__barbascoding/$1
# }

function moblab(){
  if [ -f "$DC_MOBLAB_DIR/$1" ] 
  then 
    $EDITOR $1
  else
    cd $DC_MOBLAB_DIR/$1
  fi
}

# complete -F _dc keycar
# complete -F _dc machineair
# complete -F _dc barbascoding
complete -F _dc moblab

function mkcd(){
  mkdir -p $1;
  cd $1;
}

function_exists() {
  declare -f -F $1 > /dev/null
  return $?
}

function randstr() {
    </dev/urandom tr -dc 'A-Za-z0-9!()*+,-.:;<=>?@[]_{|}' | head -c $1  ; echo
}


function load_env() {
  local ENV_FILE=".env"
  if [ ! -f $1 ] 
  then
    local ENV_FILE=$1
  fi
  echo $ENV_FILE

  if [ -f "$ENV_FILE" ]
  then
    export $(cat $ENV_FILE | xargs)
    echo "$ENV_FILE loaded";
  fi
}