#! /bin/sh

printf "Preparing the simulation...\n\n"
karst_path="$HOME/Desktop/KARST/karst_3.0/"
bash ./build.sh
if ! bash ./build.sh; then
    echo "Problem with compilation."
    exit 1
fi

cd ~/Desktop/KARST/DATA/2D || exit      #edit your DATA path

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
cp "$karst_path"/simulation_setups/pure_diss/config.txt ./config.txt || exit


printf "Running the simulation...\n\n"


Da=0.1
phi=0.1

type_of_topology="triangulation" #diamond
gauss_sigma_d=-0.01  #positive - gaussian, negative log-normal with sigma = abs(gauss_sigma_d)
nodes_repulsion=0.75  # only for triangulation topology
los=123  #fortune
N_tracers=10   #per inlet node

for Da in 0.1
do
  (
                param=Da-$Da-d0-$d0-gamma-0-kappa-1
                printf "Creating variant: %s\n" "$param"
                mkdir $param
                cd    $param || exit
                cp ../config.txt .

                {

                  echo Da    = $Da
                  echo phi_0    = $phi
                  echo gauss_sigma_d = $gauss_sigma_d
                  echo random_seed = $los
                  echo nodes_repulsion = $nodes_repulsion
                  echo N_tracers = $N_tracers
                  echo type_of_topology = $type_of_topology

                } >> config.txt

#               {
                 time "$karst_path"/build/karst  config.txt    >out1.out 2>out2.out
#                 } 2>time.tmp  &

             )
done


