#! /bin/sh

printf "Preparing the simulation...\n\n"

bash ./build.sh
if ! bash ./build.sh; then
    echo "Problem with compilation."
    exit 1
fi

cd ~/Desktop/KARST/DATA/2D || exit

# Creating proper directory
current_date_time=$(date +small_%Y_%m_%d_%H_%M)

mkdir "$current_date_time"
if [ -d "$current_date_time" ]; then
  echo "Directory '$current_date_time' created successfully."
else
  echo "Failed to create directory."
  exit 1
fi

cd "$current_date_time" || exit
cp ~/Desktop/KARST/karst_3.0/simulation_setups/2D/config_small.txt ./config.txt || exit


printf "Running the simulation...\n\n"

Da=0.5
gamma=1
kappa=1000
dmin=0.001
cut=true


Da=0.1
d0=0.24
los=123
kappa=0.0001
for Da in 0.1  #0.5
do
  for gamma in  0
  do
  (
                param=Da-$Da-d0-$d0-gamma-$gamma-kappa-$kappa
                printf "Creating variant: %s\n" "$param"
                mkdir $param
                cd    $param || exit
                cp ../config.txt .

                {
                  echo gamma = $gamma
                  echo kappa = $kappa
                  echo Da    = $Da
                  echo d0    = $d0
                  echo gauss_sigma_d = 0 #.001
                  echo random_seed = $los
                  echo Cb_0 = 1
                  echo Cc_0 = 0
                  echo nodes_repulsion = 0.5
                  echo N_tracers = 10


                } >> config.txt

#               {
                 time ~/Desktop/KARST/karst_3.0/build/karst  config.txt  #  >wyjscie.out 2>bledy.out
#                 } 2>czas.tmp  &

             )
done
done


