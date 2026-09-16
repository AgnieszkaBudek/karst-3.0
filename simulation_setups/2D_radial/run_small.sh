#! /bin/sh

printf "Preparing the simulation...\n\n"

cd ~/Desktop/KARST/karst_3.0/ || exit
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
phi=0.1

los=123
kappa=1
Vx=0
dyn_k2_c0=1.0
gamma=1
dyn_k2_c0=1
for phi in  0.1
do
for Da in 0.5  # 1 0.01
do
  for dyn_k2_c0 in  1

  do
  (
                param=Da-$Da-phi-$phi-gamma-$gamma-kappa-$kappa-dyn_k2_c0-$dyn_k2_c0
                printf "Creating variant: %s\n" "$param"
                mkdir $param
                cd    $param || exit
                cp ../config.txt .

                {
                  echo if_dynamic_k2  = true
                  echo dyn_k2_c0  = $dyn_k2_c0
                  echo Vx_perc = $Vx
                  echo gamma = $gamma
                  echo kappa = $kappa
                  echo Da    = $Da
                  echo phi_0    = $phi
                  echo gauss_sigma_d = 0 #.001
                  echo random_seed = $los
                  echo if_radial_geometry = true
                  echo if_no_surface_tracking = true

                } >> config.txt

#               {
                 time ~/Desktop/KARST/karst_3.0/build/karst  config.txt    >wyjscie.out 2>bledy.out&
#                 } 2>czas.tmp  &

             )
done
done
done


